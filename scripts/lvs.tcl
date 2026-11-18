# Netgen LVS of one cell, run by `make lvs` from lvs/:
#
#   LVS_CELL=<cell> LVS_SETUP=<netgen setup.tcl> LVS_LIBS="<lib.cdl> ..." \
#     netgen -batch source ../scripts/lvs.tcl
#
# Layout side: layout/<cell>.spice (Magic). Schematic side: the LVS_LIBS
# netlists, then schematic/<cell>.spice (xschem), read into one netlist.
# LVS_LIBS are the dependencies' cell libraries (dependencies/*/cdl/*.cdl, e.g.
# lvdig's sky130_efx_lvdig.cdl): their cells have primitive symbols, so xschem
# writes only the instance lines, and without the definitions Netgen makes a
# placeholder with numbered pins that it can't pair with the layout's named
# ones. (`netgen -batch lvs` reads only one file per side.) Report: <cell>.out.
set cell $env(LVS_CELL)
set lay [readnet spice layout/$cell.spice]
set sch -1
foreach f [concat $env(LVS_LIBS) schematic/$cell.spice] {
    if {$sch < 0} {
        set sch [readnet spice $f]
    } else {
        readnet spice $f $sch
    }
}
lvs "$lay $cell" "$sch $cell" $env(LVS_SETUP) $cell.out
