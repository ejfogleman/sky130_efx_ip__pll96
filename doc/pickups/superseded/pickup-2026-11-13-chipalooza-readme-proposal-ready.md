# Fresh-context pickup -- README ready as the Chipalooza #4 proposal; regressions pass with C-extracted lvdig cells

**Written**: 2026-11-13, superseding `pickup-2026-11-10-pll-locking-sims-tsim-vc-check.md`
**Repo**: sky130_efx_ip__pll96, branch `main`
**HEAD**: `a69722d` -- "Updated README". The working tree was clean when this was written; only this memo and the move of the prior one are uncommitted. When committing, end the message with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

Project background: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md` (layout, tools, sim workflow, lvdig include, checks, configs). Tools come from `nix develop ~/nix-efx` (xschem 3.4.7, ngspice-43, magic 8.3.604, netgen); the PDK is at `~/.ciel/sky130A`, open_pdks `54435919abffb937387ec956209f9cf5fd2dfbee`.

**Chipalooza** is the open-source analog IP challenge this block is entered in. Its rules are copied in `/home/ejf/Projects/sky130_efx_ip__pll96/doc/chipalooza.md`. Proposals are due 2026-11-23, and the README is the proposal document.

## 1. What landed this session

All of this work was committed by the user (newest first):
- `a69722d`, `96d006a`, `dcec28b` -- README updates by the user: the Test Plan, the *off* row in Programming, wording.
- `d1cbc1c` -- "Divider update, repo cleanup, and Chipalooza documentation". It covers the whole multi-day stretch since `afa3e7b`: the `div_f` divider, the ejf→efx rename, the lvdig submodule, and the items below.

What this session added inside those commits:

**Simulation**
- **lvdig switch:** the lvdig submodule is now at `a2b2ced`, whose symbols are `type=primitive`. Seven testbenches include the C-extracted cell netlist through a collapsed code block `s4`; see CLAUDE.md for the details.
- **Locking regression:** all 9 modes LOCK pass with the C-extracted cells.
  - f_err is −140 to +78 ppm.
  - vc settles at 0.47–0.48·VDD, with vc_pp under 0.7 mV.
  - Total current is 154 µA (4 MHz) to 174 µA (16 MHz), or 277–312 µW, at tt/27 °C.
  - vdd_div rose from about 43 to 60–64 µA versus the schematic-level cells. The likely cause is the extracted capacitance (unverified).
  - Run times were 62 min (16 MHz) to 213 min (4 MHz), with 8 runs in parallel at 1 thread each.
  - Results are in `/home/ejf/Projects/sky130_efx_ip__pll96/sim/top_reg_<F>.{out,raw}`. These files are git-ignored and exist only locally.
- **Lock check tightened** from ±0.5% to **±0.25%**, which is the README's Frequency Accuracy spec. The change is in `tb_efx_pll96_top_reg.sch` and `tb_efx_pll96_top_template.sch`. The regression above ran with the 0.5% check, but every mode is far inside 0.25% (max 0.014%).
- **div_f Fmax with C-extracted cells:** tt/1.8 V/27 °C passes at 811 MHz and fails at 820. ss/1.62 V/85 °C passes at 487–525 MHz and fails at 500–550, depending on the code. The VCO needs about 106 MHz, so the margin is about 4.6× at ss. That is about 30% lower than with schematic-level cells (717 MHz at ss).

**Checks and build**
- **`netlist_check.py`** now expands bus `noconn` names (`a[1:0]` → `a[1]`, `a[0]`).
- **Waivers:** the user replaced all six waivers with `noconn` symbols. The waiver file moved to `/home/ejf/Projects/sky130_efx_ip__pll96/xschem/netlist_waivers.txt` and holds only its header.
- **Makefile:** new `make clean` (runs `clean-lvs` and deletes `sim/*.spice.bad`/`.err`, keeping netlists and sim results) and `make help` (prints the target list from the Makefile's top comment).
- **File modes:** the execute bits were removed from all `.sch` and `.sym` files.

**Licensing and repo**
- **Title block:** `title_efx.sym` was rewritten as Apache-2.0. The old version was derived from xschem's GPL title block. The same change went into `~/Projects/sky130_efx_ip__template` and lvdig.
- **lvdig is public now** on GitHub, as is pll96. A public `--recurse-submodules` clone works.

**Docs and Python**
- **Notebook:** the user moved it to `doc/pll-filter/pll-filter.ipynb`, and that folder is **git-ignored** (unpublished). I fixed its invalid JSON escapes, and it runs.
- **`requirements.txt`** at the repo root pins `sympy==1.14.0` and `jupyterlab==4.6.6` for it. `.venv/` is at the root and git-ignored.
- **Diagram:** `doc/pll96_diagram.png` is a white-background render of the top schematic.

**README, prepared as the proposal**
- **Sections:** IP Overview, IP Specifications, IP Pinout, Harness Resources, Test Ports (with the `vco_tst` code table), Programming, Test Plan, and Reproducing the Results.
- **Programming table:** has `divr_en`/`chp_en`/`vco_tst` columns and an *off* row.
- **Harness Resources:** uses 20 of 24 digital controls, 1 of 2 current sources, and 3 of 3 dedicated pins. The pins are a `vdd_ref` pad, a `vdd_vco` pad, and one digital I/O pad fed by a 2:1 mux with `clk_sel` choosing 96 or 48 MHz.
- **Equipment list:** it named an institution, so it moved to `/home/ejf/Projects/sky130_efx_ip__pll96/doc/submission/equipment.md`, which is **git-ignored**. Rule 6 says to send it separately.

**Decisions settled (don't re-litigate)**
- **Supply spec stays 1.62–1.98 V (±10%).** This is the user's decision, even though sky130's 1.8 V FET models are documented as valid only to 1.95 V.
- **No Absolute Maximum Ratings section.** The user's reasoning: such limits come from the process, not the design. The spec table holds the design's min and max limits.
- **README specs are budgets with post-layout margin.** Put sim results beside them; don't replace them (memory `spec-margin.md`).
- **The 4/8/12/16 MHz runtime note in the README is approximate** and was left as written.

## 2. Current state / gate status

From `/home/ejf/Projects/sky130_efx_ip__pll96`, inside `nix develop ~/nix-efx`:
```
make sim          # 10 "netlist sim/tb_*.spice" lines, no FAIL, no sim/*.bad; expect "Error 10 (ignored)" noise
make check        # every "sch_check: N schematics ok"; netlist_check silent
make help         # prints the target list
grep -c 'lt 0.0025' sim/tb_efx_pll96_top_reg.spice   # 1 (the +/-0.25% lock check)
grep LOCK sim/top_reg_*.out                          # 9 "LOCK pass" lines (local files from the 0.5% run)
```
Before running any sim, follow the user's rule (memory `renetlist-before-sim.md`):
- Check `pgrep -xa xschem; pgrep -xa magic`. If a session is open or a schematic is newer than its netlist, alert the user before starting.
- Re-netlist with `make`.
- State the netlist revision you ran.

## 3. What's still to do

1. **Proposal polish before 2026-11-23** (README; minutes each):
   - **Input frequency row:** it has no unit (MHz), and its note omits the 5 and 10 MHz modes.
   - **`clk_sel`:** say whether the output mux lives in the slot wrapper (as Harness Resources implies) or in `efx_pll96`. If it's inside the IP, add `clk_sel` and the mux output to IP Pinout. The mux isn't in any schematic yet.
   - **Duty cycle row:** it covers only 48 MHz, not 50 MHz or `clk_out`.
2. **Optional proposal strengthening** (needs the user's input):
   - **Test plan methods:** one line per item, e.g. tuning curve via `chp_en`=0 and stepping `vco_tst`; lock time by toggling `divr_en`; per-domain current on the `vdd_ref`/`vdd_vco` pads.
   - **Missing specs:** reference clock input requirements, the tolerance on the 1 µA bias, max power, and power-down current.
3. **Unverified claims in the README:**
   - **Pad interface:** the claim that the sky130 GPIO pad takes a 1.8 V core-side signal and shifts it to 3.3 V wasn't checked against the pad documentation.
   - **Bias polarity:** `ibnp_1u` is described as sunk by the harness source. The harness current-reference spec isn't published yet.
4. **Leftover old cells:** `xschem/ejf_pll96_chp.{sch,sym}` and `xschem/ejf_pll96_lpf.{sch,sym}` are tracked, and nothing references them. Ask the user before deleting them.
5. **Diagram:** `doc/pll96_diagram.png` comes from the schematic as saved 2026-11-11, before the `noconn` symbols were added. Re-export it after the next top-level schematic change: `rsvg-convert -z 2` on the xschem SVG, after swapping `#ffffff`/`#000000` in a copy.
6. **Template sync:**
   - `~/Projects/sky130_efx_ip__template` has uncommitted changes (`D xschem/title.sym`, `M xschem/title_efx.sym`), which the user hasn't committed.
   - Its `.gitignore` still has the stale `!sim/requirements.txt` line.
   - The Makefile changes (exit-10 handling, checks, `clean`/`help`) haven't been propagated to it.
7. **Deferred by the user:**
   - **`make drc` and `make pex`** targets. Gotcha found: magic's `drc count` and `drc why` report only the top cell's own errors, and only `drc listall count` / `drc listall why` include the subcells. On `efx_pll96_dbuf`, which is an old layout that isn't expected to be clean, `drc count` says 0 while `drc listall count` finds 6 met1.6 errors in the two PDK FET subcells.
   - **Extraction** should reuse lvdig's flattened flow (`/home/ejf/Projects/sky130_efx_ip__lvdig/Makefile`, `lvs/pex_{none,c,rc}`).
8. **Considered, not started:** a `work/` launch directory, as in Carsten Wulff's repos. It's a three-repo restructure (template first), and the user hasn't decided.
9. **Older open items:**
   - The `tb_efx_pll96_top` bench runs `tran 1n 5u` but measures at 18–20 µs.
   - `netlist_check.py` doesn't catch a missing lvdig include.
   - chp has a dangling XR13/XR14 resistor chain.
   - `sdiv_mm_reg` is stale (uses removed params); leave it alone unless asked.

## 4. Relevant references

- Project guide: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`; proposal and spec: `/home/ejf/Projects/sky130_efx_ip__pll96/README.md`; rules: `/home/ejf/Projects/sky130_efx_ip__pll96/doc/chipalooza.md`.
- Prior pickups: `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-10-pll-locking-sims-tsim-vc-check.md`, `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-10-div-f-feedback-divider.md`.
- lvdig dependency: `/home/ejf/Projects/sky130_efx_ip__pll96/dependencies/sky130_efx_ip__lvdig` (submodule at `a2b2ced`; source repo `/home/ejf/Projects/sky130_efx_ip__lvdig`).
- Scratch (this session only, may be gone): `/tmp/nix-shell.HoGMN0/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/`, holding:
  - `reg_lvdigc/`: regression run directories
  - `fmax2/`: div_f Fmax scripts and logs
  - `lvdiginc/`: testbench backups
- Memory: `renetlist-before-sim.md`, `ngspice-threads-parallel.md`, `pgrep-self-match.md`, `spec-margin.md`.

## 5. Recommended next-session opening move

From `/home/ejf/Projects/sky130_efx_ip__pll96`, run `git status --short` and `git log --oneline -3` to see whether the user has changed anything since `a69722d`. Then run `make sim && make check` inside `nix develop ~/nix-efx` to confirm every netlist still passes, after checking for open xschem/magic sessions first. Then read the README top to bottom against rule 6 in `doc/chipalooza.md` and offer the three small fixes in item 1 of section 3. The proposal is due 2026-11-23, so those take priority over the DRC/PEX targets or the `work/` restructure.
