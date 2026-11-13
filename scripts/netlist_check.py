#!/usr/bin/env python3
# Copyright (c) Eric Fogleman 2026
# SPDX-License-Identifier: Apache-2.0
"""Check xschem-generated SPICE netlists for errors xschem netlists silently.

xschem (3.4.7, batch mode) prints nothing and exits 10 on good and bad
schematics alike, so problems have to be found in the netlist it writes:

  port-unused   a .subckt port that nothing inside connects to. This is what a
                pin/label name conflict looks like: an ipin/opin/iopin and a
                lab_pin/lab_wire on the same wire with different names make
                xschem keep one name for the devices and the other for the port,
                silently, depending on instance order in the .sch.
  floating      a net (not a port) that only one device terminal touches, e.g.
                a gate whose label no longer matches anything.
  bad-param     a PDK device parameter that isn't exactly key=value with a
                known key, e.g. "nf=mult=1", a duplicate key, a stray token, or
                a missing W/L. ngspice accepts some of these without a warning.
  pin-count     an instance whose node count differs from its .subckt ports.
  stale-save    a "save" in a .control block naming a node or source that
                doesn't exist (e.g. xpll.xchp.foo after foo was renamed in the
                schematic). ngspice only warns at run time, and the signal is
                missing from the .raw file. Checked: node paths (a.b.node,
                v(...)) and i(vsource); @device[param] and "all" are skipped.

Nets xschem marks "* noconn" (bus ranges like a[1:0] expanded) are not reported as floating. Anything else that
is intentional goes in the waiver file, one per line:

    <subckt> <net>      # reason      (subckt "*" = any; "<top>" = top level)

Usage: netlist_check.py [--waivers FILE] NETLIST...   (exit 1 on any error)
"""
import argparse
import collections
import re
import sys

# Allowed instance parameters per PDK device class, and the ones required.
FET = {"L", "W", "nf", "ad", "as", "pd", "ps", "nrd", "nrs", "sa", "sb", "sd", "mult", "m"}
PDK_DEVICES = [
    # (model regex, terminals, allowed keys, required keys)
    (r"sky130_fd_pr__(special_)?[np]fet_\w+", 4, FET, {"L", "W"}),
    (r"sky130_fd_pr__res_\w+", 3, {"L", "W", "mult", "m"}, {"L"}),
    (r"sky130_fd_pr__cap_mim_\w+", 2, {"W", "L", "MF", "m", "mult"}, {"W", "L"}),
    (r"sky130_fd_pr__cap_var_\w+", 3, {"W", "L", "VM", "m", "mult"}, {"W", "L"}),
    (r"sky130_fd_pr__diode_\w+", 2, {"area", "pj", "m", "mult"}, set()),
]
# Terminal counts of SPICE primitives, by first letter
PRIM_NODES = {"R": 2, "C": 2, "L": 2, "V": 2, "I": 2, "B": 2, "D": 2,
              "E": 4, "G": 4, "F": 2, "H": 2, "M": 4, "Q": 3, "J": 3, "S": 4, "W": 2}

TOKEN = re.compile(r"""(?:[^\s'"{]+|'[^']*'|"[^"]*"|\{[^}]*\})+""")


def logical_lines(path):
    """Lines with '+' continuations joined, as (line number, text)."""
    out = []
    for n, raw in enumerate(open(path, errors="replace"), 1):
        line = raw.rstrip("\n")
        if line.startswith("+") and out:
            out[-1] = (out[-1][0], out[-1][1] + " " + line[1:])
        else:
            out.append((n, line))
    return out


def expand_bus(name):
    """Expand xschem bus notation into bit nets: "a[1:0]" -> {"a[1]", "a[0]"},
    "a,b" -> {"a", "b"}; a plain name is returned as is."""
    out = set()
    for part in name.split(","):
        m = re.fullmatch(r"(.*)\[(\d+):(\d+)\]", part)
        if m:
            hi, lo = int(m.group(2)), int(m.group(3))
            step = 1 if hi >= lo else -1
            out.update(f"{m.group(1)}[{i}]" for i in range(lo, hi + step, step))
        else:
            out.add(part)
    return out


def parse(path):
    """Return {subckt: dict(ports, devices, noconn)} with '<top>' for the top level."""
    cells = {"<top>": {"ports": [], "devices": [], "noconn": set(), "line": 0}}
    saves = []  # (line, token) from "save" commands in .control blocks
    cur = "<top>"
    in_control = False
    for n, line in logical_lines(path):
        s = line.strip()
        low = s.lower()
        if low.startswith(".control"):
            in_control = True
            continue
        if in_control:
            if low.startswith(".endc"):
                in_control = False
            elif re.match(r"save\s", low):
                saves += [(n, t) for t in s.split()[1:]]
            continue
        if not s:
            continue
        if s.startswith("*"):
            m = re.match(r"\*\s*noconn\s+#?(\S+)", s)
            if m:
                cells[cur]["noconn"].update(expand_bus(m.group(1).lower()))
            continue
        if low.startswith(".subckt"):
            t = s.split()
            cur = t[1]
            cells[cur] = {"ports": [p for p in t[2:] if "=" not in p],
                          "devices": [], "noconn": set(), "line": n}
            continue
        if low.startswith(".ends"):
            cur = "<top>"
            continue
        if s.startswith("."):
            continue
        cells[cur]["devices"].append((n, TOKEN.findall(s)))
    cells["<top>"]["saves"] = saves
    return cells


def stale_saves(cells):
    """(line, token) for each save naming a node or source that doesn't exist."""
    def scope(cell):
        """Nodes, element names, and X instance -> subckt, of one cell."""
        c = cells[cell]
        nodes, elems, subs = set(p.lower() for p in c["ports"]), set(), {}
        for _, tokens in c["devices"]:
            name = tokens[0].lower()
            elems.add(name)
            if name[0] == "x":
                _, pos, _ = split_instance(tokens)
                if pos:
                    subs[name] = pos[-1]
                    nodes.update(t.lower() for t in pos[:-1])
            elif name[0].upper() in PRIM_NODES:
                nodes.update(t.lower() for t in tokens[1:1 + PRIM_NODES[name[0].upper()]])
        return nodes, elems, subs

    def resolve(path, want):
        """Walk x-instance path; check the last part is a node or an element."""
        parts = path.lower().split(".")
        cell = "<top>"
        for p in parts[:-1]:
            _, _, subs = scope(cell)
            if subs.get(p) not in cells:
                return False
            cell = subs[p]
        nodes, elems, _ = scope(cell)
        return parts[-1] in (nodes | {"0", "gnd"} if want == "node" else elems)

    bad = []
    for n, t in cells["<top>"].get("saves", []):
        low = t.lower()
        if low == "all" or low.startswith("@"):
            continue
        m = re.fullmatch(r"([vi])\((.+)\)", low)
        if m and m.group(1) == "i":
            ok = resolve(m.group(2), "elem")
        else:
            ok = resolve(m.group(2) if m else low, "node")
        if not ok:
            bad.append((n, t))
    return bad


def split_instance(tokens):
    """X line -> (name, positional tokens, key=value tokens)."""
    pos, kv = [], []
    for t in tokens[1:]:
        (kv if kv or "=" in t else pos).append(t)
    return tokens[0], pos, kv


def check_params(model, kv, spec):
    """Errors in the key=value parameters of one PDK device instance."""
    errs = []
    allowed, required = spec[2], spec[3]
    seen = collections.Counter()
    for t in kv:
        m = re.fullmatch(r"(\w+)=(.+)", t)
        if not m:
            errs.append(f"malformed parameter '{t}'")
            continue
        key, val = m.groups()
        unquoted = re.sub(r"'[^']*'|\"[^\"]*\"|\{[^}]*\}", "", val)
        if "=" in unquoted:
            errs.append(f"malformed parameter '{t}' (more than one '=')")
        if key not in allowed:
            errs.append(f"unknown parameter '{key}' for {model}")
        seen[key] += 1
    errs += [f"duplicate parameter '{k}'" for k, c in seen.items() if c > 1]
    errs += [f"missing parameter '{k}'" for k in sorted(required - set(seen))]
    return errs


def check(path, waivers):
    cells = parse(path)
    errors = []

    def err(kind, cell, line, msg):
        errors.append(f"{path}:{line}: {kind}: [{cell}] {msg}")

    for cell, c in cells.items():
        conns = collections.defaultdict(list)
        for n, tokens in c["devices"]:
            name = tokens[0]
            kind = name[0].upper()
            if kind == "X":
                _, pos, kv = split_instance(tokens)
                if not pos:
                    err("pin-count", cell, n, f"{name}: no subcircuit/model name")
                    continue
                model, nodes = pos[-1], pos[:-1]
                spec = next((d for d in PDK_DEVICES if re.fullmatch(d[0], model)), None)
                if model.startswith("sky130_fd_pr__") and spec is None:
                    err("bad-param", cell, n, f"{name}: device {model} has no parameter rules "
                        "in netlist_check.py; add it to PDK_DEVICES")
                elif spec:
                    if len(nodes) != spec[1]:
                        err("pin-count", cell, n, f"{name}: {len(nodes)} nodes, {model} has {spec[1]}")
                    for e in check_params(model, kv, spec):
                        err("bad-param", cell, n, f"{name}: {e}")
                elif model in cells and len(nodes) != len(cells[model]["ports"]):
                    err("pin-count", cell, n, f"{name}: {len(nodes)} nodes, .subckt {model} "
                        f"has {len(cells[model]['ports'])} ports")
                else:
                    for t in kv:  # any other instance: still no "a=b=c"
                        if "=" in re.sub(r"'[^']*'|\"[^\"]*\"|\{[^}]*\}", "", t.split("=", 1)[1]):
                            err("bad-param", cell, n, f"{name}: malformed parameter '{t}'")
            elif kind in PRIM_NODES:
                nodes = tokens[1:1 + PRIM_NODES[kind]]
                model = None
            else:
                continue
            pnames = (cells[model]["ports"] if kind == "X" and model in cells else [])
            for k, node in enumerate(nodes):
                where = f"{name} pin {pnames[k]}" if k < len(pnames) else name
                conns[node.lower()].append((where, n))

        ports = [p.lower() for p in c["ports"]]

        def waived(net):
            return ((cell, net) in waivers or ("*", net) in waivers
                    or net in c["noconn"])

        for p in ports:
            if not conns.get(p) and not waived(p):
                err("port-unused", cell, c["line"], f"port '{p}' connects to nothing inside "
                    "(pin/label name conflict in the schematic?)")
        for net, who in conns.items():
            if len(who) == 1 and net not in ports and net not in ("0", "gnd") and not waived(net):
                err("floating", cell, who[0][1], f"net '{net}' touches only {who[0][0]}"
                    + (" (unconnected pin: xschem named the net)" if re.fullmatch(r"net\d+", net) else ""))
    for n, t in stale_saves(cells):
        err("stale-save", "<top>", n, f"save '{t}': no such node or source in the netlist")
    return errors


def load_waivers(path):
    w = set()
    if path:
        for line in open(path):
            line = line.split("#", 1)[0].split()
            if len(line) >= 2:
                w.add((line[0], line[1].lower()))
    return w


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--waivers", help="waiver file: <subckt> <net> per line")
    ap.add_argument("netlists", nargs="+")
    a = ap.parse_args()
    waivers = load_waivers(a.waivers)
    errors = [e for f in a.netlists for e in check(f, waivers)]
    for e in errors:
        print(e, file=sys.stderr)
    if errors:
        print(f"netlist_check: {len(errors)} error(s)", file=sys.stderr)
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
