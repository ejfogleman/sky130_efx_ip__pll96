# The efx lambda methodology (Magic)

How to lay out Sky130 analog cells by hand in Magic with the **efx** generators, on a lambda grid.

- **L (lambda) = 0.18 µm**: the drawing unit. Every width, space and generator size is a whole multiple of L, chosen at or above the Sky130 minimums. So a layout drawn on the L grid is DRC-clean by construction, and its edges line up. This L is the project's unit, not Magic's internal "lambda".
- **efx** is a set of Magic generators in `efx.tcl`, with an **efx** menu in every layout window:
  - parameterised cells (gencells): MOS, poly resistors, MiM cap;
  - painted structures: guard rings, contacts, vias;
  - a pin tool.
- **Where efx.tcl comes from.** `efx.tcl` is a copy of `~/Projects/glayout_test/magic/efx.tcl`. It is developed there, with a Python twin (`efx_primitives.py`), and a test checks that the two draw identical geometry. Recopy it from there after changes.
- **Licence.** `efx.tcl` is MPL-2.0. The designs in this repo are Apache-2.0 (see the top-level README).

Rule names below are Sky130's, from the PDK's Magic and KLayout decks.

## 1. Starting Magic

```bash
cd mag
magic <cell>                                 # reads ./.magicrc
# or, from anywhere:
magic -rcfile mag/.magicrc mag/<cell>.mag
```

**What `.magicrc` loads:**
- the Sky130 setup, `$PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc`, so `PDK_ROOT` and `PDK` (e.g. `sky130A`) must be set;
- `efx.tcl`;
- each `../dependencies/*/mag` on Magic's cell search path.

An alias that passes the PDK's own magicrc with `-rcfile` skips this file. You then get no efx menu and no dependency paths.

**Where new cells are saved:**
- **efx gencells** are saved in the folder of the cell they are placed in, wherever Magic was started. A gencell placed inside a dependency's cell is saved in that dependency's `mag/`.
- **Everything else new** goes to the folder Magic was started in:
  - a new top cell made with `load <name>`;
  - a PDK gencell;
  - an efx gencell placed in a cell that has never been saved.

Starting in `mag/` is the simplest habit.

## 2. The lambda grid

**efx → lambda grid + snap** runs `grid 0.18um` and `snap user`. The box and the cursor then move in steps of L. Do it once per window: a `grid` line in `.magicrc` has no effect, because the window opens after the file runs. `snap lambda` returns to Magic's default snapping.

**Keep every edge on the grid.** The efx tools grow an off-grid box out to the grid, with a message. The exception is the cut positions inside contacts, which Magic places itself.

## 3. Lambda widths, spaces and directions

| Layer | Width | Space | Pitch | µm (w / s) | Deck minimum (w / s) | Direction |
|---|---|---|---|---|---|---|
| poly | L | 2L | 3L | 0.18 / 0.36 | 0.15 / 0.21 (poly.1a / poly.2) | vertical (horizontal to strap multi-finger gates) |
| li1 | 2L | L | 3L | 0.36 / 0.18 | 0.17 / 0.17 (li.1 / li.3) | vertical (horizontal to close rings) |
| met1 | 2L | L | 3L | 0.36 / 0.18 | 0.14 / 0.14 (m1.1 / m1.2) | horizontal |
| met2 | 2L | L | 3L | 0.36 / 0.18 | 0.14 / 0.14 (m2.1 / m2.2) | vertical |
| met3 | 2L | 2L | 4L | 0.36 / 0.36 | 0.30 / 0.30 (m3.1 / m3.2) | horizontal |
| met4 | 2L | 2L | 4L | 0.36 / 0.36 | 0.30 / 0.30 (m4.1 / m4.2) | vertical |
| met4 carrying via4 | 7L | 2L | 9L | 1.26 / 0.36 | 1.18 (via4 + via4.4) | vertical |
| met5 | 9L | 9L | 18L | 1.62 / 1.62 | 1.60 / 1.60 (m5.1 / m5.2) | horizontal |

- **One cut fits at the default width** on every layer except poly. Poly at L can't hold a licon, which needs 0.27, so poly contacts and gate bars are 2L.
- **More cuts in a line.** The smallest lambda width that holds n cuts side by side:

  | Layer | 1 cut | 2 cuts | 3 cuts | 4 cuts |
  |---|---|---|---|---|
  | diff, poly, met1 | 2L | 4L | 6L | 8L |
  | li1 | L | 3L | 5L | 7L |
  | met2 | 2L | 4L | 6L | 9L |
  | met3, met4 | 2L | 5L | 7L | 9L |

  A line also runs past its last cut by the one-direction overlap:
  - licon: 0.08 in li1 and poly, 0.06 in diff;
  - mcon: 0.06 in met1;
  - via: 0.085 in met1 and met2;
  - via2: 0.085 in met2;
  - via3: 0.09 in met3.
- **The efx contacts follow this.** At 2L × 2L each holds one cut. Two cuts in a row need **4L** along the row: 0.53 of cuts plus L/2 at each end. In general, n mcon cuts need 0.53 + 0.36·(n − 2) + 0.18 µm, rounded up to a multiple of L.
- **Minimum area** applies to short stubs and lone pads:

  | Layer | Minimum area (µm²) |
  |---|---|
  | li1 | 0.0561 |
  | met1 | 0.083 |
  | met2 | 0.0676 |
  | met3, met4 | 0.24 |
  | met5 | 4.0 |

  For example, a 2L met3 or met4 stub must be at least 0.67 long.
- **Sheet resistance**, from Magic's extraction:

  | Layer | Ω/□ |
  |---|---|
  | poly | 48.2 |
  | li1 | 12.8 |
  | met1, met2 | 0.125 |
  | met3, met4 | 0.047 |
  | met5 | 0.029 |

## 4. The efx menu

| Entry | What it makes | What the box means | Minimum | Kind |
|---|---|---|---|---|
| lambda grid + snap | grid L, snap to it | — | — | command |
| nmos / pmos (lambda) | MOS transistor (section 5) | where it is placed | n ≥ 5 | gencell |
| ppolyres / xpolyres (lambda) | p+ poly resistor | where it is placed | nw ≥ 4 (5 for a lone resistor in KLayout) | gencell |
| mimcap (lambda) | MiM capacitor, met3 / met4 | where it is placed | nw, nl ≥ 6 | gencell |
| substrate guard ring (1.8V) | p-tap ring, 2L | the ring's **inner** edge | 3L × 3L inside | flat paint |
| n-well guard ring (1.8V) | n-tap ring + n-well | the ring's **inner** edge | 3L × 3L inside | flat paint |
| polycont | poly + li + licons | the **outer** edge | 2L × 2L | flat paint |
| mcon (li-met1) | li + met1 + mcon | the **outer** edge | 2L × 2L | flat paint |
| via1 (met1-met2) | met1 + met2 + via1 | the **outer** edge | 2L × 2L | flat paint |
| pin ... | a label made a port (section 8) | where the pin goes | — | dialog |

**Gencells:**
- They are subcells.
- A dialog sets their parameters. Re-open it on an instance to change them.
- A bad value is corrected to the nearest legal one, with a message.

**Flat paint:**
- It goes straight into the edit cell, with no label; label the net yourself (section 8).
- A box below the minimum is refused.
- It can't be re-edited: erase it and redraw.

**efx contacts fill the box.** Both metals are flush with the box and the cuts sit inside it, so every metal edge stays on the L grid. The PDK's own vias (Devices 1 menu) do the opposite: they paint the contact on the box and grow the metal past it, off the grid.

## 5. The generators

### MOS: nmos, pmos

| Parameter | Default | Meaning |
|---|---|---|
| `n` | 9 | W = n·L per finger, n ≥ 5 (W ≥ 0.90) |
| `fingers` | 2 | number of gates |
| `length` | 0.18 | gate length in µm: ≥ 0.15 (poly.1a), on a 0.01 grid |
| `butted` | off | taps butted against the outer sources (source = body); even finger counts only |
| `ltap`, `rtap` | on, on | draw the left / right body tap |
| `vt` | std | `std`, `lvt` (both), `hvt` (pmos only). lvt needs length ≥ 2L |
| `tgate`, `bgate` | nmos: top; pmos: bottom | gate bar above / below the diffusion. Both straps the gates at both ends; neither leaves bare gate fingers |

**Devices:**

| vt | nmos | pmos |
|---|---|---|
| std | `sky130_fd_pr__nfet_01v8` | `pfet_01v8` |
| lvt | `nfet_01v8_lvt` | `pfet_01v8_lvt` |
| hvt | — | `pfet_01v8_hvt` |

- lvt and hvt add the LVTN or HVTP layer L around the gates. Keep other devices 0.36 away (lvtn.3a, hvtp.4), and an LVTN gate 0.74 from an HVTP gate (lvtn.9).
- Each finger extracts as its own device, with w = n·L and l = length.

**Geometry:**
- Diffusion n·L tall. S/D columns are 2L li1 strips at a pitch of (2 + ⌈length/L⌉)·L: 3L up to a 0.18 gate, 4L up to 0.36, and so on.
- Gates have an L endcap past the diffusion.
- A gate bar is 2L of poly, L beyond the diffusion, with li1 and licons along it.
- Body taps are 2L strips of tap, 2L from the outer S/D columns, or touching them when butted.
- The n-well (pmos) runs L past the taps, or L past the diffusion where there is no tap, and L above and below.
- Magic generates the implants (0.125) and NPC itself.

**Licons per S/D column and tap:** `floor((n − 1) / 2)`.

| n | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 |
|---|---|---|---|---|---|---|---|---|---|---|
| licons | 2 | 2 | 3 | 3 | 4 | 4 | 5 | 5 | 6 | 6 |

**Pins:**
- `S0 D0 S1 D1 …` on the S/D columns. Sources and drains are not joined; wire them in the parent.
- `G` on each gate bar, sharing one port.
- `B` on each tap, sharing one port.

**Placement:**
- An nmos needs a p-tap within 15 µm (Magic's LU.2), from its own taps or from a ring.
- Diffusion to a separate tap needs 2L (diff/tap.3).
- ndiff to n-well needs 2L (diff/tap.9).
- p-tap to n-well needs L (diff/tap.11).

### Poly resistors: ppolyres, xpolyres

| | ppolyres | xpolyres |
|---|---|---|
| Device | `sky130_fd_pr__res_high_po` | `sky130_fd_pr__res_xhigh_po` |
| Sheet resistance | 319.8 Ω/□ | 2000 Ω/□ |
| Width | nw·L, nw ≥ 4 | the same |
| Body length | nl·L, nl ≥ 1 | the same |

**Geometry:**
- One vertical poly stripe: a 12L contact head, the body, and another 12L head.
- Each head holds 0.19 × 2.0 resistor licons, side by side across the width.
- Magic generates RPM/URPM, the implant and NPC.

**Extraction:**
- l = nl·L + 0.16, because poly.res runs to the cuts.
- Every lambda width extracts as the generic model with `w` and `l`.
- 4L, 8L, 16L and 32L are within 0.03 of the characterised widths 0.69, 1.41, 2.85 and 5.73.

**Pins:**
- `R1` at the bottom, `R2` at the top.
- There is no body pin; the body is the substrate or well.

**A lone 4L resistor fails rpm.1a in KLayout**: RPM must be ≥ 1.27, and Magic draws it only 0.2 past the poly. Use 5L, or place 4L resistors 2L apart, so their RPMs merge.

**Spacing:**
- Resistors of the same kind may stand 2L apart, heads aligned.
- Other poly and diffusion need 0.48 from a body (poly.9, Magic only).

### MiM capacitor: mimcap

**Device:** `sky130_fd_pr__cap_mim_m3_1`.

**Geometry and pins:**
- capm is nw·L × nl·L, with nw, nl ≥ 6 (capm.1).
- The bottom plate, met3 L past capm, is the terminal `C2`.
- The top plate, met4 L inside capm, is `C1`, with via3 packed over it.

**Capacitance:** about 2.0 fF/µm² × area + 0.19 fF/µm × perimeter. 6L × 6L ≈ 3.2 fF.

**The parent connects the plates:**
- met3 on the C2 net may butt onto the plate anywhere.
- A via2 down, or via3 up, from the plate must be ≥ 0.14 from capm (capm.8, capm.5). The L band is too narrow for one, so put it on a met3 stub off the plate.
- met3 on other nets stays 1.34 from capm (capm.11).

**Spacing between caps:** plates 7L apart (capm.2b, capm.11).

**Extraction:** `C1 C2 … w=nw·L l=nl·L`, with w across and l up.

### Guard rings (1.8 V)

**Geometry:**
- A ring of tap and li1, 2L wide, around the box. The box is the ring's **inner** edge, at least 3L × 3L.
- One row of licons runs along each side. There are none in the 2L × 2L corners.
- The implant extends L past the tap, inside and out.
- The **n-well ring** adds n-well over the inside and the ring, L past the tap.

**Labels:** none. Label the ring's net (e.g. `VSS`, `VDD`) yourself.

**Voltage:** 1.8 V only, using `psd`/`psc` and `nsd`/`nsc`, not the 5 V types.

### Contacts: polycont, mcon, via1

All three: the box is the outer edge, at least 2L × 2L, flat paint, no label.

| | polycont | mcon (li–met1) | via1 (met1–met2) |
|---|---|---|---|
| Metals | poly + li1, flush | li1 + met1, flush | met1 + met2, flush |
| Cut | licon 0.17, 0.34 pitch | mcon 0.17, 0.36 pitch | via 0.15, 0.32 pitch |
| Cuts inset from the box | (2L − 0.17)/2 = 0.095 | L/2 = 0.09 | 0.085 |
| Cuts in 2L × 2L / 10L × 3L / 6L × 6L | 1 / 5 / 3 × 3 | 1 / 5 / 3 × 3 | 1 / 5 / 3 × 3 |

- Magic measures enclosure from the contact *type*, not the cut. That's why the contact areas are inset rather than flush with the box.
- **via2 and via3 are not in the menu.** A centred 0.2 cut in 2L × 2L misses via2.4a / via3.5 by 0.005 / 0.01; 2L × 3L would work. Until they exist, use the PDK's Devices 1 vias, which put the metal off the L grid.

## 6. Gencell files and names

- **Names say what the cell is:** `nmos_n6_f2_l180_tl_tr_gb` is n = 6, 2 fingers, length 180 nm, left and right taps, bottom gate bar. The tokens, in order:
  - MOS: `n`, `f`, and `l` in nm;
  - resistors and MiM cap: `w`, `l` in L;
  - `lvt`/`hvt` only when vt isn't std;
  - flags only when set: `bt` butted, `tl`/`tr` taps, `gt`/`gb` gate bars.

  Examples: `ppolyres_w5_l10`, `mimcap_w6_l8`.
- **Why not Magic's names?** Magic names gencells `<type>_<6-character hash>`, and that hash collides: different parameters can get the same name. Magic then silently reuses the wrong cell. efx's names can't collide. PDK gencells keep the hash names.
- **A gencell's `.mag` file is the only record of its parameters** (`string parameters …`). The parent's `use` line holds only the cell name and placement. Never delete a gencell file a design uses. Move unused ones aside (e.g. into `unused/`), checking every top cell's `use` lines first.
- **The geometry is saved in the file.** A gencell saved before an `efx.tcl` change keeps its old geometry until you change its parameters.
- **To rename a cell:** run `cellname rename old new`, then `load new; save new`. A rename alone keeps saving to the old file. Never `save` with an absolute path: it is written into the parents' `use` lines.

## 7. Editing

- `erase` removes all paint in the box from the edit cell.
  - `erase m1` removes only that type.
  - `erase labels` removes only labels.
  - `erase *` removes everything.
- `erase` leaves subcells alone. `select area` then `delete` removes everything in the box, cells included.
- `u` undoes.
- **Key `a` is `select area` here** (set in `.magicrc`). Magic's default, `select visible`, also selects paint and labels inside subcells, and copying that selection (`c`) flattens a gencell's paint and pins (`S0 D0 G B`) into the edit cell. `select visible` is still available from the console.
- **Finding a top-cell label hidden under a gencell's:** `findlabel <name>` puts the box on the edit cell's own label. To delete just that label: `select area labels; delete`. Or delete its `rlabel`/`port` line pair from the `.mag` file, with Magic closed.
- Strap bare gate fingers with L-wide poly and a polycont.

## 8. Pins

**efx → pin ...** opens a dialog that stays open. Each **Apply** places one pin at the box.

| Field | Default | Notes |
|---|---|---|
| Name | — | |
| Size | L | text height, used with a named font |
| Port index | blank | blank reuses the number of a port with the same name, or takes the next free one |
| Attach to layer | m1 | "default" lets Magic pick the type under the box |
| sticky | off | keeps the label on that layer when the paint under it changes |
| Font | FreeSans | "default" is Magic's unscaled text |
| Justification | center | |
| Port class | default | input / output / inout / tristate / feedthrough |
| Port use | default | signal / analog / power / ground / clock |

- **Pin order follows the port numbers.**
  - Magic writes the extracted `.subckt` pins in port-number order.
  - xschem writes them in the order of the symbol's pins (the `.sym`).
  - So create the pins in the order of the xschem `.subckt` line, with the index blank, and the two match.
  - Netgen LVS matches pins by name, so order matters only when something calls the layout netlist by position.
  - To renumber later, use `port <name> index <n>`.
- **A second label for the same net**, e.g. `vdd` on two straps, gets the same number automatically.
- **Box size:**
  - A point box makes a text label only.
  - An area box also writes a pin rectangle (e.g. met1 68/16) the size of the box.
  - Extraction, LVS and Magic's LEF ignore the difference: the LEF pin is the whole connected metal either way.
  - Use an area pin only where a GDS-reading tool needs pin shapes: 2L × 2L for signals, the bus for supplies.
- **Class and use** go only to the `.mag` file and LEF (`DIRECTION`, `USE`). Set `power` / `ground` on supplies if the cell may become a macro.
- **A pin connects only to paint in its own cell.** A top-cell label sitting on a gencell's li (e.g. a gate bar) extracts as a disconnected node. Put some of the top cell's own paint under it, e.g. `findlabel inp; paint li`, or the route that feeds it.
- **Put pins on plain metal, not on a contact.** Magic attaches a label to the type under it, which on `viali`, `via1` or `pc` is the contact.
- **What the dialog refuses:** a box that already holds a label (Magic's `port make` needs exactly one), and a port number already used by another name. It warns about a pin with no paint under it.

## 9. Checking: DRC, extraction, LVS

**DRC in Magic:**
```tcl
drc check; drc why            ;# in the box
drc listall why               ;# whole cell
```

**KLayout DRC**, on GDS written with `gds write <cell>.gds`. Use absolute paths:
```bash
klayout -b -r $PDK_ROOT/$PDK/libs.tech/klayout/drc/${PDK}_mr.drc \
  -rd input=$PWD/<cell>.gds -rd report=$PWD/<cell>.lyrdb \
  -rd feol=true -rd beol=true -rd offgrid=true
```

**LVS.** From the repo root, `make lvs CELL=<cell>` runs the three steps below and checks the report (see the top-level README). By hand, LVS compares the layout netlist with the schematic netlist in `<project>/lvs/`, one folder per source, each holding `<cell>.spice`:

```
lvs/
  schematic/<cell>.spice    # from xschem
  layout/<cell>.spice       # from Magic, with its .ext files
  <cell>.out                # Netgen report
```

Netgen matches circuits by the `.subckt` name, which must be `<cell>` in both netlists. The file names only tell you which is which.

1. **Schematic netlist**, as a `.subckt`. Run in `xschem/`. `-o` overrides the usual `sim/` netlist folder:
   ```bash
   xschem -n -s -q -x --tcl 'set top_is_subckt 1' -o ../lvs/schematic <cell>.sch
   ```
2. **Layout netlist.** Run in Magic, started in `mag/` (or anywhere, with `-rcfile mag/.magicrc`; then adjust the paths):
   ```tcl
   load <cell>
   extract path ../lvs/layout     ;# .ext files there, not beside each .mag
   extract all
   ext2spice lvs
   ext2spice -p ../lvs/layout -o ../lvs/layout/<cell>.spice
   ```
   Without `extract path`, `.ext` files are written beside each cell's `.mag`, including inside `dependencies/`.
3. **Compare.** Run in `lvs/`:
   ```bash
   netgen -batch lvs "layout/<cell>.spice <cell>" "schematic/<cell>.spice <cell>" \
     $PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl <cell>.out
   ```
   Look for "Circuits match uniquely" at the end of `<cell>.out`.

These steps passed on a hand-drawn efx design, `ejf_sacomp` (a clocked comparator, 11 devices), against its xschem schematic on 2026-11-06: "Circuits match uniquely", with no property errors. What it took:
- **A pin on gencell paint is a floating pin.** It needs paint in its own cell (section 8).
- **Stray gencell pins** (`S0`, `D0`, `G`, `B`) copied into the top cell join up with your own pins and rename them (section 7). Netgen then reports "failed pin matching".

The netlists, `.ext` files and report are ignored by git (`*.spice`, `*.ext`, `*.out` in `.gitignore`); only the folders are kept (`.gitkeep`).

**Expected messages:**
- An nmos with no p-tap within 15 µm gives LU.2 in Magic.
- A lone 4L resistor fails rpm.1a / urpm.1a in KLayout.

## 10. Not covered yet

- via2 / via3 generators (section 5).
- S/D straps: sources and drains must be wired by hand.
- 5 V devices and rings.
