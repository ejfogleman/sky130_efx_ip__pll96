# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Analog/mixed-signal IP for SkyWater sky130: a 96 MHz integer-N clock-multiplier PLL (4–16 MHz reference in, 96 MHz and 48 MHz out). The design is captured as xschem schematics and simulated with ngspice. There is no software build; "code" is `.sch`/`.sym` files plus SPICE control blocks embedded in testbench schematics. `README.md` holds the spec table, pinout, and the per-reference-frequency programming table (the source of truth for divider/filter/charge-pump settings).

## Repository layout

The repo follows `~/Projects/sky130_efx_ip__template` (same `Makefile` except the xschem exit-code handling below, `xschem/xschemrc`, `mag/.magicrc`, `mag/efx.tcl`, `.gitignore`); keep it in sync with that template rather than diverging. `xschem/` schematics and symbols, `sim/` testbench netlists and ngspice runs, `mag/` layout, `lvs/` generated LVS netlists and reports (git-ignored), `dependencies/` other IP blocks as git submodules (loaded automatically by `xschemrc` and `.magicrc`). `mag/efx.tcl` is MPL-2.0 (`LICENSE-MPL-2.0`) and is a copy of `~/Projects/glayout_test/magic/efx.tcl`, so don't edit it here; everything else is Apache-2.0. `mag/README.md` documents the efx lambda-grid layout method.

## Tooling and environment

- Tools come from `nix develop ~/nix-efx`: xschem, ngspice, magic, netgen. `PDK`/`PDK_ROOT` default to `sky130A` / `~/.ciel`.
- Run xschem in `xschem/` and magic in `mag/` so their rc files are read. `xschemrc` sets `netlist_dir` to `../sim`.
- Testbenches hard-code the PDK model path to the ciel install: `~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice` (corner `tt`).
- Digital cells come from the **`sky130_efx_ip__lvdig`** dependency (git submodule at `dependencies/sky130_efx_ip__lvdig`; clone with `--recurse-submodules` or run `git submodule update --init --recursive`). Instances are `sky130_efx_lvdig__<cell>.sym` with power/body as instance properties (`VGND= VNB= VPB= VPWR=`), like the PDK's `sky130_stdcells` symbols they replace. They are `type=primitive` symbols, so xschem writes only the `X…` instance lines, not the cells' `.subckt`s; `e` still descends into a cell's schematic. Every testbench whose hierarchy uses lvdig cells (`div_f`, `pfd`, `sdiv_mm`, `sdiv_mm_reg`, `top`, `top_reg`, `top_template`) therefore includes the library netlist once, in its own collapsed code block `s4` (`devices/code.sym`, below `s1`): `tcleval(.include $::LVDIG_SPICE/sky130_efx_lvdig_c.spice)`, the layout-extracted cells with C parasitics. Use the C-extracted netlist, not the schematic CDL (`$::LVDIG_CDL/sky130_efx_lvdig.cdl`); `_rc` and plain `sky130_efx_lvdig.spice` also exist, and all four have the same port order. `LVDIG_SPICE`/`LVDIG_CDL` are set by lvdig's `xschemrc`, which ours loads, and expand to absolute paths, so the tracked `sim/*.spice` netlists contain the local repo path. A new testbench that uses lvdig cells needs the same block; `netlist_check.py` does not catch a missing include, ngspice fails on the unknown subcircuit. The lvdig netlists are generated in lvdig (`make libnet`) and come with the submodule commit; update with `git submodule update --remote dependencies/sky130_efx_ip__lvdig`, then re-netlist. Don't mix them with PDK `sky130_fd_sc_*` cells: lvdig's port order differs. A cell that lvdig doesn't have gets added there, not taken from the PDK.
- xschem in batch mode exits 10 and prints nothing whether or not the schematic has errors. The `Makefile` ignores the exit code and checks the output instead; expect `Error 10 (ignored)` lines from `make`.
- xschem netlists some schematic errors silently: a pin (`ipin`/`opin`/`iopin`) and a label (`lab_pin`/`lab_wire`/`lab_show`) with different names on one wire (it keeps one name, depending on instance order, leaving a port connected to nothing), and malformed device parameters such as `nf=mult=1`. Every netlist `make` writes gets two checks: `scripts/sch_check.sh` runs `scripts/sch_check.tcl` inside xschem on each schematic in the netlist's hierarchy (every pin/label must name the net xschem resolved where it sits, and must connect to something, by wire, device pin, same-named label or property), and `scripts/netlist_check.py` checks the netlist (unused subckt ports, nets touching one terminal, PDK device parameters not exactly `key=value` with a known key, `save` commands naming a node or source that no longer exists). A failing netlist is renamed `<netlist>.bad` and `make` fails. xschem batch scripts need `-r` (no readline) or they hang when stdin/stdout aren't a terminal. Intentional exceptions go in `xschem/netlist_waivers.txt`; prefer the `noconn` symbol in the schematic. `NETLIST_CHECK=0` skips the check, and the netlist then counts as up to date, so run `make check` afterwards; never use it for regressions.

## Commands (from repo root)

```bash
make sim                              # netlist every xschem/tb_*.sch into sim/
make sim/tb_efx_pll96_top_reg.spice   # one testbench
make lvs CELL=efx_pll96_dbuf          # xschem + magic netlists, then netgen; fails on mismatch
make clean-lvs
make check                            # re-run both checks on sim/tb_*.spice
make clean                            # clean-lvs + failed netlists (sim/*.spice.bad); keeps sim results
make help                             # list the targets
```

## Simulation workflow

1. `make sim` to netlist. Testbench netlists in `sim/` are tracked in git; `*.raw`, `*.out`, `*.log` are ignored.
2. Run ngspice in batch from `sim/` (so `sim/.spiceinit` is read):
   - Single run: `ngspice -b -o top_reg.out tb_efx_pll96_top_reg.spice` (uses whatever `config.inc` currently holds).
   - Full regression over all reference frequencies: `./top_reg.sh` (top-level PLL) or `./sdiv_mm_reg.sh` (feedback divider only). Each copies `config_<F>.inc` → `config.inc`, runs ngspice, and renames outputs to `top_reg_<F>.{out,raw}` / `sdiv_mm_reg_<F>.{out,raw}`.
3. Results: `.meas` values (supply currents on `vdd_ref`/`vdd_vco`/`vdd_div` averaged over the last 2 µs, `clk_out` period/frequency 1 µs before the end) and one `LOCK pass|fail` line. A run locks only if `clk_out` (10-period average) is within 0.25% of the target N/(R·T_REF) **and** the loop-filter node `xpll.vc` has settled (1 µs averages over the last 2 µs differ by < 1% VDD) at 0.25–0.75 × VDD. The target is derived in the control block from the `VC*`/`VR*` bits and `T_REF`, so it follows the programmed dividers. `T_VCO` in the configs is used only by the old `sdiv_mm_reg` bench (ideal VCO clock period). Always check `vc`, not just the frequency appear in the `.out` file; waveforms in `.raw`.

### Per-mode configuration

`config_<F>.inc` files (`4, 5, 5w, 6, 8, 10, 10w, 12, 16` MHz; `w` = wider loop bandwidth variant) set `T_SIM` (transient length, ~100·T_REF: longer than the ~60·T_REF lock-time spec in the README, to observe settled behavior; the top-level benches pass it to the control block with `.csparam` and measure over the last 2 µs) and `.param`s that drive the testbench's control-pin voltage sources: `T_REF`, `VR*` (divr_r: 00→R=1, 01→2, 1x→4), `VC0`–`VC4` (divf_c, = N−1), `VCPB*` (chp_b), `VCSC` (lpf_csc), `VRSC*` (lpf_rsc). Bits are 0 or 1.8 V. `config.inc` is the scratch copy that the scripts overwrite (committed as a copy of `config_16.inc`). When adding a mode or changing settings, keep the config files and the README programming table consistent.

## Design hierarchy

Top cell `efx_pll96.sch` instantiates: `div_r` (reference divider) → `pfd` → `chp` (charge pump with replica) → `lpf` (loop filter, programmable R/C scale) → `vco` (differential ring oscillator built from `vco_dlycell`, with `vco_ls` level shifter) → `outbuf`/`dbuf`/`diff_buf`, and `div_f` as the feedback divider.

- Feedback divider `div_f` is a 5-bit synchronous down-counter clocked by the VCO (on the inverted clock): `edfxbp_1` toggle flops with load muxes, a borrow chain, terminal count at 0, and a registered terminal count as the output. Program `divf_c = N−1`, N = 2–32. `tb_efx_pll96_div_f` sweeps every code and prints one `DIVF c= N= idd=` line per code. The previous dual-modulus N·P+S divider (`sdiv_mm`, `sdiv23`, `sdiv_p`, `sdiv_s`) is no longer used by the top cell; its `sdiv_mm_reg` bench uses the removed `VS*`/`VP*`/`VEN*` params. The older asynchronous divider (`div_mm`, `div23`, `div_p`, `div_s`) was deleted; it is in git history before the switch to lvdig.
- Three separate supply domains (`vdd_ref/gnd_ref`, `vdd_vco/gnd_vco`, `vdd_div/gnd_div`) are kept distinct through the hierarchy; preserve this when editing.
- Testbenches: `tb_efx_pll96_<block>.sch` for block-level tests; `*_reg.sch` are the regression benches driven by `config.inc`. `top_reg.sch` + `tb_efx_pll96_top_template.sch` are an alternate arrangement where the control deck includes a separately netlisted template. Schematics use `title_efx.sym`.
- `doc/pll-filter.ipynb` contains the loop-filter design calculations (sympy); `doc/pll-filter/` is a markdown rendering of the related PDF.
