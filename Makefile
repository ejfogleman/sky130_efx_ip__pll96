# Netlists and LVS for this IP block. Run from the repo root, with Magic,
# xschem and Netgen on PATH (e.g. inside nix develop ~/nix-efx).
#
#   make sim                netlist every xschem/tb_*.sch into sim/ (ngspice)
#   make sim/tb_foo.spice   one testbench
#   make lvs CELL=foo       netlists of foo from xschem and Magic, then Netgen
#   make pex CELL=foo       LVS, then layout-extracted netlist lvs/pex_<PEX>/foo.spice
#                           (PEX=c default: parasitic C; none: devices; rc: R and C),
#                           ports in the schematic's order
#   make clean-lvs          remove generated LVS and PEX files (keeps the folders)
#   make check              re-run the schematic and netlist checks on sim/tb_*.spice
#   make clean              clean-lvs, plus failed netlists (sim/*.spice.bad/.err);
#                           keeps the tracked netlists and simulation results
#   make help               this list
#
# Each netlist is remade only when a schematic/symbol (or, for the layout, a
# .mag) in this repo or its dependencies is newer than it.

PDK      ?= sky130A
PDK_ROOT ?= $(HOME)/.ciel
NETGEN_SETUP := $(PDK_ROOT)/$(PDK)/libs.tech/netgen/$(PDK)_setup.tcl

XSCHEM := xschem -n -s -q -x --rcfile xschemrc
MAGIC  := magic -dnull -noconsole

# Any schematic or symbol change can affect a netlist (hierarchy), so every
# netlist depends on all of them; likewise every layout netlist on all .mag.
SCH_FILES := $(wildcard xschem/*.sch xschem/*.sym dependencies/*/xschem/*.sch dependencies/*/xschem/*.sym)
MAG_FILES := $(wildcard mag/*.mag dependencies/*/mag/*.mag)
TESTBENCHES := $(patsubst xschem/%.sch,sim/%.spice,$(wildcard xschem/tb_*.sch))

.PHONY: sim lvs pex clean-lvs check clean help

# Keep the netlists: make would otherwise delete them as intermediate files
# of the lvs/%.out chain once the report is written
.SECONDARY:

sim: $(TESTBENCHES)

# Output is one line per netlist written ("netlist  sim/foo.spice"), and details
# only for a failure ("FAIL ..."). make keeps going after a failed netlist, so
# every failure is listed in one run.
MAKEFLAGS += --keep-going

# xschem in batch mode (3.4.7) exits 10 and prints nothing whether or not the
# schematic has errors, so exit 0 and 10 are both accepted: the old netlist is
# removed first and the new one is checked instead (as lvdig's own Makefile
# does for LVS). Any other exit code is reported.
XSCHEM_RUN = rc=0; $(XSCHEM) $(1) || rc=$$?; \
  [ $$rc = 0 ] || [ $$rc = 10 ] || echo "  xschem exited with code $$rc"
#
# xschem also netlists some schematic errors silently: a pin and a label with
# different names on one wire (one name is dropped, depending on instance order),
# malformed device parameters such as "nf=mult=1". Two checks run on every
# netlist:
#   scripts/sch_check.sh / sch_check.tcl: on each schematic in the netlist's
#     hierarchy, inside xschem, every pin/label must name the net xschem resolved
#     where it sits (name-conflict), and must connect to something (dangling-label)
#   scripts/netlist_check.py: on the netlist, unused subckt ports, floating nets,
#     bad PDK device parameters, stale .control saves; exceptions go in
#     xschem/netlist_waivers.txt
# A netlist that fails is renamed to <netlist>.bad so it can't be simulated by
# accident. NETLIST_CHECK=0 skips both (don't use it for regressions).
NETLIST_CHECK ?= 1
CHECK := python3 scripts/netlist_check.py --waivers xschem/netlist_waivers.txt
CHECK_DEPS := scripts/netlist_check.py xschem/netlist_waivers.txt scripts/sch_check.sh scripts/sch_check.tcl
define check_netlist
	@if [ "$(NETLIST_CHECK)" = 0 ]; then echo "  WARNING: netlist checks skipped for $@"; \
	 else ok=1; scripts/sch_check.sh $@ xschem/$*.sch > /dev/null 2> $@.err || ok=0; \
	   $(CHECK) $@ 2>> $@.err || ok=0; \
	   if [ $$ok = 0 ]; then mv $@ $@.bad; \
	     echo "FAIL $@: netlist checks failed, moved to $@.bad (fix the schematic, or waive in xschem/netlist_waivers.txt)"; \
	     grep -v '^netlist_check: [0-9]* error' $@.err | sed 's/^/  /'; rm -f $@.err; exit 1; fi; \
	   rm -f $@.err; fi
endef

# Simulation netlist: a top-level testbench, into sim/ (xschemrc's netlist_dir)
sim/%.spice: xschem/%.sch $(SCH_FILES) $(CHECK_DEPS)
	@rm -f $@ $@.bad
	@echo "netlist  $@"
	@cd xschem && $(call XSCHEM_RUN,$*.sch)
	@grep -qE '^\.end$$' $@ || { echo "FAIL $@: xschem wrote no complete netlist"; rm -f $@; exit 1; }
	$(check_netlist)

# LVS schematic netlist: the cell as a .subckt
lvs/schematic/%.spice: xschem/%.sch $(SCH_FILES) $(CHECK_DEPS)
	@rm -f $@ $@.bad
	@echo "netlist  $@"
	@cd xschem && $(call XSCHEM_RUN,--tcl 'set top_is_subckt 1' -o ../lvs/schematic $*.sch)
	@grep -qE '^\.subckt $*( |$$)' $@ || { echo "FAIL $@: xschem wrote no .subckt $*"; rm -f $@; exit 1; }
	$(check_netlist)

# Re-run both checks on the existing sim/ netlists without re-netlisting
check:
	@ok=1; for n in $(wildcard sim/tb_*.spice); do \
	  t=$$(basename $$n .spice); scripts/sch_check.sh $$n xschem/$$t.sch || ok=0; done; \
	 $(CHECK) $(wildcard sim/tb_*.spice) || ok=0; [ $$ok = 1 ]

# LVS layout netlist: Magic in mag/ (reads ./.magicrc), .ext files to lvs/layout
lvs/layout/%.spice: mag/%.mag $(MAG_FILES)
	cd mag && printf '%s\n' 'load $*' 'extract path ../lvs/layout' 'extract all' \
	  'ext2spice lvs' 'ext2spice -p ../lvs/layout -o ../lvs/layout/$*.spice' \
	  'quit -noprompt' | $(MAGIC)

# Netgen report, remade when either netlist changes
lvs/%.out: lvs/layout/%.spice lvs/schematic/%.spice
	cd lvs && netgen -batch lvs "layout/$*.spice $*" "schematic/$*.spice $*" \
	  $(NETGEN_SETUP) $*.out

# Netgen always exits 0, so check the report: make fails on a mismatch
ifeq ($(CELL),)
lvs:
	@echo "usage: make lvs CELL=<cell>"; exit 2
else
lvs: lvs/$(CELL).out
	@if grep -q "Circuits match uniquely" $<; then echo "LVS $(CELL): match"; \
	 else echo "LVS $(CELL): MISMATCH, see $<"; grep "Final result" $<; exit 1; fi
endif

# Parasitic extraction (as lvdig's lvs/pex_<mode> flow), for simulating a cell
# from its layout: PEX=none devices only, PEX=c (default) parasitic C, PEX=rc
# parasitic R and C (Magic extresist). The cell is flattened into an unsaved
# <cell>_flat and extracted in lvs/pex_<mode>/ (Magic starts in mag/ to read
# .magicrc, then cd's there). Flat, so every device gets its own source/drain
# area; extresist also needs a flat cell it can find by name, and reads the
# .ext/.sim files from the working directory. scripts/pex_ports.py then renames
# the .subckt back to <cell> and puts its ports in the schematic's order (Magic
# orders them by the labels' port numbers, xschem by the symbol's pins).
# `make pex` runs LVS first and stops on a mismatch.
PEX ?= c
ifeq ($(filter $(PEX),none c rc),)
$(error PEX must be none, c or rc, not '$(PEX)')
endif
PEX_HEAD = 'load $*' 'flatten $*_flat' 'load $*_flat' 'select top cell' \
  'cd $(CURDIR)/$(@D)' 'extract all'
PEX_OUT  = 'ext2spice lvs' 'ext2spice hierarchy off' 'ext2spice subcircuit top on'
PEX_END  = 'ext2spice -o $(CURDIR)/$(@D)/$*.raw.spice' 'quit -noprompt'
PEX_PORTS = python3 scripts/pex_ports.py $(@D)/$*.raw.spice lvs/schematic/$*.spice $@

lvs/pex_none/%.spice: mag/%.mag $(MAG_FILES) lvs/schematic/%.spice scripts/pex_ports.py
	@mkdir -p $(@D)
	cd mag && printf '%s\n' $(PEX_HEAD) $(PEX_OUT) $(PEX_END) | $(MAGIC) >/dev/null
	$(PEX_PORTS) none

lvs/pex_c/%.spice: mag/%.mag $(MAG_FILES) lvs/schematic/%.spice scripts/pex_ports.py
	@mkdir -p $(@D)
	cd mag && printf '%s\n' $(PEX_HEAD) $(PEX_OUT) 'ext2spice cthresh 0' $(PEX_END) \
	  | $(MAGIC) >/dev/null
	$(PEX_PORTS) c

lvs/pex_rc/%.spice: mag/%.mag $(MAG_FILES) lvs/schematic/%.spice scripts/pex_ports.py
	@mkdir -p $(@D)
	cd mag && printf '%s\n' $(PEX_HEAD) 'ext2sim labels on' 'ext2sim' \
	  'extresist tolerance 10' 'extresist cell $*_flat' 'extresist all' \
	  $(PEX_OUT) 'ext2spice cthresh 0' 'ext2spice extresist on' $(PEX_END) \
	  | $(MAGIC) >/dev/null
	$(PEX_PORTS) rc

ifeq ($(CELL),)
pex:
	@echo "usage: make pex CELL=<cell> [PEX=none|c|rc]"; exit 2
else
pex: lvs
	@$(MAKE) --no-print-directory lvs/pex_$(PEX)/$(CELL).spice
endif

clean-lvs:
	rm -f lvs/*.out lvs/schematic/*.spice lvs/layout/*.spice lvs/layout/*.ext \
	  lvs/pex_*/*.spice lvs/pex_*/*.ext lvs/pex_*/*.sim lvs/pex_*/*.nodes

clean: clean-lvs
	rm -f sim/*.spice.bad sim/*.spice.err

# Prints the target list from the comment at the top of this file
help:
	@sed -n '/^#   make /,/^#$$/p' $(firstword $(MAKEFILE_LIST)) | sed '$$d; s/^#//'
