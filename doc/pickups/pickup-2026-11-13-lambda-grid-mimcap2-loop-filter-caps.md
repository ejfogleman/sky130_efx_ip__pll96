# Fresh-context pickup -- lambda-grid MOS sizes (uncommitted), M4 MiM generator, loop-filter MOS-cap study

**Written**: 2026-11-13 (evening); section 2a (loop-filter unit cap) added 2026-11-14. Supersedes `pickup-2026-11-13-chipalooza-readme-proposal-ready.md` (written earlier the same day, never committed; its still-open items are carried forward below)
**Repo**: sky130_efx_ip__pll96, branch `main`
**HEAD**: `a69722d` -- "Updated README". Everything in section 1 is **uncommitted**. When committing, end the message with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

Project background: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`. Tools come from `nix develop ~/nix-efx` (xschem 3.4.7, ngspice-43, magic 8.3.604, netgen, klayout); PDK at `~/.ciel/sky130A`. **Chipalooza** #4 is the analog IP challenge this PLL is entered in; rules in `/home/ejf/Projects/sky130_efx_ip__pll96/doc/chipalooza.md`; the README is the proposal, due **2026-11-23**. "Lambda grid" = the user's layout grid with L = 0.18 µm; efx MOS widths are W/finger = n·0.18 µm with n ≥ 3 (see `/home/ejf/Projects/sky130_efx_ip__pll96/mag/README.md`).

## 1. What changed this session (uncommitted working tree)

**Lambda-grid MOS migration** (user's rules; all 98 MOS now on grid):
- Rules: minimum-L (0.15 µm) devices round W to the nearest grid value and keep L; longer devices preserve W/L ratio.
- Seven schematics changed, W/L lines only (plus two trailing tabs removed in `vco_dlycell`): `xschem/efx_pll96_{chp,dbuf,diff_buf,lpf,vco,vco_dlycell,vco_ls}.sch`. The seven affected `sim/tb_*.spice` netlists were regenerated with `make sim`, and all 10 benches netlist and pass the checks.
- **chp choices, all made by the user:**
  - L = 1.2 current sources: 0.6/1.2 → 0.72/1.44; MP2_1P5: 0.9 → 1.08/1.44.
  - L = 0.35 PMOS (×1.2): 0.72/0.42 and 1.44/0.42; MP1C nf5 W = 7.2.
  - L = 0.3 NMOS cascodes: 0.72/0.36; M1C W = 3.6 nf5.
  - Min-L switches: 1.0 → 1.08, 1.2 → 1.26, 0.6 → 0.54.
  - MOS caps: 8/2 nf2 → 7.92/1.98.
- **Other cells:**
  - diff_buf: MP40 0.63 and MP41 0.64 both → 0.72. The user said the old mismatch was a layout tweak that is no longer needed.
  - vco_dlycell MN: 1.22/0.44 → 1.26/0.45.
  - lpf: 6/11 → 5.94/10.89; 10 → 10.08.
  - vco: 24/2.4 nf4 → 23.76/2.38; 1 → 1.08; 2 → 1.98.
  - vco_ls: 2 → 1.98, 4 → 3.96.
  - dbuf: 1.2 → 1.26, 0.74 → 0.72.
- **Effect, DC/open-loop only:**
  - chp up current within ±1% (5.04→5.05, 7.42→7.37, 9.89→9.99 µA).
  - Static both-on residual at vc = 0.85 V rose 0.42→0.47, 0.56→0.63 and 0.69→0.78 µA.
  - VCO shifted −1.8% uniformly (vc 0.85 V: 98.6 → 96.8 MHz); ivco unchanged.
- **Backups** of the original schematics: scratchpad `lambda/*.sch.orig` (path in section 4).

**`mag/efx.tcl` recopied** from `~/Projects/glayout_test/magic/efx.tcl`. The pll96 copy had been stale, missing the n ≥ 3 MOS rule and the new mimcap2. `mag/README.md` was recopied from lvdig's updated version and gained a "MiM capacitor on met4: mimcap2" section (14L×14L ≈ 14.6 fF). The lvdig and template copies of `efx.tcl` are still stale.

**M4 MiM generator `mimcap2`**, added in `~/Projects/glayout_test` (not a git repo; backups in `magic/backup-2026-11-13-mimcap2/`):
- **Code:**
  - `efx_primitives.py` gains `mimcap2()` and `mimcap2_size_error()`; model `sky130_fd_pr__cap_mim_m3_2`; ports `C2_met4_*` and `C1_met5_*`.
  - `magic/efx.tcl` gains `efx::mimcap2_*`, a menu entry "mimcap2 met4/met5 (lambda)", default 14×14.
- **Size rules:** nw, nl ≥ 11 (m5.1) and (nw−2)(nl−2)·L² ≥ 4.0 µm² (m5.4). So 14×14 is the smallest square, 11×16 the narrowest, and 13×13 fails.
- **Stacking:** a mimcap and a mimcap2 of the same nw, nl at the same origin share met4, with mim2cc inside mimcc. Extraction gives both caps.
- **Tests:**
  - New cells c2_min, c2_wide, c2_pair and cs_stack bring the total to 45. All pass `compare_efx.py`.
  - `verify.sh` gives Magic and KLayout DRC 0.
  - m_cs_stack extracts both caps on one net, a flatten/same-label harness artifact like m_c_pair.
- **Docs:** glayout_test `CLAUDE.md` and `docs/efx-magic-flow.md` updated.

**Memory added**: `magic-drc-listall.md`. Magic's `drc count` and `drc why` miss errors inside subcells; use `drc listall count` / `drc listall why`.

## 2. Loop-filter capacitor study (findings; answers given to the user, nothing changed in the design)

The user plans to stack a MOS cap, an M3 MiM and an M4 MiM for the loop filter. **The user has ruled out a PMOS cap with its well on ground for this design.**

**MiM facts**
- There is no DRC maximum size. The PDK generator limits W and L to 2–30 µm. A 30×30 µm cap is ≈ 1.82 pF typ (1.60 low, 2.05 high).
- Area capacitance is 2.0 fF/µm² (2.231 high, 1.778 low); fringe is 0.19 fF/µm.
- **capm.10:** capm must not straddle nwell, diff, tap, poly, li1 or met1. Each such shape must be wholly inside or wholly outside the capm outline.
  - Neither the Magic nor the KLayout deck checks this rule, so it must be met by construction.
  - No cap2m equivalent is published.
  - For a MOS cap under a MiM, either cover the whole MOS cap (including taps and met1) with capm, or keep those six layers clear of the capm edge.

**Oxide capacitance:** 8.2 fF/µm² for the 1.8 V PMOS (4.23 nm), 2.9 fF/µm² for the 5 V devices (11.6–11.75 nm).

**Thresholds** (BSIM4 `vth` at the operating point, tt, 27 °C, W = 10 µm, Vsb = 0):

| L (µm) | nfet_g5v0d10v5 | pfet_g5v0d10v5 \|Vth\| |
|---|---|---|
| 0.5 / 1 / 2 / 4 / 10 | 0.84 / 0.82 / 0.80 / 0.80 / 0.79 | 0.95 / 0.99 / 1.02 / 1.01 / 1.01 |

- PMOS ss and ff are about ±50 mV from tt.
- NMOS body effect at L = 10: Vth = 0.79, 0.99, 1.14 and 1.34 V for Vsb = 0, 0.5, 1.0 and 1.8 V.

**C-V results** (ngspice AC at 1 MHz, W = L = 10 µm, nf = 1, values in fF/µm²):

| 5 V NMOS connection | vc 0.45 | 0.85 | 1.35 | Notes |
|---|---|---|---|---|
| Gate = vc; S/D + body = 1.8 V, in DNW (accumulation) | 2.79 | 2.65 | 1.68 | Flat to within 5% for vc ≤ 0.85 V. At 85 °C, 0.85 V gives 2.53; corner spread ±2%. |
| Gate = vc; S/D + body = 0 (inversion) | ≈2.1 | 2.76 | 2.86 | Steep below about 0.6 V |
| Gate = vc; S/D = 1.8 V, body = 0 (depletion) | 1.05 | 0.93 | 0.83 | Neither accumulation nor inversion; a third of Cox |

- The ruled-out PMOS with its well on ground gave 2.6, 2.75 and 2.78 at the same vc points. The 1.8 V devices give about 2.8× more per area, with the same curve shapes.
- Accumulation depends on Vgb relative to flat-band (about −0.9 V for the NMOS). Source/drain voltage only affects inversion.
- **Rough stack estimate** (arithmetic, not simulated): the DNW NMOS plus two MiMs gives about 6.8 → 5.7 fF/µm² over vc 0.45 → 1.35 V, a 16% swing.

**DNW for the 5 V NMOS** is allowed. Magic extracts the body as an isolated p-well inside dnwell. The costs:
- dnwell width ≥ 3 µm and spacing ≥ 6.3 µm.
- An nwell ring overlapping the DNW edge by 0.4 µm outside and 1.03 µm inside.
- Other nwell ≥ 4.5 µm from the DNW.
- No P+ diffusion straddling the DNW edge (dnwell.5).

DNW must sit at or above the body potential. If the body is tied to 1.8 V, that rail's noise couples onto vc.

**Gate leakage:**
- The sky130 models set `igcmod = igbmod = 0` for all four devices, so the simulated gate current is zero. Their tunneling coefficients look like uncalibrated defaults.
- **5 V oxide:** tunneling is negligible.
- **1.8 V oxide:**
  - Literature (Lee & Hu, IEEE TED 2001, DOI 10.1109/16.930653, measured 1–3.6 nm) says PMOS in inversion leaks about 10× less than NMOS (hole barrier ≈ 4.5 eV against 3.1 eV for electrons), and accumulation leakage is about equal for both.
  - No measured number for an oxide around 4 nm was found; the papers are paywalled.
- **Leakage budget:** static phase offset Δt ≈ (I_leak/I_cp)·T_ref. With I_cp of 5–10 µA, about 8 nA is 0.1% of I_cp.
- **Compensation:** replica sense-and-cancel, leakage recycling, or a capacitance multiplier. Probably unnecessary at 4 nm oxide.
- **Silicon test:** with `chp_en = 0`, I_leak = C·dV/dt from the drift of vc.

**Superseded by section 2a (2026-11-14):** the 5 V candidates above were not chosen. The 1.8 V LVT PMOS stack below was chosen instead.

## 2a. Loop-filter 1.8 pF unit cap (designed 2026-11-14; layout started by the user, not yet in `efx_pll96_lpf.sch`)

**Settled decisions (don't re-litigate):**
- Unit cell is a stack of three caps:
  - a `pfet_01v8_lvt` MOS cap in inversion: gate on the filter node, S/D/B on VDD (the existing lpf uses this connection);
  - an M3 MiM (`cap_mim_m3_1`, efx `mimcap`);
  - an M4 MiM (`cap_mim_m3_2`, efx `mimcap2`).
- The PMOS has **2 fingers**, butted taps on both sides, and **a bottom gate bar only**. The user rejected the top+bottom gate-bar variant ("let's stay with one side gate only").
- A PMOS with its well on ground is ruled out.

**Current lpf caps, for reference:** 88 × `pfet_01v8_lvt` W = 5.94, L = 10.89, nf = 1, 466 fF each at vc = 0.85 V tt (7.21 fF/µm²), about 41 pF total. Two devices (932 fF) are the user's "~900 fF unit". C1 = 18.6/37.3 pF (`csc` 0/1), C2 = 1.9/3.7 pF.

| vc (V) | 0.45 | 0.85 | 1.05 | 1.35 |
|---|---|---|---|---|
| old device, fF, tt / ss / ff | 489 / 486 / 491 | 466 / 449 / 475 | 408 / 346 / 444 | 174 / 142 / 237 |

**Unit cell design** (sizes in lambda, L = 0.18 µm):

- **PMOS:** 2 fingers × W = 13.32 µm (n = 74) × L = 5.40 µm (30L). Gate area is 143.9 µm².
  - efx parameters: `n 74 fingers 2 length 5.40 butted 1 ltap 1 rtap 1 vt lvt tgate 0 bgate 1`.
  - Drawn extent is 12.60 × 14.04 µm (70L × 78L).
  - Simulated C (ngspice, 1 MHz AC), fF:

    | vc (V) | 0.45 | 0.85 | 1.05 | 1.35 |
    |---|---|---|---|---|
    | tt | 1090 | 1039 | 910 | 388 |

    At 0.85 V, ss is 1002 and ff is 1060.
- **M3 MiM** (`mimcap` nw 72 nl 80):
  - capm is 12.96 × 14.40 µm;
  - the met3 bottom plate is 13.32 × 14.76 µm;
  - the met4 top plate is 12.60 × 14.04 µm.
- **M4 MiM** (`mimcap2` nw 72 nl 80): same origin. It shares met4 with the M3 MiM's top plate; the met5 top plate is 12.60 × 14.04 µm.
- **MiM model:** each MiM is ≈ 381 fF from the combined-lib model, C = `sw_cap_mim_ca`·(w+dw)(l+dw), area only, no series R.

  | MiM corner | `sw_cap_mim_ca` (fF/µm²) | dw (µm) |
  |---|---|---|
  | nom | 2.0 | 0.15 |
  | low | 1.78 | 0.055 |
  | high | 2.23 | 0.245 |

  - `cap_mim_m3_1` and `_m3_2` are defined identically, so they are fully correlated.
  - Plain tt/ss/ff use the nom cap corner. The cap corner comes from the `_ll`/`_hh`/`_hl`/`_lh` lib sections.
- **Wiring:** met3 and met5 to VDD; met4 (shared plate) = node. Plate connections go on stubs outside capm (capm.5/.8). Exits are on met2. The met1 straps and via1 are meant to stay inside the outline, but this is assumed, not drawn yet.
- **Total ≈ 1.80 pF at tt / 0.85 V.** This is hand arithmetic (1039 + 2 × 381); **the unit has not been simulated as one netlist.**
- **Footprint:** 13.32 × 14.76 µm, set by the met3 plate.
  - Units on different nets need a 14.58 × 16.02 µm pitch.
  - Same-net units can share one capm.
  - About 27% less area than two old devices with gaps, or about 41% less with merged MiMs.
  - A sweep of Lg 5.4–7.9 µm was flat (226–234 µm² per 1.8 pF), and 2 fingers was always best.
- **Variants:**
  - C1 needs 10.3 units per 18.6 pF half. n = 77 with capm 72×83 gives about 1.86 pF.
  - Non-butted taps would add 4L of width (capm 76×80).
  - Top+bottom gate bars would add 2L of height (rejected).
- **capm.10** ("capm must not straddle nwell, diff, tap, poly, li1, met1"):
  - Neither DRC deck checks it.
  - Interpretation used: no capm edge may cross shapes on those layers. Needs confirming.
  - The nwell sheet extends past capm.
- **Gate leakage:** not modeled (memory `sky130-no-gate-leakage-model.md`). Thin oxide (4.23 nm) PMOS in inversion is expected to be the low-leakage case (section 2).

**Files the user created 2026-11-14 (untracked; state read from disk, not discussed with the user yet):**
- `xschem/efx_pll96_lpf_unit.{sch,sym}`: ports `vc`, `vdd`; CMIM3 `cap_mim_m3_1` W = 12.96 L = 14.40; CMIM4 `cap_mim_m3_2` same size; MPC `pfet3_01v8_lvt` body = vdd, **W = 13.32 nf = 1**, L = 5.4. **Check:** the layout has 2 fingers of 13.32 µm (26.64 µm total), but xschem/SPICE W is the total width. As drawn, the schematic has half the gate area (≈ 520 fF instead of 1039 fF). It should probably be W = 26.64 nf = 2. Confirm with the user. The unit is not yet used in `efx_pll96_lpf.sch`.
- `mag/efx_pll96_lpf_unit.mag`: `pmos_n74_f2_l5400_bt_tl_tr_lvt`, `mimcap_w72_l80` and `mimcap2_w72_l80`. FIXED_BBOX is 13.32 × 14.76 µm.
  - The PMOS instance used is the **`bgate 0`** variant (no gate bar). A `_gb` variant (`bgate 1`) also exists in `mag/`. This differs from the agreed bottom-gate-bar design; ask whether it is intentional.
  - Magic `drc listall` on the saved file gives **0 errors**.
- `mag/efx_pll96_lpf.mag`: 24 units (4 columns × 6 rows, ≈ 43 pF), pitch 13.86 × 15.30 µm (0.54 µm gaps), footprint ≈ 55 × 92 µm.
  - No wiring yet.
  - Magic `drc listall` on the saved file gives **76 errors**, all at the tile gaps: capm.11 (750), cap2m.11 (651), met5.2 (336), nwell.2a (21).
  - The 0.54 µm gap is below the 14.58 × 16.02 µm pitch derived for units on different nets. Same-net units would need merged plates/capm, or abutted nwell.
- Also in `mag/`: other generator outputs from exploring variants: `pmos_n74_f2_l5400_{bt_tl_tr_lvt_gb,tl_tr_lvt_gb}`, `pmos_n5_f2_l180_{bt_,}tl_tr_gb`.
- The DRC numbers above came from the files on disk at 13:02 on 2026-11-14. The user had Magic open with these cells (pid 6111), so the live layout may differ.

**Scratch** (`/tmp/nix-shell.upKnEK/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/`): `unitcap/` (opt.py size sweep, `d_*.sp` C-V decks, meas.tcl, drc.tcl), `var/` (varactor C-V decks), `lpfdrc.tcl`.

**Varactors, considered and not chosen:**
- `cap_var_lvt` and `cap_var_hvt` are thin-oxide (≈ 4.17 nm) accumulation-mode devices: n+ poly over nwell. Their C-V curves are too nonlinear for a loop-filter cap:
  - lvt: Cmin 0.74, Cmax ≈ 8.18 fF/µm², about 11:1, with a steep step at Vgw +0.1…+0.4 V.
  - hvt: about 5–6:1.
- The thick-oxide `cap_var` (mvvar) has no model file.

## 3. Current state / gate status

From `/home/ejf/Projects/sky130_efx_ip__pll96`, inside `nix develop ~/nix-efx`:
```
make sim     # 10 "netlist sim/tb_*.spice" lines, no FAIL, no sim/*.bad; "Error 10 (ignored)" is expected noise
make check   # every "sch_check: N schematics ok"; netlist_check silent
git diff --stat   # 16 files: 7 xschem/*.sch, 7 sim/*.spice, mag/efx.tcl, mag/README.md
```
**At the time of writing (2026-11-14), an xschem session was open** (`pgrep -xa xschem` → `xschem -b tb_efx_pll96_top.sch`), and so was **an interactive Magic session**. That Magic session was pid 6111. Its process name is `.wish8.6-wrappe` (Magic under tkcon), so **`pgrep -xa magic` does not find it**; use `pgrep -af '[m]agic.tcl'` or look for Magic's "already locked by pid" message. The user's rule (memory `renetlist-before-sim.md`):
- Before any sim, check `pgrep -xa xschem; pgrep -xa magic`.
- If anything is open or a schematic is newer than its netlist, alert the user and wait.
- Then re-netlist with `make` and state the revision you ran.

**Not run:** the full locking regression on the lambda-grid sizes. It takes about 3.5 h with 8 runs in parallel at `num_threads=1` (`sim/top_reg.sh` per config, or the parallel runner pattern in scratchpad `runreg.sh`), and it waits for the user to finish editing. The last full regression (all 9 modes LOCK pass) predates the lambda change.

## 4. What's still to do

1. **Locking regression on lambda-grid sizes**, once the user says edits are done. Check `LOCK pass` in all 9 `sim/top_reg_<F>.out`, vc settling at 0.25–0.75·VDD, and f_err. Then the user decides whether to commit the migration.
2. **Loop-filter unit cap** (section 2a):
   - (a) Fix or confirm the `efx_pll96_lpf_unit.sch` MPC width (W = 26.64 nf = 2?) and the `bgate` choice in the unit `.mag`.
   - (b) Simulate the whole unit across vc and the MiM corners (`tt_ll`/`tt_hh`).
   - (c) Decide the unit count per C1/C2 section, then rework `efx_pll96_lpf.sch` to use `efx_pll96_lpf_unit`.
   - (d) Fix array spacing or merge same-net units; draw the met1/met2 wiring; get DRC clean (`drc listall`); LVS against the schematic.
   - (e) Confirm the capm.10 interpretation.
   - After (c), re-run the locking regression.
3. **Proposal polish before 2026-11-23** (README):
   - The input-frequency row has no unit, and its note omits the 5 and 10 MHz modes.
   - Say whether the `clk_sel` 96/48 MHz output mux is in the slot wrapper or in `efx_pll96`; it isn't in any schematic yet.
   - The duty-cycle row covers only 48 MHz.
   - **Optional:** test-plan methods, and specs for the reference input, the 1 µA bias tolerance, maximum power and power-down current.
   - **Unverified claims:** the GPIO pad taking a 1.8 V core-side signal; `ibnp_1u` polarity.
4. **Copy `efx.tcl` and `mag/README.md`** to `~/Projects/sky130_efx_ip__lvdig` and `~/Projects/sky130_efx_ip__template`; both have stale copies.
5. **Leftovers:**
   - `xschem/ejf_pll96_{chp,lpf}.{sch,sym}` are tracked but unreferenced; ask before deleting.
   - Regenerate `doc/pll96_diagram.png` after the next top-level change: it predates the noconn symbols.
   - Template repo: uncommitted `title.sym`/`title_efx.sym` changes, a stale `.gitignore` line, and Makefile changes not yet synced.
6. **Deferred by the user:**
   - `make drc` and `make pex`: use `drc listall`, and reuse lvdig's `lvs/pex_{none,c,rc}` flow.
   - A `work/` directory restructure.
7. **Older items:**
   - `tb_efx_pll96_top` runs `tran 5u` but measures at 18–20 µs.
   - `netlist_check.py` misses a missing lvdig include.
   - chp has a dangling XR13/XR14 chain.
   - `sdiv_mm_reg` is stale.

## 5. Relevant references

- Project guide: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`; proposal: `/home/ejf/Projects/sky130_efx_ip__pll96/README.md`; rules: `/home/ejf/Projects/sky130_efx_ip__pll96/doc/chipalooza.md`; layout method: `/home/ejf/Projects/sky130_efx_ip__pll96/mag/README.md`.
- Prior pickups: `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-13-chipalooza-readme-proposal-ready.md` (README/proposal state, regression results with C-extracted lvdig cells), `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-10-pll-locking-sims-tsim-vc-check.md`.
- Generator source: `/home/ejf/Projects/glayout_test` (`efx_primitives.py`, `magic/efx.tcl`, `docs/efx-magic-flow.md`).
- Scratch for this session, which may be gone: `/tmp/nix-shell.HoGMN0/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/`, holding:
  - `lambda/`: schematic backups and chp DC old/new decks
  - `cv/`: C-V decks and result text files
  - `vth/`: threshold decks
  - `lit/`: Hu ch. 7 PDF
- Memory: `renetlist-before-sim.md`, `ngspice-threads-parallel.md`, `pgrep-self-match.md`, `spec-margin.md`, `magic-drc-listall.md`.

## 6. Recommended next-session opening move

From `/home/ejf/Projects/sky130_efx_ip__pll96`:
1. Run `git status --short` to confirm the 16 uncommitted lambda/efx files are still there or have been committed.
2. Run `pgrep -xa xschem; pgrep -xa magic`. If anything is open, ask the user whether they're done editing.
3. Inside `nix develop ~/nix-efx`, run `make sim && make check` and note the netlist state.
4. Ask the user whether to start the 3.5 h locking regression on the lambda-grid sizes and which loop-filter cap option they've chosen.

The proposal is due 2026-11-23, so slot the section 4 item 3 README fixes in before the layout work.
