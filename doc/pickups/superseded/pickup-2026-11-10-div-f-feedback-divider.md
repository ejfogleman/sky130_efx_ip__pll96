# Fresh-context pickup -- new 5-bit feedback divider div_f verified; lvdig cells, efx rename, sim/ layout all uncommitted

**Written**: 2026-11-10 (first pickup in this repo)
**Repo**: sky130_efx_ip__pll96, branch `main`
**HEAD**: `afa3e7b` -- "Update README.md". **Everything below is uncommitted** (about 86 entries in `git status --short`). The user has not asked for a commit yet; when asked, end the message with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

Project background: CLAUDE.md at `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md` (layout, tools, commands, sim workflow, design hierarchy). Tools come from `nix develop ~/nix-efx`; the PDK is at `~/.ciel/sky130A`.

## 1. What landed this session (uncommitted working tree; file list from this session's edits)

Newest first.

- **Feedback divider replaced by `div_f`** (`/home/ejf/Projects/sky130_efx_ip__pll96/xschem/efx_pll96_div_f.{sch,sym}`, drawn by the user). It is a 5-bit synchronous down-counter clocked by the VCO through a `clkbuf_2` (rising edge). Bits 1–4 are `edfxbp_1` toggle flops (enable = borrow from the lower bits) and bit 0 is a `dfxbp_2`, each with a `mux2_1` load mux. State 1 (00001) is decoded (`nor2` + `nor3` + `and2`) and registered in `dfxtp_2` `x16`, whose Q is the output `q` and, through `buf_2`, the load select `ld`. Program **`divf_c[4:0] = N−1`**, N = 2–32 (code 0 gives ÷33, which is unused). The top cell `efx_pll96.sch` instantiates it with pins `divf_c[4:0]`. The old `sdiv_mm`/`sdiv23`/`sdiv_p`/`sdiv_s` cells and their benches are no longer used by the top cell. **The user said to leave them in place for now.**
- **New testbench** `/home/ejf/Projects/sky130_efx_ip__pll96/xschem/tb_efx_pll96_div_f.sch`. Its control block loops `cmin..cmax` (default 0..31), sets the `VC0`–`VC4` sources with `alter`, and prints one line per code: `DIVF c= <code> N= <out period / clk period> idd= <avg A>`. N = 0 means the output isn't toggling. All runs are appended to one file, `tb_efx_pll96_div_f.raw`. It uses `set num_threads = 1` **on purpose**; the user asked for this to be restored.
- **Config files updated for div_f.** In `/home/ejf/Projects/sky130_efx_ip__pll96/sim/config_*.inc`, the old `VS*`/`VENS`/`VP*`/`VEN*` were replaced by `VC0`–`VC4`, with a header comment such as `* N = 20, divf_c = N-1 = 19 = 10011`.
  - `config_5w` and `config_10w` were changed to match the README's wide-bandwidth rows: N = 20 and 10, `T_VCO=10n`, `lpf_rsc` = 01, `chp_b` = 100.
  - `sim/config.inc` is now a copy of `config_16.inc`.
- **README** (`/home/ejf/Projects/sky130_efx_ip__pll96/README.md`) changed in three places:
  - Programming table: columns are now F_ref, F_out, N, divr, `divf_c[4:0]`, lpf_csc, lpf_rsc, chp_b.
  - Pinout: `divf_s`/`divf_p`/`divf_en`/`divf_ens` replaced by `divf_c[4:0]`.
  - Spec table: feedback divider range is now 2–32.
- **`tb_efx_pll96_top_reg.sch` bug fixed.** Its divider pins were labeled `f0`–`f4` while the sources drove `c0`–`c4`, so `divf_c` was floating. The labels are now `c0`–`c4`.
- **`tb_efx_pll96_top_template.sch` rebuilt** from the fixed `top_reg` circuit, keeping the template's own code blocks (params come from `xschem/top_reg.sch`, which includes `config.inc` and then this netlist; the raw output is `tb_efx_pll96_top.raw`).
- **CLAUDE.md updated** for div_f, the `VC*` params and the new bench.
- **Earlier this session**, also uncommitted:
  - The template infrastructure was brought in (Makefile, xschemrc, `.magicrc`, `efx.tcl`, title syms, `sim/.spiceinit`, `LICENSE-MPL-2.0`).
  - All `ejf_pll96*` files were `git mv`'d to `efx_pll96*`.
  - The lvdig submodule was added at `dependencies/sky130_efx_ip__lvdig`, pinned at `aa30658`.
  - 52 PDK `sky130_fd_sc_ls` cell instances were swapped to `sky130_efx_lvdig__*`.
  - The old asynchronous divider (`div_mm`/`div23`/`div_p`/`div_s`) was deleted.
  - The Makefile's netlist rules were changed to ignore xschem's exit code 10 (see the gotchas in §2).
  - Some changes were made by the user or another actor at the same time: the move from `xschem/simulation/` to `sim/`, and `AGENTS.md` (a symlink to CLAUDE.md).

## 2. Current state / gate status

Verified this session (tt, 1.8 V, 27 °C unless stated):

```
make sim                     # all 10 sim/tb_*.spice netlists end in ".end"; make exits 0
                             # (expect many "Error: Symbol sky130_efx_lvdig__X.sym: schematic pin: VGND not in symbol"
                             #  and "Error 10 (ignored)" lines -- harmless, see gotchas)
cd sim && ngspice -b -o tb_efx_pll96_div_f.out tb_efx_pll96_div_f.spice
                             # 32 DIVF lines; codes 1..31 give N = c+1, code 0 gives 33. ~48 min single-threaded.
```

**div_f results, current version:**
- **Function:** all 32 codes passed at 96 MHz, run as 8 parallel single-thread chunks of 4 codes (about 10 minutes). Supply current is about 18–21 µA (27 µA at ÷2).
- **Fmax:**
  - tt/1.8 V/27 °C: passes 1151 MHz with codes 23 and 31, and 1200 MHz with codes 1 and 5.
  - ss/1.62 V/85 °C: passes 719 MHz, fails 734 MHz, for codes 1, 5, 23 and 31.
  - All spot checks at 0.6× and 0.85× of each limit passed, so pass/fail is monotonic in frequency.
  - Requirement: about 106 MHz (the maximum VCO frequency).
  - The tt limit is probably the borrow chain into bit 4. No waveform was traced to confirm it.
- **Earlier div_f revision**, which used a combinational terminal count at 00000 to drive the loads: 787 MHz at tt and 483 MHz at ss. A waveform trace showed bit 4's load mux getting `tc` late, which is what led to the registered-load fix.
- **Old `sdiv_mm` divider, for reference:** ss Fmax 563 MHz in the swallow modes. Its pass/fail was not monotonic, because the decoded `ld` glitched and was then sampled at the VCO rate.

**Not run:** any PLL top-level sim with div_f (`top_reg.sh`; a single top_reg run previously took more than 1.5 h); the PFD bench (the user wants to review it first); LVS.

**Gotchas (verified cause):**
- **xschem exit 10.** It happens on any netlist using lvdig cells. lvdig symbols are `type=subcircuit` and descend into their cell schematics, which draw VGND/VNB/VPB/VPWR as pins, while the symbols pass power as properties. The pin check fails, but the netlist is complete. PDK `sky130_stdcells` symbols are `type=primitive` with no schematics, so they never showed this.
- **ngspice threads.** spinit sets `num_threads=8`. On small circuits that gives no speedup and 8× the CPU, and several ngspice processes in parallel then overload the machine. Use `set num_threads = 1` and run up to `nproc` (8) processes in parallel.
- **`pkill -f` / `pgrep -f` can match the shell running them,** because the pattern is in its own command line. That killed or suspended the agent's own shell twice. Use a bracket pattern such as `pgrep -f '[n]gspice -b'`.
- **`sim/tb_*.spice` are untracked** (`?? sim/`), although CLAUDE.md says testbench netlists are tracked. They need `git add` when committing.
- **The lvdig submodule shows `Am`**, with a local modification to `dependencies/sky130_efx_ip__lvdig/xschem/sky130_efx_lvdig__mux2_1.sch`, not made by the agent. Check with the user before committing the submodule pointer.

## 3. What's still to do

- **Decide on non-descending lvdig symbols** (waiting on the user's answer). The proposal, in the lvdig repo (`~/Projects/sky130_efx_ip__lvdig`):
  1. Make the cell symbols `type=primitive` with `format="@name @pinlist @VGND @VNB @VPB @VPWR @prefix<cell>"`, in lvdig's port order.
  2. Add a tracked wrapper, `spice/sky130_efx_lvdig.lib.spice`, with `.lib` sections `sch` (`../cdl/sky130_efx_lvdig.cdl`), `ext` (`sky130_efx_lvdig.spice`), `c` (`_c.spice`) and `rc` (`_rc.spice`).
  3. Commit the generated library netlists, which are currently git-ignored (`cdl/*.cdl`, `*.spice`).

  Then, in this repo:
  - Add `.lib ../dependencies/sky130_efx_ip__lvdig/spice/sky130_efx_lvdig.lib.spice sch` to each testbench.
  - Put the Makefile back to the template version.
  - Pass the lvdig netlist to netgen for `make lvs`.

  Unverified: whether ngspice-43 resolves a relative `.include` against the including file's directory. Test that first. Effort: about 1–2 h.
- **PLL top-level regression with div_f** (`cd sim && ./top_reg.sh`, or a single `top_reg` mode). This is the first closed-loop check of the new divider and configs. It is slow (hours), so run modes as parallel single-thread processes, at most 8.
- **Commit, when the user asks.** It's large: renames, the submodule, the template files and the new divider. `git add sim/` too.
- **Propagate the Makefile exit-10 handling to the template** (`~/Projects/sky130_efx_ip__template`). This becomes unnecessary if the lvdig symbols become non-descending.
- **Old `sdiv*` cells and benches.** `tb_efx_pll96_sdiv_mm_reg` and `sdiv_mm_reg.sh` still use the removed `VS*`/`VP*` params and won't run with the new configs. The user said to leave them for now.
- **PFD bench review.** The user will review it first; don't run it until they have.

## 4. Relevant references

- Project guide: `/home/ejf/Projects/sky130_efx_ip__pll96/CLAUDE.md`. Spec and programming table: `/home/ejf/Projects/sky130_efx_ip__pll96/README.md`.
- lvdig library: `/home/ejf/Projects/sky130_efx_ip__lvdig` (its `CLAUDE.md` and `Makefile`; `make libcdl`, and `make libspice PEX=none|c|rc`).
- Fmax scripts (scratch, session-specific and may be gone): `/tmp/nix-shell.HoGMN0/claude-1000/-home-ejf-Projects-sky130-efx-ip--pll96/1950bf6b-c8f0-4d1c-8c0d-d1fb988acbad/scratchpad/fmax/`
  - `divf_run.sh <code> <f MHz> <corner> <VDD> <temp>` copies the repo's `sim/tb_efx_pll96_div_f.spice` and edits it for one code, corner and frequency. It passes if the measured N is within 0.05 of c + 1.
  - `divf_fmax.sh <corner> <VDD> <temp> <start MHz> <codes...>` steps the frequency up ×1.4 until a failure, bisects to 25 MHz, then spot-checks 0.6× and 0.85×.
  - Logs are in `logs/`, runs in `divf_runs/`, and the previous revision's runs in `divf_runs_v1/`.
- Template: `/home/ejf/Projects/sky130_efx_ip__template`.

## 5. Recommended next-session opening move

From `/home/ejf/Projects/sky130_efx_ip__pll96`, inside `nix develop ~/nix-efx`:
1. Run `git status --short | wc -l` (expect about 86) and confirm nothing has been committed since `afa3e7b`.
2. Run `make sim`; all 10 `sim/tb_*.spice` should end in `.end`.
3. As a quick div_f sanity check, in a scratch copy of `sim/tb_efx_pll96_div_f.spice`, set `cmin = cmax = 23` and run it. Expect `DIVF c= 23 N= 24` in about 1.5 minutes.
4. Ask the user two things: whether to go ahead with the non-descending lvdig symbols plus the `.lib` view wrapper, and whether to start the closed-loop `top_reg` runs with div_f.
