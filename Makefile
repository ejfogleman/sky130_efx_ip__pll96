# Netlists and LVS for this IP block. Run from the repo root, with Magic,
# xschem and Netgen on PATH (e.g. inside nix develop ~/nix-efx).
#
#   make sim                netlist every xschem/tb_*.sch into sim/ (ngspice)
#   make sim/tb_foo.spice   one testbench
#   make lvs CELL=foo       netlists of foo from xschem and Magic, then Netgen
#   make clean-lvs          remove generated LVS files (keeps the folders)
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

.PHONY: sim lvs clean-lvs check clean help

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

clean-lvs:
	rm -f lvs/*.out lvs/schematic/*.spice lvs/layout/*.spice lvs/layout/*.ext

clean: clean-lvs
	rm -f sim/*.spice.bad sim/*.spice.err

# Prints the target list from the comment at the top of this file
help:
	@sed -n '/^#   make /,/^#$$/p' $(firstword $(MAKEFILE_LIST)) | sed '$$d; s/^#//'
