# Fresh-context pickup -- VCO changed to a 3-stage ring; extracted corners lock-window clean

**Written**: 2026-11-24, superseding `pickup-2026-11-22-vco-layout-lvs-clean-resistor-generator.md` (now in `superseded/`).
**Repo**: sky130_efx_ip__pll96, branch `main`
**HEAD**: `269f726` -- "VCO modified to 3-stg". The working tree was clean when this was written; only this pickup and the move of the old one are staged. Commit only when the user asks; end messages with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

Background: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`. Tools come from `nix develop ~/nix-efx`. Layout uses the efx lambda grid (`/home/ejf/Projects/sky130_efx_ip__pll96/mag/README.md`). Lock window used below = the regression's settled-VC limits, 0.25–0.75 × VDD = **0.45–1.35 V**.

## 1. What landed (user commits)

- `269f726` (2026-11-24 21:43) -- **VCO is now a 3-stage pseudo-differential ring.**
  - Wiring: x0→x1→x2→x0 straight, with no crossover; the LS is fed from x2 (`xls vdd x2n outp outn x2p gnd_vco`).
  - The tail is 5 PMOS units (was 6), and the dummy x3 was removed.
  - Layout: `mag/efx_pll96_vco_ring.mag` was renamed to `mag/efx_pll96_vco_ring3.mag` and rewired.
  - The top-level benches' `save` lines dropped x3p/x3n.
- `63d42a7` -- "VCO initial layout, lvs". Commits the 2026-11-22 state: hierarchical LVS match, the efx resistor generator `rl`/nwell fix, `LVS_FLAT`, and the `mag/unused/` cleanup. See the superseded pickup for details.

### Why the ring changed (settled, don't re-litigate)

**The 4-stage ring latched.**
- Extracted, it latched at `ff_ll` / 125 °C for VC ≤ 0.6 V (and at ss / 125 °C, VC 0.3–0.45 V, where a kick freed it).
- Each pseudo-differential cell is two current-starved inverters plus a weak cross-coupled NMOS pair (W 1.26 µm, L 0.44 µm).
- Single-ended, the 4-stage ring with its crossover is one loop of 8 inverters. The differential loop is net inverting, but the **common-mode loop is not**, so a static state exists with both inputs of each cell at the same level.
- The ring oscillates without the cross-coupled NMOS (user). Those devices are only what pushes against the latch, and at high tail current they lose.
- Probed latched levels at `ff_ll` / 125 °C, VC 0.45 V (vhi 1.266 V):
  - x0n 0.59 V, x0p 1.26 V
  - x1n/x1p ≈ 0 V
  - x2n 0.59 V, x2p 1.26 V
  - x3n/x3p ≈ 0 V
- The user reproduced it in schematic sim at `ff_ll` / 125 °C.
- Inferred, not simulated: in the PLL a stopped VCO makes the PFD pump VC lower, which raises the tail current and holds the latch, so the loop would deadlock.

**The 4-stage ring also missed the lock window.** At `ss_hh` / −40 °C it reached 96 MHz only at VC ≈ 0.33 V, below 0.45 V. The slowdown came from the poly-resistor-set tail current (f/I was unchanged).

**Why 3 stages.**
- An odd ring has no common-mode latch.
- The pseudo-differential version was kept over single-ended because the LS switches on the outp/outn crossing. That gives about 50% duty cycle at 96 MHz despite the strongly asymmetric edges: only the PMOS is current-starved from vhi, and the NMOS goes straight to gnd.
- The theoretical risk is in-phase locking of the two chains. No such failure was seen at any extracted point, but it was not specifically tested with an in-phase `.ic` start.

**Centring is intentionally a little low (user).** The charge-pump PMOS source has a higher VDsat than the NMOS sink, which is hard to avoid with PMOS mobility, so the top of the window needs more room.

## 2. Current state / results

```
make lvs CELL=efx_pll96_vco      # "LVS efx_pll96_vco: match" (hierarchical, 4 symmetries, no property errors), last run 2026-11-24 21:10
make pex CELL=efx_pll96_vco      # lvs/pex_c/efx_pll96_vco.spice, 309 caps, 2026-11-24 21:10
```

- The first 3-stage layout LVS failed. The layout still had the 4-stage crossover at the x2→x0 wrap; the user fixed it at 21:09.
- `sim/tb_efx_pll96_vco.spice` was re-netlisted by `make` at 21:10:34 and passed the checks.
- Its control block is set (committed) to **`ff_ll`, `temp=125`, `VC=0.0`**, the user's latch test. Reset it to tt / 0.75 if needed.

### Extracted 3-stage sweep (no startup kick; every point started on its own)

| VC (V) | 0.3 | 0.45 | 0.6 | 0.75 | 0.84 | 0.9 | 1.05 | 1.125 | 1.2 | 1.275 | 1.35 | 1.425 | 1.5 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `ss_hh` / −40 °C (MHz) | 111.6 | 105.6 | 90.5 | 63.8 | 47.1 | 36.5 | 13.8 | – | – | – | – | – | – |
| tt / 27 °C (MHz) | 158.5 | 152.3 | 140.2 | 116.4 | 96.6 | 83.1 | 51.3 | 37.1 | 24.5 | 14.0 | 6.4 | 2.3 | 0.63 |
| tt I(vdd_vco) (µA) | 137.8 | 132.5 | 122.2 | 101.8 | 84.8 | 73.0 | 44.6 | 31.9 | 20.6 | 11.3 | 4.9 | 1.6 | 0.4 |
| `ff_ll` / 125 °C (MHz) | 226.5 | 220.5 | 210.7 | 194.1 | 178.6 | 165.5 | 126.0 | 105.4 | 85.3 | 66.5 | 49.4 | – | – |

| corner | VC at 96 MHz | margin to window edge | Kvco (MHz/V) | I(vdd_vco) (µA) | LS supply (µA) |
|---|---|---|---|---|---|
| `ss_hh` / −40 °C | 0.546 V | 96 mV to 0.45 V | −101 | ~93 | ~15 |
| tt / 27 °C | 0.843 V | | −226 | ~84 | ~16 |
| `ff_ll` / 125 °C | 1.160 V | 190 mV to 1.35 V | −267 | ~72 | ~22 |

- **Against the 4-stage extracted ring at tt:**
  - 96 MHz was at 0.789 V, with Kvco −186 MHz/V and ~113 µA.
  - The 3-stage ring cuts the tail current at 96 MHz by about 25%.
  - Kvco is about 20% higher.
  - Extraction slows both rings by about 8% at every VC; Kvco scales by the same factor.
- **3-stage schematic, tt:** 96 MHz at 0.876 V, Kvco −246 MHz/V.
- **4-stage Kvco across extracted corners:** −31 MHz/V (`ss_hh` / −40 °C, on the flat top, outside the window) to −232 MHz/V (`ff_ll` / 125 °C).
- **Corner libraries:** `ss`/`ff`/`tt` skew FETs only. `_hh`/`_ll` add high/low resistance and capacitance (`ss_hh` = fet_ss + res_high + cap_high).

### Scratch (session-specific; may be cleared)

`/tmp/nix-shell.nHadnI/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/vco_pex/`:
- `mk.sh` -- the deck generator: `.param VC`, tran `T/4000` step, `f_mhz` from `vcon=0.9` rises 10→30, and averages of `idd_vco`/`idd`/`vhi`.
- `ring3pex/{tt,sshhm40,ffll125}/` -- this sweep's decks and outputs.
  - `ring3pex/pex_vco.spice` adds `Vvhiprobe` on `efx_pll96_vco_tailunit_0/pmos_n33_f4_l2380_tl_tr_lvt_11.D0`.
  - `ring3pex/base_any.spice` is the testbench with the VCO subckt replaced by `.include pex_vco.spice`.
- `ring3tt/` -- the 3-stage schematic tt sweep.
- 4-stage runs: `ss125/`, `ssm40/`, `ssm40hh/`, `ff125/`, `ff125ll/` (latch probe in `ff125ll/prb_vc0.45.*`).

## 3. What's still to do

1. **Loop stability at both Kvco extremes** (−101 and −267 MHz/V, 2.6×), for each mode's filter and charge-pump settings in `README.md`. Do this before the regression, so a phase-margin problem shows up cheaply. About 1 h of analysis (`doc/pll-filter.ipynb`).
2. **Locking regression on the 3-stage VCO** (`sim/top_reg.sh`, 9 modes, about 3.5 h).
   - Follow the regression rule: re-netlist first and check for open xschem/magic sessions.
   - At writing, the user had an ngspice run of `tb_efx_pll96_top.spice` going (pid 804957, started about 2026-11-24 21:47).
3. **Optional checks offered, not yet requested:**
   - Charge-pump UP/DN match and compliance at `ss_hh` / −40 °C with VC 0.55 V, and at `ff_ll` / 125 °C with VC 1.16 V.
   - An in-phase `.ic` start test of the 3-stage ring at the corners.
4. **README:**
   - VCO power, Kvco and duty-cycle numbers should be updated with these results, placed beside the spec budgets (memory `spec-margin.md`).
   - The proposal fixes due 2026-11-23 (input-frequency units / 5 and 10 MHz modes, `clk_sel` mux location, duty cycle at 96 MHz). Whether they were done after the 11-22 pickup is unverified.
5. **Carried over from earlier pickups:**
   - Sync `mag/efx.tcl` and `mag/README.md` to the template and lvdig.
   - Loop-filter unit cap (`efx_pll96_lpf_unit` MPC W; lpf array DRC; capm.10).
   - Delay-cell back-annotation residual (~2%).
   - `tb_efx_pll96_top` tran length.
   - `netlist_check.py` missing-lvdig-include gap.
   - chp XR13/XR14.
   - Stale `sdiv_mm_reg`.
   - Return the efx resistor gencell flow to fully hierarchical LVS (hierarchical is now the default; `LVS_FLAT=1` also matches).

## 4. Relevant references

- **Prior pickup:** `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-22-vco-layout-lvs-clean-resistor-generator.md`
- **Memory:**
  - `renetlist-before-sim.md`
  - `verify-process-before-claiming.md`
  - `verify-before-blaming-tools.md`
  - `ngspice-threads-parallel.md`
  - `spec-margin.md`
  - `no-not-x-but-y.md` (new, a style preference: no "not X, but Y" phrasing)
- **Schematic:** `/home/ejf/Projects/sky130_efx_ip__pll96/xschem/efx_pll96_vco.sch`.
- **Layout:** `/home/ejf/Projects/sky130_efx_ip__pll96/mag/efx_pll96_vco.mag` and `/home/ejf/Projects/sky130_efx_ip__pll96/mag/efx_pll96_vco_ring3.mag`.
- **Gotchas:**
  - Background ngspice jobs launched by Claude survive `/exit` (the `xargs` runner kept going).
  - The `pex_vc*` glob matches `pex_vco*.spice`; use `pex_vc[0-9]*`.
  - netgen `.SECONDARY`: delete both `lvs/<cell>.out` and `lvs/layout/<cell>.spice` to force a rerun.

## 5. Recommended next-session opening move

From `/home/ejf/Projects/sky130_efx_ip__pll96`:
1. Run `git status --short`.
2. Run `pgrep -a '[n]gspice'; pgrep -xa xschem; pgrep -af '[m]agic.tcl'`.
3. Run `make lvs CELL=efx_pll96_vco` (expect a match).
4. Ask the user whether the `tb_efx_pll96_top` run they started on 2026-11-24 locked, and whether to do the loop-stability check (item 1) before the 9-mode regression (item 2).
