# Fresh-context pickup -- corners set to ±5 % / 0–125 °C; 3-stage VCO regression passes; charge-pump and supply-corner results

**Written**: 2026-11-25, superseding `pickup-2026-11-24-vco-3-stage-ring-extracted-corners.md` (now in `superseded/`; it was never committed, so it lands in `superseded/` as a new file).
**Repo**: sky130_efx_ip__pll96, branch `main`
**HEAD**: `269f726` -- "VCO modified to 3-stg".

Uncommitted at writing:
- `xschem/tb_efx_pll96_chp.sch` and `sim/tb_efx_pll96_chp.spice`: the lvdig include fix (section 1).
- `README.md`: corner rows updated (section 0).
- Staged: this pickup and the moves of the 11-22 and 11-24 pickups.

Commit only when the user asks; end messages with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

Background: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`. Tools come from `nix develop ~/nix-efx`.

- **Lock window:** the regression's settled-VC limits, 0.25–0.75 × VDD. That is 0.45–1.35 V at 1.8 V, 0.428–1.283 V at 1.71 V, and 0.473–1.418 V at 1.89 V.
- **3-stage VCO history:** in the superseded 11-24 pickup. The 4-stage ring had a common-mode latch and was replaced by a 3-stage pseudo-differential ring (`269f726`).

## 0. Decision this session (user, 2026-11-25) -- don't re-litigate

**The design corners are now VDD ±5 % (1.71–1.89 V) and temperature 0 to 125 °C.** This replaces ±10 % and −40 °C.

- The reason is the ss_hh low-supply, cold-temperature result in section 2.3: at ±10 % or −40 °C the VCO cannot reach 96 MHz.
- `README.md` is updated (uncommitted):
  - Features line.
  - Supply Voltage 1.71 / 1.8 / 1.89 V (Notes: "±5%, all three supply domains") and Operating Temperature 0 / 25 / 125 °C. Spec comments are kept to what clarifies the spec, with no decision history (user, memory `spec-margin.md`).
  - The three supply pin rows now say ±5 %.

## 1. What landed this session (uncommitted)

- **`xschem/tb_efx_pll96_chp.sch`:** added the collapsed `s4` code block at (0, 440), the same as the pfd bench:
  ```
  tcleval(* lvdig standard cells (layout-extracted, C parasitics; symbols are primitives)
  .include $::LVDIG_SPICE/sky130_efx_lvdig_c.spice)
  ```
  - The charge pump's `efx_pll96_dbuf` uses lvdig `inv_1`. Without the include, the committed bench fails in ngspice.
  - Re-netlisted with `make sim/tb_efx_pll96_chp.spice`, and both checks pass.
  - The bench's own noise analysis then ran clean.

## 2. Results (all at tt/27 °C/1.8 V unless stated)

### 2.1 9-mode locking regression on the 3-stage VCO -- all LOCK pass

- **How it was run:** tt, 27 °C, 1.8 V; netlist re-made with `make -B` at 2026-11-24 21:54, run 21:54 → about 05:10 (6.4 h).
- **Outputs:** `sim/top_reg_<F>.{out,raw}`. The 2026-11-13 outputs are backed up in scratch (section 4).

| mode | N | f_out (MHz) | f_err (ppm) | vc (V) | vc/VDD |
|---|---|---|---|---|---|
| 4 | 24 | 96.011 | +109 | 0.877 | 0.487 |
| 5 | 20 | 99.978 | −222 | 0.861 | 0.478 |
| 5w | 20 | 100.012 | +117 | 0.861 | 0.478 |
| 6 | 16 | 95.997 | −33 | 0.877 | 0.487 |
| 8 | 12 | 95.974 | −271 | 0.877 | 0.487 |
| 10 | 10 | 100.002 | +21 | 0.861 | 0.478 |
| 10w | 10 | 100.012 | +125 | 0.861 | 0.478 |
| 12 | 8 | 96.005 | +47 | 0.877 | 0.487 |
| 16 | 6 | 95.991 | −92 | 0.877 | 0.487 |

Drift is under 0.1 mV and vc peak-to-peak under 0.73 mV in every mode. The 5 and 10 MHz modes run the VCO at 100 MHz.

### 2.2 Charge pump: UP/DN mismatch and saturation

**Method.** Scratch copies of `tb_efx_pll96_chp` (block level, schematic netlist) have PWL switch drives:
1. 3 µs with both currents steered to the replica, so the replica amplifier settles.
2. 100 ns with **UP and DN both on** into VC. This is the lock state; net current = mismatch.
3. 20 ns UP-only, then 20 ns DN-only.

The 1 µA reference (`I0` → `ibnp_1u`) is an **ideal current source**, so the bias's VDD/temperature dependence is not included.

**Codes:** `chp_b` = 101 (modes 4, 5, 8, 10), 100 (5w, 6, 10w, 12), 010 (16).

**Margins:** VDS − VDSAT in mV, listed as MP1 / MP1C / MN1 / M1C. MP1 is the PMOS source, MP1C its cascode, MN1 the NMOS sink, M1C its cascode.

| corner, VDD, VC | code | I | mismatch, both on | margins, both on |
|---|---|---|---|---|
| ss_hh −40, 1.8, 0.55 | 101 / 100 / 010 | 5.15 / 7.61 / 9.97 µA | +0.36 / +0.39 / +0.41 % | 133/333/67/294, 115/281/85/243, 102/237/101/199 |
| tt 27, 1.8, 0.85 | 101 / 100 / 010 | 5.27 / 7.74 / 10.57 µA | +0.10 / +0.12 / +0.15 % | 124/405/83/521, 104/345/103/455, 86/287/125/389 |
| ff_ll 125, 1.8, 1.16 | 101 / 100 / 010 | 5.56 / 7.95 / 11.04 µA | −0.08 / 0 / +0.17 % | 85/183/101/608, 63/137/123/526, 39/83/150/435 |
| ff_ll 125, 1.98, 1.333 | 101 / 100 / 010 | 5.56 / 7.95 / 11.05 µA | −0.16 / −0.10 / +0.04 % | 86/197/104/773, 64/154/127/690, 41/103/155/598 |
| ss_hh −40, 1.62, 0.405 | 101 / 100 / 010 | 5.13 / 7.59 / 10.01 µA | +0.56 / +0.57 / +0.55 % | 122/186/64/152, 104/133/81/100, 90/89/96/56 |

- **Both-on state:** every device is in saturation at every point. The tightest is MP1 at 39–41 mV, at ff_ll / 125 °C with code 010. The PMOS margin follows VDD − VC, as expected.
- **20 ns one-sided pulses leave the cascode briefly in triode.** The current the switches divert from VC charges the 1.4 pF replica capacitor with nothing to discharge it: 11 µA × 20 ns / 1.4 pF ≈ 160 mV.
  - ff_ll DN-only: MP1C at −68 mV (1.8 V, code 010) and −48 mV (1.98 V, code 010).
  - ss_hh 1.62 V UP-only: M1C at −72 mV (code 100) and −142 mV (code 010).
  - This only matters for long acquisition pulses.
- The DN current in the one-sided windows reads 10–20 % high; that is the same replica transient.
- The ±10 % charge-pump points were run before the corner decision. The new corners (±5 %, 0–125 °C) have not been run on the charge pump.

### 2.3 Extracted VCO vs supply (the reason for the corner decision)

Same extracted-netlist method as the 11-24 pickup. Both supplies follow `VDD`, and the frequency is measured at the VDD/2 crossing.

| corner | VDD | f at VC 0.25–0.3 V (MHz) | VC at 96 MHz | vs lock window |
|---|---|---|---|---|
| ss_hh −40 | 1.8 | 111.6 (0.3 V) | 0.546 | +96 mV |
| ss_hh −40 | 1.71 | 94.6 | none | **fails** |
| ss_hh −20 | 1.71 | 100.9 | ~0.41 | **−15 mV** |
| ss_hh 0 | 1.71 | 107.5 | ~0.51 | +83 mV (Kvco ≈ −80 MHz/V) |
| ss_hh −40 | 1.62 | 77.0 | none | **fails** |
| ff_ll 125 | 1.98 | – | 1.333 | 152 mV below 1.485 (Kvco ≈ −266 MHz/V) |

ss_hh, 1.71 V, frequency in MHz vs VC (V):

| VC | 0.25 | 0.3 | 0.35 | 0.4 | 0.45 | 0.5 | 0.55 | 0.6 | 0.7 | 0.8 |
|---|---|---|---|---|---|---|---|---|---|---|
| 0 °C | 107.5 | 106.3 | 104.9 | 102.9 | 100.4 | 97.0 | 92.4 | 86.3 | 69.9 | 51.5 |
| −20 °C | 100.9 | 99.8 | 98.4 | 96.5 | 94.0 | 90.5 | 85.8 | 79.5 | 62.8 | 44.7 |
| −40 °C | 94.6 | 93.6 | 92.2 | 90.4 | 87.9 | 84.4 | 79.5 | 72.9 | 55.9 | 38.1 |

**Mechanism (measured, from tail PMOS operating points).**
- Each tail unit is a high-poly degeneration resistor in series with an LVT PMOS (W 5.94 µm, L 2.38 µm per finger), with the PMOS gate on VC.
- vhi is set by the ring at a given current and barely tracks VDD:
  - ss_hh −40: 1.414 V at 1.8 V and 1.354 V at 1.62 V.
  - At 1.71 V it rises as it gets colder: 1.352 / 1.369 / 1.386 V at 0 / −20 / −40 °C.
- That leaves VDD − vhi of only 0.27–0.36 V.
- **ss_hh −40 at 1.62 V, VC 0.35 V:**
  - resistor drop ≈ 0.236 V;
  - tail PMOS VSD ≈ 30 mV against VDSAT ≈ 0.253 V (deep triode);
  - VSG 1.034 V, Vth 0.738 V.
- At 1.71 V the tail PMOS is in triode for VC below about 0.6–0.7 V at all three temperatures.
- So the tail current, and the VCO's top frequency, are set by the resistor and the VDD − vhi headroom; VC hardly matters there. Keeping the tail in saturation would take about 0.5 V of VDD − vhi.
- Rough scaling: the top frequency at ss_hh −40 falls about 17 MHz per 5 % of VDD.
- The first estimate of this corner was wrong. It assumed VC would shift one-for-one with VDD; the top frequency collapsed instead.

**Not yet simulated at the new corners:**
- ss_hh 0 °C at 1.71 V is now the slow worst case, with 83 mV of margin.
- ff_ll 125 °C at 1.89 V is the fast worst case. By interpolation it should sit between the 1.8 V point (1.160 V, 190 mV margin) and the 1.98 V point (1.333 V, 152 mV margin).

## 3. What's still to do

1. ~~Update README spec rows to the new corners~~ -- done 2026-11-25 (uncommitted).
2. **Re-run the corner set at the new limits.** About 30 min of compute.
   - Extracted VCO: ss_hh 0 °C at 1.71 V and ff_ll 125 °C at 1.89 V, at minimum. Add ss_hh 0 °C at 1.89 V and ff_ll 125 °C at 1.71 V for Kvco spread.
   - Charge pump at the resulting VCs, all three codes.
   - The scratch generators below can do both.
3. **Decide whether 83 mV of slow-corner margin is enough, or widen the VCO's top end.**
   - Margin is thin and Kvco there is only about −80 MHz/V; the tail PMOS is in triode, so VC has little control.
   - Options for the user: less degeneration resistance, a lower-vhi ring at a given current, or more frequency per µA.
   - The user's stated preference is that centring sits a little low (PMOS VDSAT > NMOS VDSAT in the charge pump).
4. **Loop stability at both Kvco extremes** for each mode's filter/charge-pump settings (`doc/pll-filter.ipynb`).
   - The 3-stage extracted Kvco ranges from about −80 MHz/V (ss_hh 0 °C, 1.71 V) to about −266 MHz/V (ff_ll 125 °C, high supply).
   - Redo it once item 2 gives the ±5 % numbers.
5. **Locking regression at a corner** (for example ss_hh 0 °C / 1.71 V). `top_reg` takes about 6.4 h for 9 modes at tt; a single mode takes 0.5–1.3 h. Re-netlist first (memory `renetlist-before-sim.md`).
6. **Commit** the chp bench fix and the pickups when the user asks.
7. **Carried over:**
   - In-phase `.ic` start test of the 3-stage ring.
   - Charge-pump bias reference realism (it is an ideal 1 µA source in the bench).
   - README proposal fixes from 2026-11-23 (unverified).
   - Sync `mag/efx.tcl` / `mag/README.md` to the template.
   - Loop-filter unit cap / lpf array DRC (capm.10).
   - Delay-cell back-annotation residual.
   - `tb_efx_pll96_top` tran length.
   - `netlist_check.py` missing-lvdig-include gap: it did not flag the chp bench, which is now fixed by hand.
   - chp XR13/XR14.
   - Stale `sdiv_mm_reg`.

## 4. Scratch (session-specific; may be cleared)

Root: `/tmp/nix-shell.nHadnI/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/`

- **`vco_pex/mk2.sh base VC T VDD name`:** VCO deck generator with VDD and a VDD/2 frequency threshold. `mk.sh` is the 1.8 V-only original.
- **`vco_pex/ring3pex/`:**
  - Per-corner dirs, each with `base.spice`, `pex_vco.spice`, `.spiceinit` (num_threads=1) and `pex_vc*.{spice,out}`:
    - `sshhm40_lo` (1.62 V), `ffll125_hi` (1.98 V);
    - `sshhm40_1v71`, `sshhm20_1v71`, `sshh0_1v71`;
    - the 1.8 V `tt`, `sshhm40`, `ffll125`.
  - The 1.71 V decks also measure the tail finger `@m.xvco.x5.msky130_fd_pr__pfet_01v8_lvt[vds|vdsat|vbs]`.
  - `X5` has the vhi side as its source terminal, so the reported VDS is −VSD.
  - `sshhm40_lo/prb_vc0.35.*` is the full tail operating-point probe.
- **`chp/`:**
  - `base.spice`, the chp bench with placeholders and the bracketed instances renamed `XMP1_0`, `XMP1C_0`, `XMN1_0`, `XM1C_0`; ngspice `@` syntax fails on `[` in instance names.
  - `mk.sh corner temp vc b2 b1 b0 name` builds a deck.
  - For a non-1.8 V supply, sed `.param VDD=` and `.param VEN=`, and pass the bit voltages scaled to VDD (see `cpv_*`).
  - `cp_*` are the 1.8 V runs; `cpv_*` are the 1.62 / 1.98 V runs.
- **`top_reg_old_2026-11-13/`:** the previous regression outputs.

## 5. References

- **Prior pickups:**
  - `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-24-vco-3-stage-ring-extracted-corners.md`
  - `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-22-vco-layout-lvs-clean-resistor-generator.md`
- **Memory:**
  - `renetlist-before-sim.md`
  - `verify-process-before-claiming.md`
  - `verify-before-blaming-tools.md`
  - `ngspice-threads-parallel.md`
  - `spec-margin.md`
  - `no-not-x-but-y.md`
- **Extracted VCO:** `/home/ejf/Projects/sky130_efx_ip__pll96/lvs/pex_c/efx_pll96_vco.spice` (2026-11-24 21:10, still newer than every VCO `.sch`/`.mag` at writing).
- **Spec table:** `/home/ejf/Projects/sky130_efx_ip__pll96/README.md`, lines 37–60.

## 6. Recommended next-session opening move

From `/home/ejf/Projects/sky130_efx_ip__pll96`:
1. Run `git status --short` (expect the chp bench edits and the staged pickups).
2. Run `pgrep -a '[n]gspice'; pgrep -xa xschem; pgrep -af '[m]agic.tcl'`.
3. Ask the user whether to update the README corner rows (item 1) and run the ±5 % / 0–125 °C corner set (item 2) now.

Item 2 takes about 30 min of compute and answers whether the 3-stage VCO needs more top-end range before the loop-stability work.
