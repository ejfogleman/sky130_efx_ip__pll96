# Reference: the batch script that built efx_pll96_vco_ls (2026-11-17), in the
# style of the sky130_efx_lvdig cells (dependencies/sky130_efx_ip__lvdig):
# one 3.24 um row, rails VGND -0.36..0 / VPWR 2.88..3.24 (li + met1), nmos
# diffusion bottom at y 0.18, hvt pmos diffusion top at y 2.70, gates
# contacted in the gap between the rows (y 1.08-1.44), li routing, met1 only
# where li and poly can't route. Rerunning it rebuilds the cell: it deletes
# the target .mag files first.
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_vco_ls.tcl
#
# Drawn in lvdig's orientation as below, then mirrored left-right as the last
# step (so in the saved cell j0 is at the right; x below is before the flip).
# Floorplan: taps at both ends (x 0-0.72 and W-0.72..W, as lvdig's
# tapvpwrvgnd_1, tie nwell to vdd and pwell to gnd: the schematic's bodies),
# then 20 gate columns j = 0..19 on
# the lambda grid, source/drain strip t at X(t) = 1.08 + 0.54 t (t = 0..20),
# gate j at X(j) + 0.27. W 0.54 nmos, W 1.08 pmos (M8: W 0.99, 4 fingers =
# the schematic's 3.96).
#
#   j      0   1-4   5   6-7  8-9  10  11-14  15  16-17  18-19
#   pmos   M5  M10   M5  M6   -    M3  M8     M3  M4     -
#   nmos   -   M9    -   M2   M2   -   M7     -   M1     M1
#   gate   lsn lsn   lsn inn  inn  lsp lsp    lsp inp    inp
#
# pmos strips t0-t8: net1 vdd outp vdd outp vdd net1 lsp net1;
#            t10-t18: net2 vdd outn vdd outn vdd net2 lsn net2
# nmos strips t1-t20: gnd outp gnd outp gnd | gnd lsp gnd lsp gnd |
#            gnd outn gnd outn gnd | gnd lsn gnd lsn gnd (one island; the
#            pmos-only columns 5, 10, 15 are ungated gnd diffusion)
# Gap: one poly bar per gate net, each with a polycont pad (lsn at t5, inn
# at t8 = pin, lsp at t11, inp at t18 = pin); outp / outn are li verticals
# (t2, t4 / t12, t14) joined in the gap (pins). lsp: vertical t7, nmos
# jumper t7-t9 (t8 contact at the bottom only), t9 up into the gap to the
# lsp pad. lsn: vertical t17, nmos jumper t17-t19, met1 track (y 1.62-1.98)
# to a met1 stub on the lsn pad. net1 / net2: met1 track y 2.16-2.52.

set lvdig ../dependencies/sky130_efx_ip__lvdig/scripts
source $lvdig/mag_lvdig_lib.tcl   ;# um li pl lvdig_rails save_drc

proc pa {layer x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint $layer }
proc via {x y} {
    um [expr {$x - 0.085}] [expr {$y - 0.085}] [expr {$x + 0.085}] [expr {$y + 0.085}]
    paint viali
}
proc m1 {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint m1 }

# Island cell at absolute coordinates (placed at 0 0), as lvdig's
# scripts/mag_lvdig_flop.tcl. pol n: diffusion bottom at y 0.18; p: top at
# y 2.70. rects: {x0 x1 w}; gates {xc w type}; contacts {x c0 c1 l0 l1}
# (licon y and li y, absolute).
proc island {name pol rects gates contacts} {
    load $name
    if {$pol eq "n"} {
        lassign {ndiff ndiffc pwell} diff cont well
    } else {
        lassign {pdiff pdiffc nwell} diff cont well
    }
    set xa 1e9; set xb -1e9
    foreach r $rects {
        lassign $r x0 x1 w
        if {$pol eq "n"} { pa $diff $x0 0.18 $x1 [expr {0.18 + $w}] } \
        else { pa $diff $x0 [expr {2.70 - $w}] $x1 2.70 }
        set xa [expr {min($xa, $x0)}]; set xb [expr {max($xb, $x1)}]
    }
    if {$pol eq "n"} { pa $well [expr {$xa - 0.18}] 0 [expr {$xb + 0.18}] 1.08 } \
    else { pa $well [expr {$xa - 0.18}] 1.44 [expr {$xb + 0.18}] 3.42 }
    foreach g $gates {
        lassign $g xc w type
        set g0 [expr {$xc - 0.075}]; set g1 [expr {$xc + 0.075}]
        if {$pol eq "n"} { set b 0.18; set t [expr {0.18 + $w}] } \
        else { set b [expr {2.70 - $w}]; set t 2.70 }
        pa $type $g0 $b $g1 $t
        pa poly $g0 [expr {$b - 0.18}] $g1 $b
        pa poly $g0 $t $g1 [expr {$t + 0.18}]
    }
    foreach c $contacts {
        lassign $c x c0 c1 l0 l1
        pa $cont [expr {$x - 0.085}] $c0 [expr {$x + 0.085}] $c1
        pa li [expr {$x - 0.18}] $l0 [expr {$x + 0.18}] $l1
    }
    save_drc $name
}

proc X {t} { expr {1.08 + 0.54 * $t} }
proc G {j} { expr {1.08 + 0.54 * $j + 0.27} }

set cell efx_pll96_vco_ls
set W 12.96
foreach c [list $cell nmos_isl_vco_ls pmos_isl_vco_ls_a pmos_isl_vco_ls_b] {
    file delete -force $c.mag
}

# contacts (lvdig_mos geometry): nmos W 0.54 f / b, pmos W 1.08 f, W 0.99 f,
# and the strips shared by W 1.08 and W 0.99 fingers
set nf {0.36 0.54 0.18 0.72}
set nb {0.275 0.445 0.18 0.54}
set pf {1.80 2.52 1.62 2.70}
set p9 {1.89 2.61 1.71 2.70}
set ps {1.89 2.52 1.62 2.70}

# nmos island: one diffusion t1..t20, gates on 16 columns
set g {}; set c {}
foreach j {1 2 3 4 6 7 8 9 11 12 13 14 16 17 18 19} { lappend g [list [G $j] 0.54 nmos] }
for {set t 1} {$t <= 20} {incr t} {
    lappend c [list [X $t] {*}[expr {$t in {8 18} ? $nb : $nf}]]
}
island nmos_isl_vco_ls n [list [list [expr {[X 1] - 0.18}] [expr {[X 20] + 0.18}] 0.54]] $g $c

# pmos island a: t0..t8, W 1.08, gates j0..j7
set g {}; set c {}
for {set j 0} {$j <= 7} {incr j} { lappend g [list [G $j] 1.08 pmoshvt] }
for {set t 0} {$t <= 8} {incr t} { lappend c [list [X $t] {*}$pf] }
island pmos_isl_vco_ls_a p [list [list [expr {[X 0] - 0.18}] [expr {[X 8] + 0.18}] 1.08]] $g $c

# pmos island b: t10..t18; j10 / j15-17 W 1.08, j11-14 W 0.99 (M8). The
# width steps 0.09 inside the shared strips t11 / t15, so the W 1.08 diffusion
# extends 0.285 past its gate (poly.7 0.25) and stays 0.105 from the W 0.99
# gates' poly (poly.4 0.075)
set g {}; set c {}
foreach j {10 15 16 17} { lappend g [list [G $j] 1.08 pmoshvt] }
foreach j {11 12 13 14} { lappend g [list [G $j] 0.99 pmoshvt] }
for {set t 10} {$t <= 18} {incr t} {
    if {$t in {11 15}} { set k $ps } elseif {$t in {12 13 14}} { set k $p9 } else { set k $pf }
    lappend c [list [X $t] {*}$k]
}
island pmos_isl_vco_ls_b p [list \
    [list [expr {[X 10] - 0.18}] [expr {[X 11] + 0.09}] 1.08] \
    [list [expr {[X 11] - 0.09}] [expr {[X 15] + 0.09}] 0.99] \
    [list [expr {[X 15] - 0.09}] [expr {[X 18] + 0.18}] 1.08]] $g $c

# --- the cell ---
load $cell
foreach i {nmos_isl_vco_ls pmos_isl_vco_ls_a pmos_isl_vco_ls_b} { box values 0 0 0 0; getcell $i child 0 0 }
lvdig_rails $W

# taps at both ends (lvdig tapvpwrvgnd_1 geometry, 0.72 wide from x0):
# p-tap to VGND, n-tap to VPWR
proc tap {x0} {
    set a [expr {$x0 + 0.18}]; set b [expr {$x0 + 0.54}]
    set ca [expr {$x0 + 0.275}]; set cb [expr {$x0 + 0.445}]
    pa psubdiff $a 0 $b 0.90
    pa psubdiffcont $ca 0.12 $cb 0.78
    pa li $a 0 $b 0.90
    pa nsubdiff $a 1.62 $b 2.88
    pa nsubdiffcont $ca 1.74 $cb 2.76
    pa li $a 1.62 $b 2.88
}
tap 0
tap [expr {$W - 0.72}]

# rail straps: pmos vdd strips, nmos gnd strips
foreach t {1 3 5 11 13 15} { li [expr {[X $t] - 0.18}] 2.52 [expr {[X $t] + 0.18}] 2.88 }
foreach t {1 3 5 6 8 10 11 13 15 16 18 20} { li [expr {[X $t] - 0.18}] 0 [expr {[X $t] + 0.18}] 0.36 }

# gate poly to the gap: nmos 0.90 -> 1.08, the W 0.99 pmos 1.53 -> 1.44
foreach j {1 2 3 4 6 7 8 9 11 12 13 14 16 17 18 19} {
    pl [expr {[G $j] - 0.075}] 0.90 [expr {[G $j] + 0.075}] 1.08
}
foreach j {11 12 13 14} { pl [expr {[G $j] - 0.075}] 1.44 [expr {[G $j] + 0.075}] 1.53 }
# gate bars and pads
foreach {j0 j1 t} {0 5 5  6 9 8  10 15 11  16 19 18} {
    pl [expr {[G $j0] - 0.075}] 1.08 [expr {[G $j1] + 0.075}] 1.44
    um [expr {[X $t] - 0.18}] 1.08 [expr {[X $t] + 0.18}] 1.44; efx::polycont_draw
}

# li: outputs (verticals joined in the gap), lsp, lsn
foreach t {2 4 7 12 14 17} { li [expr {[X $t] - 0.18}] 0.18 [expr {[X $t] + 0.18}] 2.70 }
li [expr {[X 2] - 0.18}] 1.08 [expr {[X 4] + 0.18}] 1.44
li [expr {[X 12] - 0.18}] 1.08 [expr {[X 14] + 0.18}] 1.44
li [expr {[X 7] - 0.18}] 0.72 [expr {[X 9] + 0.18}] 0.90
li [expr {[X 9] - 0.18}] 0.18 [expr {[X 9] + 0.18}] 1.44
li [expr {[X 9] - 0.18}] 1.08 [expr {[X 11] + 0.18}] 1.44
li [expr {[X 17] - 0.18}] 0.72 [expr {[X 19] + 0.18}] 0.90

# met1: lsn stub on its pad + track to t17; net1, net2
m1 [expr {[X 5] - 0.18}] 1.08 [expr {[X 5] + 0.18}] 1.98
m1 [expr {[X 5] - 0.18}] 1.62 [expr {[X 17] + 0.18}] 1.98
via [X 5] 1.26
via [X 17] 1.80
m1 [expr {[X 0] - 0.18}] 2.16 [expr {[X 8] + 0.18}] 2.52
m1 [expr {[X 10] - 0.18}] 2.16 [expr {[X 18] + 0.18}] 2.52
foreach t {0 6 8 10 16 18} { via [X $t] 2.34 }

# pins, in the schematic's port order: vdd inp outp outn inn gnd
um 0 2.88 0.36 3.24; efx::pin_place vdd m1 0 FreeSans 0.18 center {} bidirectional power
um [expr {[X 18] - 0.18}] 1.08 [expr {[X 18] + 0.18}] 1.44
efx::pin_place inp li 0 FreeSans 0.18 center {} input signal
um [expr {[X 3] - 0.18}] 1.08 [expr {[X 3] + 0.18}] 1.44
efx::pin_place outp li 0 FreeSans 0.18 center {} output signal
um [expr {[X 13] - 0.18}] 1.08 [expr {[X 13] + 0.18}] 1.44
efx::pin_place outn li 0 FreeSans 0.18 center {} output signal
um [expr {[X 8] - 0.18}] 1.08 [expr {[X 8] + 0.18}] 1.44
efx::pin_place inn li 0 FreeSans 0.18 center {} input signal
um 0 -0.36 0.36 0; efx::pin_place gnd m1 0 FreeSans 0.18 center {} bidirectional ground

# mirror left-right (user, 2026-11-17): the j0 / M5 end at the right; rails
# stay (VGND bottom, VPWR top). The drawn extent (x 0..W: rails and wells) is
# symmetric about the FIXED_BBOX centre, so flipping it in place keeps the
# frame.
um 0 -0.54 $W 3.42
select area
sideways
# sideways turns the label text 180 degrees; set it back upright
select area label
setlabel rotate 0
select clear
save_drc $cell
quit -noprompt
