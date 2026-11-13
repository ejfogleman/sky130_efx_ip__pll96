# Fresh-context pickup -- closed-loop PLL locking sims with div_f in progress; T_SIM per mode and vc lock check added

**Written**: 2026-11-10 22:40 EST, superseding `pickup-2026-11-10-div-f-feedback-divider.md`
**Repo**: sky130_efx_ip__pll96, branch `main`
**HEAD**: `afa3e7b` -- "Update README.md". **Everything is uncommitted** (87 entries in `git status --short`). The user has not asked for a commit; when asked, end the message with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

Project background: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md` (layout, tools, sim workflow, design hierarchy, per-mode configs). Tools come from `nix develop ~/nix-efx`; the PDK is at `~/.ciel/sky130A`.

## 1. What landed (uncommitted; file list from this session's edits)

Newest first. The prior pickup, `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-10-div-f-feedback-divider.md`, covers the earlier work in detail:
- the new 5-bit feedback divider `div_f` and its verification
- the lvdig cell swap
- the ejf→efx rename
- the README and config changes for `divf_c`

That work is all still uncommitted and still valid.

- **Lock check in the top-level benches.** Files: `/home/ejf/Projects/sky130_efx_ip__pll96/xschem/tb_efx_pll96_top_reg.sch` and `/home/ejf/Projects/sky130_efx_ip__pll96/xschem/tb_efx_pll96_top_template.sch`. Their control blocks are identical except for the name of the `.raw` file they write.
  - Each run prints one line: `LOCK pass|fail f_out= f_err= vc= vc/vdd= vc_drift= vc_pp=`.
  - A run passes only if all three hold:
    1. The `clk_out` frequency (10-period average starting 1 µs before the end) is within 0.5% of 1/T_VCO.
    2. The loop-filter control node `xpll.vc` averages between 0.25 and 0.75 × VDD over the last 2 µs.
    3. `vc` has settled: its averages over the last two 1 µs windows differ by less than 1% of VDD.
  - **The user asked that `vc` settling be checked on every sim**, not just the frequency.
  - The 0.5% and 1% thresholds were the agent's choice and the user hasn't reviewed them.
  - `T_CLK_OUT` is now the 10-period average divided by 10.
- **`T_SIM` per mode.**
  - Every `/home/ejf/Projects/sky130_efx_ip__pll96/sim/config_*.inc` now sets `.param T_SIM` to about 100·T_REF: 4→25u, 5/5w→20u, 6→17u, 8→13u, 10/10w→10u, 12→9u, 16→7u. `config.inc` is a copy of `config_16.inc`.
  - The benches pass it to the control block with `.csparam t_sim = {T_SIM}` (also `t_vco`, `vdd_p`) and run `tran 1n $&t_sim`. Supply currents are averaged over the last 2 µs.
  - **Reasoning from the user:** loop bandwidth ≈ F_ref/20, so 5τ settling needs about 100·T_REF. Higher reference frequencies can therefore run shorter sims. 5w and 10w have wider bandwidth (300 kHz and 600 kHz), so the same T_SIM is conservative for them.
- **Netlists regenerated:** `/home/ejf/Projects/sky130_efx_ip__pll96/sim/tb_efx_pll96_top_reg.spice` and `tb_efx_pll96_top_template.spice`.
  - The `.csparam`/`$&` syntax and the LOCK logic were tested on small RC decks in scratch.
  - **The full PLL deck has not been run with the new control block** (unverified end to end).
- **CLAUDE.md** describes T_SIM and the LOCK check.

## 2. Current state

> **CORRECTION (2026-11-11):** these runs used a **stale** `sim/tb_efx_pll96_top_reg.spice`, netlisted at 16:29 EST, before the user's final `div_f` edit at 19:01. They simulated the *previous* `div_f` revision: `clkinv_2` clock and a combinational `and2` terminal count. All 9 passed LOCK, but that does **not** verify the current divider. Rerun every mode from a freshly made netlist (`make sim/tb_efx_pll96_top_reg.spice`). Mode 16 was rerun on 2026-11-11 with the current netlist, which also includes a charge-pump `nf=mult=1` → `nf=1` fix; results are in `sim/top_reg_16_new.{out,raw}`.

**Closed-loop locking sims. Started 20:48 EST, still running at 22:40.**
- They run in background task `bj9clfgbf`, launched as `xargs -P 8` over `run1.sh`. Output goes to `/tmp/nix-shell.HoGMN0/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/tasks/bj9clfgbf.output`. It is empty apart from the start date until a mode finishes; ngspice batch mode gives no progress output.
- **Deck:** the **old** deck, with a fixed `tran 1n 20u`, measurements over 18–20 µs, and no LOCK line, with `set num_threads = 1` added. Modes 4, 5, 5w, 6, 8, 10, 10w and 12 are running.
- **Mode 16** is queued for the first free slot. Its scratch deck was hand-edited to `tran 1n 8u`, with measurements over 6–8 µs and the period at 7 µs.
- **ETA estimate:** the first eight finish around 23:30–00:00 (about 2.5–3 h each with 8 running at once). Mode 16 should finish around 00:30–01:00. This is unverified.
- **Mode 4 caveat:** 20 µs is only 80·T_REF, about 4τ. If it fails the settled test, rerun mode 4 with the new repo deck (T_SIM = 25u).
- **Results:**
  - Each run's working directory is `/tmp/nix-shell.HoGMN0/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/topreg/<mode>/`.
  - `run1.sh` copies each run's `.out` and `.raw` to `/home/ejf/Projects/sky130_efx_ip__pll96/sim/top_reg_<mode>.{out,raw}`.
  - **To check lock on a finished old-deck run:** `.../scratchpad/topreg/lockcheck.sh <mode>`, inside `nix develop ~/nix-efx`. It loads that mode's `.raw` and applies the same LOCK check, using that deck's own end time and T_VCO.
  - It was tested on an old 2.5 µs `sim/tb_efx_pll96_top.raw`, where it correctly reported fail (f_err 2%, vc drift 22 mV/µs).
  - Expected frequencies: 96 MHz, or 100 MHz for modes 5, 5w, 10 and 10w (T_VCO = 10n).
- **Do not edit `run1.sh` while the batch runs.** bash reads scripts incrementally, so editing it could break the running instances.

Verify commands (repo root, inside `nix develop ~/nix-efx`):
```
make sim     # all 10 sim/tb_*.spice end in ".end"; expect harmless "not in symbol" / "Error 10 (ignored)" lines
grep -c 'csparam' sim/tb_efx_pll96_top_reg.spice   # 3
pgrep -fa '[n]gspice -b'                           # running locking sims, if any
```

**Settled facts (don't re-litigate):**
- div_f programming is `divf_c = N−1`. Measured Fmax: 719 MHz at ss/1.62 V/85 °C, 1151 MHz at tt; the requirement is about 106 MHz.
- Configs 5w and 10w use N = 20 and 10, T_VCO = 10n, lpf_rsc = 01 and chp_b = 100, matching the README.

## 3. What's still to do

1. **Report the locking results.**
   - For each mode: LOCK pass/fail (via `lockcheck.sh`), f_out, vc/vdd, vc_drift, and idd_ref/idd_vco/idd_div.
   - Rerun mode 4 with the new deck if it isn't settled at 20 µs.
   - For any failure, look at the `vc` waveform in `sim/top_reg_<mode>.raw`.
2. **One full run of the new repo deck**, to confirm `.csparam` and the LOCK line work in the real PLL netlist. Mode 16 (7 µs) is cheapest, roughly 1 h single-threaded.
   - Copy `sim/tb_efx_pll96_top_reg.spice` and `sim/config_16.inc` (as `config.inc`) and `sim/.spiceinit` to a scratch directory.
   - Add `set num_threads = 1` after `.control`.
   - Run it once a CPU core is free.
3. **`sim/top_reg.sh`:** consider running modes in parallel and printing the `LOCK` lines. Not requested yet.
4. **User decision pending: non-descending lvdig symbols.**
   - In the lvdig repo:
     - Make the symbols `type=primitive` with `format="@name @pinlist @VGND @VNB @VPB @VPWR @prefix<cell>"`.
     - Add a tracked `spice/sky130_efx_lvdig.lib.spice` with `.lib` sections sch/ext/c/rc.
     - Commit the generated library netlists.
   - In this repo:
     - Add the `.lib` line to the testbenches.
     - Put the Makefile back to the template version.
     - Pass the lvdig netlist to netgen for LVS.
   - This would remove the harmless xschem exit-10 errors. Effort is about 1–2 h. First test whether ngspice-43 resolves a relative `.include` against the including file's directory.
5. **Commit, when the user asks.**
   - `git add sim/` too: the `tb_*.spice` netlists are untracked.
   - The lvdig submodule shows `Am`, with a local change to `dependencies/sky130_efx_ip__lvdig/xschem/sky130_efx_lvdig__mux2_1.sch` that the agent didn't make. Ask the user before committing the submodule pointer.
6. **Template sync:** propagate the Makefile exit-10 handling to `~/Projects/sky130_efx_ip__template`. Unnecessary if item 4 goes ahead.
7. **Leave alone until the user says otherwise:**
   - The old `sdiv*` cells and the `sdiv_mm_reg` bench, which still uses the removed `VS*`/`VP*` params.
   - The PFD bench: the user will review it before it is run.

## 4. Relevant references

- Project guide: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`. Spec and programming table: `/home/ejf/Projects/sky130_efx_ip__pll96/README.md`.
- Prior pickup: `/home/ejf/Projects/sky130_efx_ip__pll96/doc/pickups/superseded/pickup-2026-11-10-div-f-feedback-divider.md`.
- Scratch, specific to this session and possibly gone later: `/tmp/nix-shell.HoGMN0/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/`, which holds:
  - `topreg/`: `run1.sh`, `lockcheck.sh`, and per-mode run directories
  - `fmax/`: div_f Fmax scripts and logs
  - `csparam/`: syntax test decks
- Memory: `ngspice-threads-parallel.md` (use `set num_threads = 1` and run at most 8 parallel processes) and `pgrep-self-match.md` (use `pgrep -f '[n]gspice -b'`, never a bare `-f` pattern, which kills the agent's own shell).

## 5. Recommended next-session opening move

From `/home/ejf/Projects/sky130_efx_ip__pll96`, inside `nix develop ~/nix-efx`:

1. Run `pgrep -fa '[n]gspice -b'` and `ls -la sim/top_reg_*.out` to see whether the locking batch finished.
2. Run `.../scratchpad/topreg/lockcheck.sh <mode>` for each finished mode.
   - If the scratch directory is gone, run the same check from ngspice by hand: `load sim/top_reg_<mode>.raw`, then the `meas` lines from the control block in `sim/tb_efx_pll96_top_reg.spice`, with `t_sim` = 20e-6 (8e-6 for mode 16).
3. Tabulate pass/fail, f_out, vc/vdd and the supply currents for the user.
4. Any mode the batch didn't finish should be rerun with the new repo deck: copy `sim/config_<F>.inc` to `config.inc` and add `set num_threads = 1`, running at most 8 in parallel.
