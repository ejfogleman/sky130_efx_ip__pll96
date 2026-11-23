# Fresh-context pickup -- VCO recentred (6-leg tail, pcaps), two-row level shifter layout

**Written**: 2026-11-18, superseding `pickup-2026-11-13-lambda-grid-mimcap2-loop-filter-caps.md` (moved to `superseded/`; its open items that still apply are carried forward in section 3).
**Repo**: sky130_efx_ip__pll96, branch `main`
**HEAD**: `ad8c23e` -- "VCO recenter" (2026-11-18). When committing, end the message with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`; commit only when the user asks.

Project background: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`. Tools come from `nix develop ~/nix-efx` (xschem 3.4.7, ngspice, Magic 8.3.604, Netgen, KLayout); PDK at `~/.ciel/sky130A`. Layout uses the efx lambda grid, L = 0.18 µm = 36 Magic internal units (magscale 1 2): `/home/ejf/Projects/sky130_efx_ip__pll96/mag/README.md`. The README is the Chipalooza proposal, due **2026-11-23**.

## 1. What landed

Commits since the last pickup, newest first:
- `ad8c23e` -- **VCO recenter.**
  - The tail is now 6 legs (XMP1[5:0], `pfet_01v8_lvt` L = 2.38, W = 23.76, nf = 4, m = 2), each with 4 series `res_high_po_0p69` L = 6.84.
  - Delay-cell layout updated.
  - Delay-cell parasitic C back-annotated as 21 sim-only caps (CP0–CP20, 0.14–7.34 fF) in `xschem/efx_pll96_vco_dlycell.sch`.
  - New `xschem/pcapacitor.sym`: a capacitor with `lvs_ignore=open`.
  - The Makefile LVS netlist rule passes `--tcl 'set top_is_subckt 1; set lvs_ignore 1'`, so pcaps go into the sim netlists but not LVS.
  - README power and pin-budget updates (vdd_vco 110 µA).
  - CLAUDE.md now mentions pcapacitor.
- `e6814df`, `900b2f8` -- `.magicrc` writes relative instance paths; lvdig submodule updated to match.
- `fddc908` -- schematic and layout updates, `vco_en` added. The lambda-grid MOS migration from the last pickup is in here: 54 files.

**Uncommitted, this session (2026-11-18 evening): `mag/efx_pll96_vco_ls.mag` redrawn as two rows.**
- **Why:** the user asked for "the level shift as two rows abutted along the VDD rail to make it more square". Then: "You can cross vdd on met2 instead of li … ring inputs should be on the left, outputs on the right."
- **Size:** was 12.96 × 3.96 µm (72L × 22L), now 7.56 × 6.48 µm (42L × 36L). FIXED_BBOX `0 -36 1512 1260`.
- **Bottom row (inp → outp)**, bottom to top: gnd rail, NMOS, gate bars, PMOS, shared vdd rail.
- **Top row (inn → outn):** the bottom row mirrored about y = 612.
- **Left to right in each row:**
  - input li pin and polycont;
  - M1 (N, 4 fingers), with the M4+M3 series PMOS stack in one diffusion above it;
  - the M3 cross gate bar;
  - the output inverter M9/M10 (4 + 4 fingers);
  - output li pin at the right edge.
- **Taps:** p-tap and n-tap on the left edge only (the right-edge taps of the old cell were dropped). The n-well is continuous over both rows.
- **Cross-coupling:**
  - Each internal node runs on a met1 strap to its own inverter's gate bar.
  - From there a met2 riser crosses the vdd rail to the other row's cross gate polycont: ls_outp at x = 19L–21L, ls_outn at x = 23L–25L.
  - The two risers are 2L apart and run parallel, not crossing. This x offset is the only asymmetry between the rows apart from M8.
- **M8 (outn pull-up):** 4 fingers × 0.99 µm, matching the schematic's W = 3.96. Its diffusion edge is 18 units (off-grid), as in the user's original. M10 is 4 × 1.08.
- **Pins:** `vdd 1, inp 2, outp 3, outn 4, inn 5, gnd 6`. gnd is labelled on both outer rails; LVS sees one net.
- **No longer used** (still tracked, now unreferenced): `mag/nmos_isl_vco_ls.mag`, `mag/pmos_isl_vco_ls_a.mag`, `mag/pmos_isl_vco_ls_b.mag`. The old LS layout is `git show HEAD:mag/efx_pll96_vco_ls.mag`.
- **Not yet re-placed:** `mag/efx_pll96_vco.mag` still places the LS instance (`efx_pll96_vco_ls_0`, `transform 1 0 10260 0 1 180`) with the old box. The user is doing the VCO-top placement by hand.
- **Generator script:** `/tmp/nix-shell.yNz04z/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/ls2/gen.py`.
  - It writes a Magic Tcl script (`python3 gen.py <cell> > draw.tcl`). `run.tcl` in the same folder sources it and saves.
  - The installed .mag is the saved file with the label font size fixed by `sed 's/FreeSans 2304/FreeSans 288/'`.
  - Scratch may be cleared on reboot.

**Other uncommitted files** (the user's own work, not touched this session): `mag/efx_pll96_dbuf.mag`, `mag/efx_pll96_vco.mag`, `xschem/efx_pll96_vco.sch`, four `sim/tb_*.spice`, plus untracked `mag/efx_pll96_vco_{ring,tailunit,test}.mag` (created 21:39–21:40) and generator outputs `mag/{nmos,pmos}_n11_*`, `mag/ppolyres_w0p*`.

**Template repo** (`/home/ejf/Projects/sky130_efx_ip__template`): `Makefile`, `README.md` modified and `xschem/pcapacitor.sym` untracked. These are the pcapacitor/lvs_ignore changes, byte-identical to pll96's. Not committed.

## 2. Current state / gate status

From `/home/ejf/Projects/sky130_efx_ip__pll96`, inside `nix develop ~/nix-efx`:
```
make lvs CELL=efx_pll96_vco_ls   # "LVS efx_pll96_vco_ls: match"; lvs/efx_pll96_vco_ls.out says "Netlists match uniquely." (no property errors)
make pex CELL=efx_pll96_vco_ls   # writes lvs/pex_c/efx_pll96_vco_ls.spice (35 caps; old layout 36)
```
- **DRC:**
  - KLayout (`$PDK_ROOT/$PDK/libs.tech/klayout/drc/sky130A_mr.drc`, feol/beol/offgrid on, GDS from `gds write`) gives **0 items**. A copy with an injected met2 sliver gives 2, so the check works.
  - Magic batch DRC (`drc style drc(full)`, `select top cell`, `drc check`, `drc catchup`, `drc why`) on a copy of the cell: **"No errors found", 0 total**. An earlier note that Magic batch DRC missed an injected error was wrong. `drc why` and `drc count total` *print* their result and return an empty string, so a `puts "[drc why]"` and a grep for other text hid it. A re-test with a 0.05 µm met1 square, read back with `what`, was flagged (met1.6).
- **VCO with the extracted LS, old vs new layout** (same frozen VCO deck; only the LS netlist swapped):

  | VC (V) | f, old → new (MHz) | Δf | LS supply, old → new (µA) | Δ |
  |---|---|---|---|---|
  | 0.6 | 133.48 → 133.41 | −0.05% | 20.9 → 21.7 | +3.4% |
  | 0.84 | 95.04 → 94.99 | −0.05% | 14.9 → 15.4 | +3.3% |
  | 1.2 | 23.88 → 23.86 | −0.07% | 4.36 → 4.50 | +3.0% |

  - The VCO supply current is unchanged.
  - The LS supply is the divider-domain vdd. The extra 3% is probably the met2 risers and the longer met1 straps.
  - Decks: scratchpad `vco_ls/ls2_vc*.spice` and `lsc_vc*.spice`.
- **Latest VCO sweep** (6 legs, pcaps, schematic LS): 147.5 MHz at VC = 0.3, 94.5 at 0.84, 0.6 at 1.5 V.
  - 96 MHz falls at VC ≈ 0.833 V.
  - Kvco = −214 MHz/V.
  - Kvdd = +7.7 MHz/V with VDD − VC held fixed (the loop filter is supply-referenced).
- **Top-level sim with the new VCO:** the user's 16 MHz run gives 96.02 MHz.
  - Supply currents: idd_ref 31.6, idd_vco 102.7, idd_div 63.3 µA.
  - This is in the README.
  - The other modes have not been regressed on the new VCO; the README marks their power as estimated.
- **Open sessions at writing time (21:4x):** xschem pid 635832 (`xschem -b`, the user's GUI) and an **interactive Magic, pid 843012**.
  - `pgrep -xa magic` does **not** find interactive Magic (process name is wish/tkcon); use `pgrep -af '[m]agic.tcl'`.
  - If that Magic has `efx_pll96_vco_ls` loaded from before the redraw, saving it would overwrite the new layout. Check with the user.

## 3. What's still to do

1. **The user re-places the new LS in the VCO top** (`mag/efx_pll96_vco.mag`) and reserves the two met2 riser tracks (x = 19L–25L of the cell) from top-level met2 routing. Optional tweaks if asked:
   - Spread the risers to 4L: move the M9/M10 polycont to the right end of its bar.
   - Swap which row is on top so the left-edge pin order matches the ring's `x3p`/`x3n`.
2. **Locking regression on the new VCO** (all 9 configs, `sim/top_reg.sh`, about 3.5 h at 8 parallel × `num_threads=1`), once the user's schematic edits are done.
   - Follow the regression rules in `renetlist-before-sim.md`.
   - Then replace the "estimated" power figures in the README Power Consumption row, keeping the specs as budgets (`spec-margin.md`).
3. **Commit the template repo's pcapacitor/lvs_ignore changes** when the user asks. Delete or move the three unused `*_isl_vco_ls.mag` islands if the user agrees.
4. **Smaller VCO follow-ups:**
   - About 2% back-annotation residual in the delay cell: device junctions, and layout nf = 1 against schematic nf = 4.
   - Stale frequency note in the VCO bench.
5. **Carried over from the 2026-11-13 pickup (status not re-checked this session):**
   - **Loop-filter unit cap (1.8 pF stack).** Open questions:
     - schematic MPC W = 13.32 nf = 1, against the layout's 2 × 13.32;
     - `bgate` variant;
     - lpf array spacing/DRC;
     - capm.10 interpretation.
   - **README proposal fixes before 2026-11-23:**
     - input-frequency units and the 5/10 MHz modes;
     - the location of the `clk_sel` mux;
     - duty cycle at 96 MHz.
   - Sync `mag/efx.tcl` and `mag/README.md` to lvdig and the template.
   - **Older leftovers:** `ejf_pll96_{chp,lpf}` files; `tb_efx_pll96_top` tran length; `netlist_check.py` not catching a missing lvdig include; chp XR13/XR14; stale `sdiv_mm_reg`.

## 4. Relevant references

- Project guide: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`. Proposal: `/home/ejf/Projects/sky130_efx_ip__pll96/README.md`. Layout method: `/home/ejf/Projects/sky130_efx_ip__pll96/mag/README.md`.
- Level shifter: `/home/ejf/Projects/sky130_efx_ip__pll96/xschem/efx_pll96_vco_ls.sch` and `/home/ejf/Projects/sky130_efx_ip__pll96/mag/efx_pll96_vco_ls.mag`. LVS report: `/home/ejf/Projects/sky130_efx_ip__pll96/lvs/efx_pll96_vco_ls.out`.
- Prior pickup: `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-13-lambda-grid-mimcap2-loop-filter-caps.md`.
- **Scratch** (may be gone): `/tmp/nix-shell.yNz04z/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/`.

  | Folder | Contents |
  |---|---|
  | `ls2/` | LS generator, GDS, KLayout reports |
  | `vco_ls/` | old/new extracted-LS VCO decks |
  | `vco_r6/` | latest VCO sweep |
  | `kvdd/` | Kvco/Kvdd decks |
  | `rescnt/` | ppolyres licon count check |

- Memory: `renetlist-before-sim.md`, `verify-process-before-claiming.md`, `ngspice-threads-parallel.md`, `pgrep-self-match.md`, `spec-margin.md`, `magic-drc-listall.md`.

## 5. Recommended next-session opening move

From `/home/ejf/Projects/sky130_efx_ip__pll96`:
1. Run `git status --short` and `git diff --stat mag/efx_pll96_vco_ls.mag` to see whether the two-row LS is still the version on disk, or whether the user's Magic session saved over it.
2. Run `pgrep -xa xschem; pgrep -af '[m]agic.tcl'`.
3. Re-run `make lvs CELL=efx_pll96_vco_ls` (expect match, no property errors).
4. Ask the user whether the VCO-top placement is done and whether to start the 9-mode locking regression on the new VCO.
