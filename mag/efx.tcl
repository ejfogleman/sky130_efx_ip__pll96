# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# efx lambda MOS for Magic: the Tcl counterpart of efx_primitives.nmos()/pmos().
#
# Spec: docs/magic-gencell-spec.md. Geometry and coordinates follow _mos() in
# efx_primitives.py: S/D columns at x = i * sd_pitch(length), diffusion from
# y = 0 to n*L. Rules are in PRIMITIVES.md, "Project layout conventions".
# Implants and NPC are not painted; Magic generates them on GDS output.
#
# Gencells efx::nmos, efx::pmos, efx::ppolyres, efx::xpolyres and efx::mimcap:
# _defaults, _convert, _dialog, _check and _draw. The "efx" menu in the layout
# window places them, and its "lambda grid + snap" entry sets an L grid.
# efx::subring_draw and efx::nwring_draw paint a p-tap, or n-well and n-tap,
# guard ring around the box, and efx::polycont_draw, efx::mcon_draw and
# efx::via1_draw a poly contact, li-met1 contact or met1-met2 via filling it
# (not gencells).

global Opts
namespace eval efx {
    # Lambda, as in efx_tech.LAMBDA. Not Magic's "lambda" (its internal unit).
    variable L 0.18
    # Sky130 rule values: Magic has no get_grule(), so they are typed once here
    variable licon 0.17	;# licon width (licon.1)
    variable poly_min 0.15	;# poly width (poly.1a), the shortest gate
    variable licon_gate 0.055	;# diffusion licon to gate (licon.11)
    # via1 contact area inset: via.5a / met2.5 0.085 less the 0.055 met1
    # border Magic's via1 type keeps round its cuts (squares-grid 55)
    variable via1_in 0.03
}

# "efx" menu in each new layout window, beside the PDK's device menus
if {[catch {set Opts(callback)}]} {set Opts(callback) ""}
set Opts(callback) [subst {efx::addtechmenu \$framename; $Opts(callback)}]

proc efx::addtechmenu {framename} {
    # Same frame lookup as sky130::addtechmenu (Magic 8.1.126 and later)
    if {[catch {${framename}.titlebar cget -height}]} {
        set layoutframe ${framename}.pane.top
    } else {
        set layoutframe ${framename}
    }
    magic::add_toolkit_menu $layoutframe "efx" efx
    magic::add_toolkit_command $layoutframe "lambda grid + snap" "efx::lambda_grid" efx
    magic::add_toolkit_separator $layoutframe efx
    magic::add_toolkit_command $layoutframe "nmos (lambda)" "magic::gencell efx::nmos" efx
    magic::add_toolkit_command $layoutframe "pmos (lambda)" "magic::gencell efx::pmos" efx
    magic::add_toolkit_command $layoutframe "ppolyres (lambda)" "magic::gencell efx::ppolyres" efx
    magic::add_toolkit_command $layoutframe "xpolyres (lambda)" "magic::gencell efx::xpolyres" efx
    magic::add_toolkit_command $layoutframe "mimcap (lambda)" "magic::gencell efx::mimcap" efx
    magic::add_toolkit_command $layoutframe "substrate guard ring (1.8V)" "efx::subring_draw" efx
    magic::add_toolkit_command $layoutframe "n-well guard ring (1.8V)" "efx::nwring_draw" efx
    magic::add_toolkit_command $layoutframe "polycont" "efx::polycont_draw" efx
    magic::add_toolkit_command $layoutframe "mcon (li-met1)" "efx::mcon_draw" efx
    magic::add_toolkit_command $layoutframe "via1 (met1-met2)" "efx::via1_draw" efx
    magic::add_toolkit_separator $layoutframe efx
    magic::add_toolkit_command $layoutframe "pin ..." "efx::pin_dialog" efx
    efx::install_cell_names
}

# Gencell cell names. Magic names a gencell <type>_<6-character hash of the
# parameter values>. That hash is a folding checksum of the values run
# together, so different parameters can share a name (n 5 ltap 0 and n 9
# ltap 1 are both nmos_K4TPS2), and Magic then reuses the wrong cell without
# a message. efx gencells are instead named by their parameters, e.g.
# nmos_n6_f2_l180_tl_tr_gb, which cannot collide.
#
# Tokens, in parameter order: n<n>, f<fingers>, l<length in nm> (MOS) or
# w<nw>, l<nl> (resistors, MiM cap, in L); vt only if not std (lvt, hvt);
# a flag only when set: bt (butted), tl / tr (left / right tap), gt / gb
# (top / bottom gate bar). A parameter not listed here is spelt <key><value>.
proc efx::cell_suffix {parameters} {
    set flags {butted bt ltap tl rtap tr tgate gt bgate gb}
    set out {}
    dict for {key value} $parameters {
        if {[dict exists $flags $key]} {
            if {[string is true -strict $value]} {lappend out [dict get $flags $key]}
        } elseif {$key eq "vt"} {
            if {$value ne "std"} {lappend out $value}
        } elseif {$key eq "length" && [string is double -strict $value]} {
            lappend out l[expr {round($value * 1000)}]
        } elseif {$key in {n fingers nw nl} && [string is double -strict $value]
                && $value == round($value)} {
            lappend out [dict get {n n fingers f nw w nl l} $key][expr {round($value)}]
        } else {
            lappend out $key[regsub -all {[^A-Za-z0-9]} [string map {. p - m} $value] {}]
        }
    }
    return [join $out _]
}

# The toolkit's gencell_create, gencell_change and gencell_makecell all name
# the cell with magic::get_gencell_hash, and each has a local "library". Wrap
# it so library efx gets efx::cell_suffix; the PDK's gencells keep the hash.
#
# New cells have no file, so Magic saves them in the directory it was started
# in. So the wrapper also notes each efx gencell name with the directory of
# the edit cell (the cell it is being placed in), and after gencell_create,
# gencell_change or gencell_makecell returns, efx::file_new_cells gives every
# noted cell that still has no file ("default") that directory. A cell that
# already has a file keeps it, and so does one made while the edit cell has
# no file yet (both are then saved in the start directory, as before).
#
# Run when efx.tcl is sourced and again per window, in case the toolkit was
# not yet loaded; it wraps only once.
proc efx::install_cell_names {} {
    if {[info commands ::magic::get_gencell_hash] eq ""
            || [info commands ::magic::efx_hash_gencell_name] ne ""} {
        return
    }
    rename ::magic::get_gencell_hash ::magic::efx_hash_gencell_name
    proc ::magic::get_gencell_hash {parameters} {
        if {[uplevel 1 {info exists library}] && [uplevel 1 {set library}] eq "efx"} {
            set suffix [efx::cell_suffix $parameters]
            set type [uplevel 1 {expr {[info exists gencell_type] ? $gencell_type
                : [info exists gencell_basename] ? $gencell_basename : ""}}]
            if {$type ne ""} {efx::note_new_cell ${type}_$suffix}
            return $suffix
        }
        return [magic::efx_hash_gencell_name $parameters]
    }
    foreach p {gencell_create gencell_change gencell_makecell} {
        if {[info commands ::magic::$p] eq ""} continue
        rename ::magic::$p ::magic::efx_toolkit_$p
        proc ::magic::$p {args} [string map [list %P $p] {
            set code [catch {::magic::efx_toolkit_%P {*}$args} result options]
            efx::file_new_cells
            return -options $options $result
        }]
    }
}

# Note a gencell about to be named, with the edit cell's directory
proc efx::note_new_cell {gname} {
    variable new_cells
    set path [cellname list filepath [cellname list self]]
    if {$path eq "default" || $path eq ""} return
    # A parent in the start directory needs nothing (new cells are saved
    # there anyway), and setting "." would write "." into its use line
    set dir [file dirname $path]
    if {[file normalize $dir] eq [file normalize [pwd]]} return
    lappend new_cells $gname $dir
}

# Give each noted gencell that has no file yet its parent's directory
proc efx::file_new_cells {} {
    variable new_cells
    if {![info exists new_cells]} return
    foreach {gname dir} $new_cells {
        if {[cellname list exists $gname] != 0
                && [cellname list filepath $gname] eq "default"} {
            cellname filepath $gname $dir
        }
    }
    set new_cells {}
}
efx::install_cell_names

# Grid of L in the layout window, with the box and cursor snapped to it
# ("snap lambda" goes back to Magic's 10 nm lambda)
proc efx::lambda_grid {} {
    variable L
    grid ${L}um
    snap user
}

# S/D column pitch for a gate length, as efx_primitives.sd_pitch():
# the smallest multiple of L that keeps the 2L li1 strips off the gate
proc efx::sd_pitch {length} {
    variable L
    return [expr {(2 + ceil(round($length / $L * 1e6) / 1e6)) * $L}]
}

# Paint layer on the rectangle (x0, y0)-(x1, y1), in um, snapped to the 5 nm grid
proc efx::rect {layer x0 y0 x1 y1} {
    set c {}
    foreach v [list $x0 $y0 $x1 $y1] {
        lappend c [format %.3fum [expr {round($v * 200) / 200.0}]]
    }
    box values {*}$c
    paint $layer
}

# Port name at the point (x, y), on layer (li by default). Magic attaches the
# label to the type painted there, which on a contact (xpc under R1/R2, mimcc
# under C1) is the contact; the PDK's gencells leave theirs there too, and GDS
# gets the metal's text layer either way. Labels with the same name (B on both
# taps) share one port index. "port makeall" makes no ports here, so each label
# is made a port as it is placed, with the box set on it.
proc efx::pin {name x y {layer li}} {
    set p [list [format %.3fum $x] [format %.3fum $y]]
    box values {*}$p {*}$p
    label $name c $layer
    select area label
    set index [port_index $name]
    if {$index eq {}} {port make} else {port make $index}
    select clear
}

# Index of the edit cell's port called name, or "" if there is none. "port
# <name> index" reads the selected label, not the name, so look it up. Needs a
# selection command first: after a bare "load", "port first" returns "".
proc efx::port_index {name} {
    for {set i [port first]} {$i >= 0 && $i <= [port last]} {set i [port $i next]} {
        if {[port $i name] eq $name} {return $i}
    }
    return {}
}

# Pin at the box, as the "pin ..." dialog makes it: a label (an area label if
# the box has area; GDS then gets a pin shape, e.g. met1 68/16, as well as the
# text) made a port. layer "default" lets Magic pick the type under the box
# (on a contact, the contact); sticky keeps the label on layer. font "default"
# is Magic's unscaled text, size then ignored (the dialog starts at FreeSans,
# size L). index "" reuses the index of a port with the same name, else takes
# the next free one. class / use "default" leave the port's.
proc efx::pin_place {name layer sticky font size just index class use} {
    if {$name eq {}} {
        puts stderr "efx: pin needs a name"
        return
    }
    if {$index ne {} && ![string is integer -strict $index]} {
        puts stderr "efx: port index must be a whole number or blank (got \"$index\")"
        return
    }
    # port make works on the one label under the box: refuse a box that
    # already holds one rather than make the wrong label a port
    select area label
    set others [lmap l [lindex [what -list] 1] {
        if {[lindex $l 2] eq {}} {lindex $l 0} else continue
    }]
    select clear
    if {$others ne {}} {
        puts stderr "efx: the box already holds label(s) [join $others {, }]; move it clear of them"
        return
    }
    # a name keeps its index; an explicit index must be free or already this name's
    set existing [port_index $name]
    if {$index eq {}} {
        set index $existing
    } else {
        if {$existing ne {} && $index != $existing} {
            puts stderr "efx: $name is already port $existing; leave the index blank to reuse it"
            return
        }
        for {set i [port first]} {$i >= 0 && $i <= [port last]} {set i [port $i next]} {
            if {$i == $index && [port $i name] ne $name} {
                puts stderr "efx: port $index is already [port $i name]"
                return
            }
        }
    }
    set type [expr {$layer eq "default" ? {} : ($sticky ? "-$layer" : $layer)}]
    if {$font eq "default"} {
        label $name $just {*}$type
    } else {
        label $name $font ${size}um 0 0 0 $just {*}$type
    }
    select area label
    if {[lindex [setlabel layer] 0] eq "space"} {
        puts stderr "efx: no paint under pin $name; it connects to nothing"
    }
    if {$index eq {}} {port make} else {port make $index}
    if {$class ne "default"} {port class $class}
    if {$use ne "default"} {port use $use}
    puts stdout "efx: pin $name, port [port index] ([port class], [port use])"
    select clear
}

# "pin ..." dialog: the text helper's label fields plus the port's index,
# class and use. Apply places a pin at the box each time, so it can stay open.
proc efx::pin_dialog {} {
    variable pinopt
    variable L
    set w .efxpin
    if {[winfo exists $w]} {
        wm deiconify $w
        raise $w
        return
    }
    array set pinopt [list name {} layer m1 sticky 0 font FreeSans size $L just center index {} \
        class default use default]
    toplevel $w
    wm title $w "efx pin"
    set row 0
    foreach {key text} {name "Name" size "Size (um, named font)" index "Port index (blank: auto)"} {
        grid [label $w.l$key -text $text] -row $row -column 0 -sticky w
        grid [entry $w.e$key -textvariable efx::pinopt($key) -background white] -row $row -column 1 -sticky ew
        incr row
    }
    foreach {key text values} [list \
        layer "Attach to layer" {default li m1 m2 m3 m4 m5} \
        font "Font" [concat default [setlabel fontlist]] \
        just "Justification" {center N NE E SE S SW W NW} \
        class "Port class" {default input output inout tristate feedthrough} \
        use "Port use" {default signal analog power ground clock}] {
        grid [label $w.l$key -text $text] -row $row -column 0 -sticky w
        # tk_optionMenu returns its menu, not the button: grid the button
        tk_optionMenu $w.m$key efx::pinopt($key) {*}$values
        grid $w.m$key -row $row -column 1 -sticky ew
        incr row
    }
    grid [checkbutton $w.sticky -text "sticky (keep the label on that layer)" -variable efx::pinopt(sticky)] \
        -row $row -column 1 -sticky w
    incr row
    frame $w.buttons
    button $w.buttons.apply -text "Apply" -command {
        efx::pin_place $efx::pinopt(name) $efx::pinopt(layer) $efx::pinopt(sticky) $efx::pinopt(font) \
            $efx::pinopt(size) $efx::pinopt(just) [string trim $efx::pinopt(index)] $efx::pinopt(class) \
            $efx::pinopt(use)
    }
    button $w.buttons.close -text "Close" -command "wm withdraw $w"
    pack $w.buttons.apply -side left
    pack $w.buttons.close -side right
    grid $w.buttons -row $row -column 0 -columnspan 2 -sticky ew
    grid columnconfigure $w 1 -weight 1
}

# Contacted strip, 2L wide and n*L tall, centred on x, bottom at y = 0:
# strip layer (if given), li flush, and one contact area 0.17 wide from L to
# n*L - L, which Magic fills with licons(n) cuts (spec section 5.2)
proc efx::strip {x n stype ctype} {
    variable L
    variable licon
    set h [expr {$n * $L}]
    if {$stype ne {}} {rect $stype [expr {$x - $L}] 0 [expr {$x + $L}] $h}
    rect li [expr {$x - $L}] 0 [expr {$x + $L}] $h
    rect $ctype [expr {$x - $licon / 2.0}] $L [expr {$x + $licon / 2.0}] [expr {$h - $L}]
}

# Draw an efx MOS into the current cell. parameters: n fingers length butted ltap rtap vt tgate bgate
proc efx::mos_draw {nmos parameters} {
    variable L
    variable licon
    dict with parameters {}
    if {$nmos} {
        lassign {ndiff ndc psd psc} diff dc tap tc
    } else {
        lassign {pdiff pdc nsd nsc} diff dc tap tc
    }
    set pitch [sd_pitch $length]
    set h [expr {$n * $L}]
    set xs {}
    for {set i 0} {$i <= $fingers} {incr i} {lappend xs [expr {$i * $pitch}]}
    set xl [lindex $xs 0]
    set xr [lindex $xs end]

    pushbox
    # Well: n-well for PMOS, Magic's pwell for NMOS. The well is painted first,
    # because painting pwell over diffusion changes its type (sky130A.tech paint
    # rules). pwell is the PDK's convention (its guard ring paints psub = pwell);
    # it isn't written to GDS and extracts as the substrate either way.
    # Extent as the Python n-well: L past the outer tap edges, L above and below.
    # Without a tap on a side, L past the diffusion there (diff/tap.8 0.18).
    set gap [expr {$butted ? 0 : 2 * $L}]
    set xt {}
    if {$ltap} {lappend xt [expr {$xl - 2 * $L - $gap}]}
    if {$rtap} {lappend xt [expr {$xr + 2 * $L + $gap}]}
    set wx0 [expr {($ltap ? $xl - 2 * $L - $gap : $xl) - 2 * $L}]
    set wx1 [expr {($rtap ? $xr + 2 * $L + $gap : $xr) + 2 * $L}]
    rect [expr {$nmos ? "pwell" : "nwell"}] $wx0 [expr {-$L}] $wx1 [expr {$h + $L}]

    # Diffusion as one rectangle, then li and a contact strip on each S/D column
    rect $diff [expr {$xl - $L}] 0 [expr {$xr + $L}] $h
    foreach x $xs {strip $x $n {} $dc}

    # Gates with an L endcap (poly over diffusion becomes nfet/pfet), joined
    # by a 2L poly bar L beyond the diffusion: top (tgate) and/or bottom
    # (bgate), or none. li covers each bar, and one contact area, inset
    # (2L - licon)/2 all round, runs along it; Magic fills it with licons.
    # lvt / hvt: the gate is painted as its own type (nfetlvt, pfetlvt,
    # pfethvt), from which Magic generates LVTN / HVTP (grow 0.18, bridge)
    set gtype [dict get {1std {} 1lvt nfetlvt 0std {} 0lvt pfetlvt 0hvt pfethvt} $nmos$vt]
    foreach x [lrange $xs 0 end-1] {
        set xg [expr {$x + $pitch / 2.0}]
        rect poly [expr {$xg - $length / 2.0}] [expr {-$L}] [expr {$xg + $length / 2.0}] [expr {$h + $L}]
        if {$gtype ne {}} {rect $gtype [expr {$xg - $length / 2.0}] 0 [expr {$xg + $length / 2.0}] $h}
    }
    set gx0 [expr {$xl + $pitch / 2.0 - $length / 2.0}]
    # one finger: widen the bar to hold the licon
    set gx1 [expr {max($xr - $pitch / 2.0 + $length / 2.0, $gx0 + 2 * $L)}]
    set in [expr {(2 * $L - $licon) / 2.0}]
    set gxc [expr {round(($gx0 + $gx1) / 2.0 * 200) / 200.0}]
    # G pin position per bar: 3L/4 from its centre line, towards the diffusion
    set gpins {}
    foreach gy0 [list [expr {$h + $L}] [expr {-3 * $L}]] on [list $tgate $bgate] dir {-1 1} {
        if {!$on} continue
        set gy1 [expr {$gy0 + 2 * $L}]
        rect poly $gx0 $gy0 $gx1 $gy1
        rect li $gx0 $gy0 $gx1 $gy1
        rect pc [expr {$gx0 + $in}] [expr {$gy0 + $in}] [expr {$gx1 - $in}] [expr {$gy1 - $in}]
        lappend gpins [expr {$gy0 + $L + $dir * 3 * $L / 4.0}]
    }

    # Tap strips (at xt, above): 2L from the outer S/D columns (li to li), or butted
    foreach x $xt {strip $x $n $tap $tc}

    # Ports on li, clear of the contacts: L/2 from the bottom of each strip
    # (S0 D0 S1 D1 ..., and B on each tap) and G on each gate bar (one port)
    set i 0
    foreach x $xs {
        pin [expr {$i % 2 ? "D" : "S"}][expr {$i / 2}] $x [expr {$L / 2.0}]
        incr i
    }
    foreach y $gpins {pin G $gxc $y}
    foreach x $xt {pin B $x [expr {$L / 2.0}]}
    popbox
}

# Check the parameters as _mos() does. Following the PDK's mos_check, a bad
# value is corrected to the nearest legal one with a message, not rejected.
proc efx::mos_check {nmos parameters} {
    variable L
    variable licon
    variable poly_min
    variable licon_gate
    set n [dict get $parameters n]
    set fingers [dict get $parameters fingers]
    set length [dict get $parameters length]
    set butted [dict get $parameters butted]
    set ltap [dict get $parameters ltap]
    set rtap [dict get $parameters rtap]
    set vt [dict get $parameters vt]
    set tgate [dict get $parameters tgate]
    set bgate [dict get $parameters bgate]

    if {![string is double -strict $n] || $n != round($n) || $n < 5} {
        set n [expr {[string is double -strict $n] ? max(5, round($n)) : 9}]
        puts stderr "efx: W = n*L needs a whole n >= 5; using n = $n"
    }
    if {![string is double -strict $fingers] || $fingers != round($fingers) || $fingers < 1} {
        set fingers [expr {[string is double -strict $fingers] ? max(1, round($fingers)) : 1}]
        puts stderr "efx: fingers must be a whole number >= 1; using $fingers"
    }
    if {![string is double -strict $length]} {
        set length $L
        puts stderr "efx: length must be a number in um; using $length"
    }
    # On a 0.01 um grid, so the centred gate edges stay on the 5 nm grid
    set snapped [format %.2f [expr {max($poly_min, round($length * 100) / 100.0)}]]
    if {abs($snapped - $length) > 1e-9} {
        puts stderr "efx: length must be >= $poly_min (poly.1a), in steps of 0.01; using $snapped"
    }
    set length [expr {$snapped + 0}]
    set vts [expr {$nmos ? {std lvt} : {std lvt hvt}}]
    if {$vt ni $vts} {
        puts stderr "efx: vt must be one of $vts; using std"
        set vt std
    }
    # project rule (pfet_01v8_lvt needs 0.35, poly.1b)
    if {$vt eq "lvt" && $length < 2 * $L - 1e-9} {
        set length [expr {2 * $L}]
        puts stderr "efx: lvt needs length >= 2L; using $length"
    }
    if {![string is boolean -strict $butted]} {set butted 0}
    set butted [expr {$butted ? 1 : 0}]
    # a bad value takes the default: taps on, the gate bar on its usual side
    foreach v {ltap rtap tgate bgate} default [list 1 1 $nmos [expr {!$nmos}]] {
        if {![string is boolean -strict [set $v]]} {set $v $default}
        set $v [expr {[set $v] ? 1 : 0}]
    }
    if {$butted && $fingers % 2} {
        set butted 0
        puts stderr "efx: butted taps need an even number of fingers (both outer columns sources); not butted"
    }
    # li clear of the gate also keeps the licons clear of it; check against the rule anyway
    set pitch [sd_pitch $length]
    if {($pitch - $length - $licon) / 2.0 < $licon_gate - 1e-9} {
        error "efx: licon too close to the gate at pitch $pitch and length $length (licon.11)"
    }
    return [dict replace $parameters n [expr {int($n)}] fingers [expr {int($fingers)}] \
        length $length butted $butted ltap $ltap rtap $rtap vt $vt tgate $tgate bgate $bgate]
}

# SPICE parameters to efx ones, as sky130::mos_convert: w is the total width
# over nf fingers, so n = w / nf / L (_check reports and rounds a W that isn't
# a multiple of L); l -> length, nf -> fingers. Values are plain um, as Sky130
# netlists write them (scale 1e-6) and as sky130::mos_convert assumes:
# spice2float reads "1.62u" as metres. magic::gencell needs this proc even
# when no SPICE is involved. Other keys pass through.
proc efx::mos_convert {parameters} {
    variable L
    set out [dict create]
    set nf 1
    dict for {key value} $parameters {
        switch -nocase $key {
            w {set w [magic::spice2float $value]}
            l {dict set out length [magic::3digitpastdecimal [magic::spice2float $value]]}
            nf {set nf $value; dict set out fingers $value}
            default {dict set out $key $value}
        }
    }
    if {[info exists w]} {
        dict set out n [magic::3digitpastdecimal [expr {$w / $nf / $L}]]
    }
    return $out
}

# Parameter window. W and the S/D pitch follow from n and length (shown as text).
proc efx::mos_dialog {nmos parameters} {
    variable L
    magic::add_entry n "W / L  (W = n x $L um, n >= 5)" $parameters
    magic::add_entry fingers "Fingers" $parameters
    magic::add_entry length "Gate length (um, >= 0.15)" $parameters
    # Not last: gencell_getparams reads the widgets newest first and fails
    # ("can't read pname") if the newest is a message rather than an entry
    magic::add_message rule "S/D pitch = (2 + ceil(length / L)) x L" $parameters
    magic::add_checkbox butted "Butt taps to sources (source = body)" $parameters
    magic::add_checkbox ltap "Left body tap" $parameters
    magic::add_checkbox rtap "Right body tap" $parameters
    magic::add_checkbox tgate "Top gate" $parameters
    magic::add_checkbox bgate "Bottom gate" $parameters
    magic::add_selectlist vt "Threshold (lvt: length >= 2L)" \
        [expr {$nmos ? {std lvt} : {std lvt hvt}}] $parameters
}

# Defaults as efx_primitives.nmos()/pmos()
proc efx::nmos_defaults {} {return {n 9 fingers 2 length 0.18 butted 0 ltap 1 rtap 1 vt std tgate 1 bgate 0}}
proc efx::pmos_defaults {} {return {n 9 fingers 2 length 0.18 butted 0 ltap 1 rtap 1 vt std tgate 0 bgate 1}}

proc efx::nmos_convert {parameters} {return [efx::mos_convert $parameters]}
proc efx::pmos_convert {parameters} {return [efx::mos_convert $parameters]}
proc efx::nmos_check {parameters} {return [efx::mos_check 1 $parameters]}
proc efx::pmos_check {parameters} {return [efx::mos_check 0 $parameters]}
proc efx::nmos_dialog {parameters} {efx::mos_dialog 1 $parameters}
proc efx::pmos_dialog {parameters} {efx::mos_dialog 0 $parameters}

proc efx::nmos_draw {parameters} {return [efx::mos_draw 1 $parameters]}
proc efx::pmos_draw {parameters} {return [efx::mos_draw 0 $parameters]}

# ---------------------------------------------------------------------------
# p+ poly resistors: one vertical poly stripe nw*L wide with a body nl*L long, as
# efx_primitives.ppolyres()/xpolyres(). Centred on x = 0, bottom at y = 0:
# 12L head of xpc, body, 12L head. Ports R1 (bottom), R2 (top).
#   ppolyres  res_high_po, 319.8 ohm/sq:   body xhrpoly
#   xpolyres  res_xhigh_po, 2000 ohm/sq:   body uhrpoly
# Magic generates RPM/URPM, psdm, NPC, poly.res and the 0.19 x 2.0 resistor
# licons from xpc on GDS output. Widths start at 4L (Python's RPM, 2L past the
# poly, is then 1.44 >= rpm.1a 1.27), but Magic's RPM is only 0.2 past the
# poly: at 4L it is 1.12 and fails rpm.1a, which only KLayout checks. 5L passes.
# 4L, 8L, 16L, 32L are 0.03 above the foundry widths 0.69, 1.41, 2.85, 5.73.

namespace eval efx {
    variable polyres_head 12	;# head height in L: the 2.0 cut + li.5 0.08 at each end
    variable polyres_nwmin 4
    variable polyres {ppolyres {xhrpoly 319.8} xpolyres {uhrpoly 2000}}	;# body type, ohm/sq
}

proc efx::polyres_draw {kind parameters} {
    variable L
    variable polyres
    variable polyres_head
    set body [lindex [dict get $polyres $kind] 0]
    dict with parameters {}
    set x0 [expr {-$nw * $L / 2.0}]
    set x1 [expr {$nw * $L / 2.0}]
    set hh [expr {$polyres_head * $L}]
    set y1 [expr {$hh + $nl * $L}]
    set h [expr {2 * $hh + $nl * $L}]

    pushbox
    # The whole head is the resistor contact; li over it
    foreach y [list 0 $y1] {
        rect xpc $x0 $y $x1 [expr {$y + $hh}]
        rect li $x0 $y $x1 [expr {$y + $hh}]
    }
    rect $body $x0 $hh $x1 $y1
    # Ports on li, L/2 from the outer end of each head
    pin R1 0 [expr {$L / 2.0}]
    pin R2 0 [expr {$h - $L / 2.0}]
    popbox
}

# Whole nw >= 4 and nl >= 1; bad values are corrected with a message, as mos_check
proc efx::polyres_check {kind parameters} {
    variable polyres_nwmin
    foreach {key min} [list nw $polyres_nwmin nl 1] {
        set v [dict get $parameters $key]
        if {![string is double -strict $v] || $v != round($v) || $v < $min} {
            set v [expr {[string is double -strict $v] ? max($min, round($v)) : $min}]
            puts stderr "efx: $key must be a whole number >= $min; using $key = $v"
        }
        dict set parameters $key [expr {int($v)}]
    }
    return $parameters
}

# SPICE w and l (plain um, see mos_convert) to nw and nl, rounded by _check.
# Magic extracts l as the poly.res length, 0.16 past the body.
proc efx::polyres_convert {kind parameters} {
    variable L
    set out [dict create]
    dict for {key value} $parameters {
        switch -nocase $key {
            w {dict set out nw [magic::3digitpastdecimal [expr {[magic::spice2float $value] / $L}]]}
            l {dict set out nl [magic::3digitpastdecimal [expr {([magic::spice2float $value] - 0.16) / $L}]]}
            default {dict set out $key $value}
        }
    }
    return $out
}

proc efx::polyres_dialog {kind parameters} {
    variable L
    variable polyres
    variable polyres_nwmin
    set rho [lindex [dict get $polyres $kind] 1]
    magic::add_message rule "R = $rho ohm/sq x nl / nw, plus the heads" $parameters
    magic::add_entry nw "Width / L  (W = nw x $L um, nw >= $polyres_nwmin)" $parameters
    magic::add_entry nl "Length / L  (body = nl x $L um, nl >= 1)" $parameters
}

proc efx::ppolyres_defaults {} {return {nw 5 nl 10}}
proc efx::xpolyres_defaults {} {return {nw 5 nl 10}}
foreach kind {ppolyres xpolyres} {
    foreach p {draw check convert dialog} {
        proc efx::${kind}_$p {parameters} "return \[efx::polyres_$p $kind \$parameters\]"
    }
}

# ---------------------------------------------------------------------------
# MiM capacitor (sky130_fd_pr__cap_mim_m3_1), as efx_primitives.mimcap(): capm
# nw*L x nl*L, centred on x = 0, L above the cell bottom (y = 0).
#   C2  met3 plate, L past capm all round; the parent connects to it
#   C1  met4 plate, L inside capm, on mimcc (via3 to capm)
# Magic fills mimcc with via3 (squares-grid: 0.2 at 0.4 pitch after a 0.06
# border). The mimcc area is the cut region of the Python cell grown by that
# border, so both get the same cuts.

namespace eval efx {
    variable mim_nmin 6	;# capm.1 1.0: 6L = 1.08
    variable via3_enc 0.065	;# met4 enclosure of via3 (m4.3)
    variable mimcc_border 0.06	;# squares-grid border of via3 (mimcc) in sky130A.tech
}

proc efx::mimcap_draw {parameters} {
    variable L
    variable via3_enc
    variable mimcc_border
    dict with parameters {}
    set x0 [expr {-$nw * $L / 2.0}]
    set x1 [expr {$nw * $L / 2.0}]
    set h [expr {$nl * $L}]

    pushbox
    rect m3 [expr {$x0 - $L}] 0 [expr {$x1 + $L}] [expr {$h + 2 * $L}]
    rect mimcap $x0 $L $x1 [expr {$h + $L}]
    rect m4 [expr {$x0 + $L}] [expr {2 * $L}] [expr {$x1 - $L}] $h
    set e [expr {$via3_enc - $mimcc_border}]
    rect mimcc [expr {$x0 + $L + $e}] [expr {2 * $L + $e}] [expr {$x1 - $L - $e}] [expr {$h - $e}]
    # Ports L/2 inside the bottom edge of the met3 plate and the top edge of the met4 plate
    pin C2 0 [expr {$L / 2.0}] m3
    pin C1 0 [expr {$h - $L / 2.0}] m4
    popbox
}

# Whole nw, nl >= 6; bad values are corrected with a message, as mos_check
proc efx::mimcap_check {parameters} {
    variable mim_nmin
    foreach key {nw nl} {
        set v [dict get $parameters $key]
        if {![string is double -strict $v] || $v != round($v) || $v < $mim_nmin} {
            set v [expr {[string is double -strict $v] ? max($mim_nmin, round($v)) : $mim_nmin}]
            puts stderr "efx: $key must be a whole number >= $mim_nmin; using $key = $v"
        }
        dict set parameters $key [expr {int($v)}]
    }
    return $parameters
}

# SPICE w and l (plain um, see mos_convert) to nw and nl, rounded by _check.
# Magic extracts w across (x) and l up (y).
proc efx::mimcap_convert {parameters} {
    variable L
    set out [dict create]
    dict for {key value} $parameters {
        switch -nocase $key {
            w {dict set out nw [magic::3digitpastdecimal [expr {[magic::spice2float $value] / $L}]]}
            l {dict set out nl [magic::3digitpastdecimal [expr {[magic::spice2float $value] / $L}]]}
            default {dict set out $key $value}
        }
    }
    return $out
}

proc efx::mimcap_dialog {parameters} {
    variable L
    variable mim_nmin
    # carea and cperi as the PDK's cap_mim_m3_1 defaults
    magic::add_message rule "C = 2.0 fF/um2 x area + 0.19 fF/um x perimeter" $parameters
    magic::add_entry nw "Width / L  (w = nw x $L um, nw >= $mim_nmin)" $parameters
    magic::add_entry nl "Length / L  (l = nl x $L um, nl >= $mim_nmin)" $parameters
}

proc efx::mimcap_defaults {} {return {nw 10 nl 10}}

# 1.8 V guard ring, drawn like sky130::subconn_guard_draw / nwell_draw (paint
# in the edit cell, not a gencell), but with the box as the ring's inner
# boundary. Each edge of the box is grown out to the L grid. The ring is 2L of
# tap (dtype) and li, flush; each side has one contact area (ctype) 0.17 wide
# down its middle, starting L in from the inner corners, as efx::strip stops L
# from its ends. The corners have no licons. Magic generates the implant. With
# well, that is painted first over the inside and the ring, L past the tap.
# No label or port: the ring is flat paint in the edit cell, so its net is
# labelled there (as gLayout's tapring() and the PDK's rings add none).
# As efx_primitives.subring() / nwring().
proc efx::subring_draw {} {ring_draw psd psc {}}
proc efx::nwring_draw {} {ring_draw nsd nsc nwell}

# The box in um, each edge grown out to the L grid (with a message if it moved)
proc efx::lambda_box {} {
    variable L
    lassign [lmap v [box values] {magic::i2u $v}] bx0 by0 bx1 by1
    # the 1e-6 keeps edges already on the grid in place
    set x0 [expr {floor($bx0 / $L + 1e-6) * $L}]
    set y0 [expr {floor($by0 / $L + 1e-6) * $L}]
    set x1 [expr {ceil($bx1 / $L - 1e-6) * $L}]
    set y1 [expr {ceil($by1 / $L - 1e-6) * $L}]
    if {abs($x0 - $bx0) + abs($y0 - $by0) + abs($x1 - $bx1) + abs($y1 - $by1) > 1e-6} {
        puts stderr [format "efx: box grown out to the L grid: (%.3f %.3f) (%.3f %.3f)" $x0 $y0 $x1 $y1]
    }
    return [list $x0 $y0 $x1 $y1]
}

proc efx::ring_draw {dtype ctype well} {
    variable L
    variable licon
    lassign [lambda_box] x0 y0 x1 y1
    if {$x1 - $x0 < 3 * $L - 1e-6 || $y1 - $y0 < 3 * $L - 1e-6} {
        puts stderr "efx: the guard ring's inside must be at least 3L x 3L ([expr {3 * $L}]um), for a licon on each side"
        return
    }
    set hl [expr {$licon / 2.0}]
    suspendall
    tech unlock *
    pushbox
    if {$well ne {}} {
        rect $well [expr {$x0 - 3 * $L}] [expr {$y0 - 3 * $L}] [expr {$x1 + 3 * $L}] [expr {$y1 + 3 * $L}]
    }
    # tap/li box and contact area per side: bottom and top run over the corners
    foreach {box cut} [list \
        [list [expr {$x0 - 2 * $L}] [expr {$y0 - 2 * $L}] [expr {$x1 + 2 * $L}] $y0] \
        [list [expr {$x0 + $L}] [expr {$y0 - $L - $hl}] [expr {$x1 - $L}] [expr {$y0 - $L + $hl}]] \
        [list [expr {$x0 - 2 * $L}] $y1 [expr {$x1 + 2 * $L}] [expr {$y1 + 2 * $L}]] \
        [list [expr {$x0 + $L}] [expr {$y1 + $L - $hl}] [expr {$x1 - $L}] [expr {$y1 + $L + $hl}]] \
        [list [expr {$x0 - 2 * $L}] $y0 $x0 $y1] \
        [list [expr {$x0 - $L - $hl}] [expr {$y0 + $L}] [expr {$x0 - $L + $hl}] [expr {$y1 - $L}]] \
        [list $x1 $y0 [expr {$x1 + 2 * $L}] $y1] \
        [list [expr {$x1 + $L - $hl}] [expr {$y0 + $L}] [expr {$x1 + $L + $hl}] [expr {$y1 - $L}]]] {
        rect $dtype {*}$box
        rect li {*}$box
        rect $ctype {*}$cut
    }
    popbox
    tech revert
    resumeall
}

# Poly contact filling the box, the structure that contacts the MOS gates:
# poly and li flush with the box, and one pc contact area inset
# (2L - licon)/2 all round, which Magic fills with licons. The box is grown
# out to the L grid; at least 2L x 2L. Paint in the edit cell, not a gencell,
# with no label. As efx_primitives.polycont().
proc efx::polycont_draw {} {
    variable L
    variable licon
    lassign [lambda_box] x0 y0 x1 y1
    if {$x1 - $x0 < 2 * $L - 1e-6 || $y1 - $y0 < 2 * $L - 1e-6} {
        puts stderr "efx: polycont must be at least 2L x 2L ([expr {2 * $L}]um), for a licon"
        return
    }
    set in [expr {(2 * $L - $licon) / 2.0}]
    suspendall
    tech unlock *
    pushbox
    rect poly $x0 $y0 $x1 $y1
    rect li $x0 $y0 $x1 $y1
    rect pc [expr {$x0 + $in}] [expr {$y0 + $in}] [expr {$x1 - $in}] [expr {$y1 - $in}]
    popbox
    tech revert
    resumeall
}

# Contact or via filling the box: both metals flush with the box and one
# contact area inset by in all round, which Magic fills with cuts. The box is
# grown out to the L grid; at least 2L x 2L. Paint in the edit cell, not a
# gencell, with no label. As efx_primitives._via().
proc efx::via_draw {lower ctype upper in} {
    variable L
    lassign [lambda_box] x0 y0 x1 y1
    if {$x1 - $x0 < 2 * $L - 1e-6 || $y1 - $y0 < 2 * $L - 1e-6} {
        puts stderr "efx: $ctype must be at least 2L x 2L ([expr {2 * $L}]um)"
        return
    }
    suspendall
    tech unlock *
    pushbox
    rect $lower $x0 $y0 $x1 $y1
    rect $upper $x0 $y0 $x1 $y1
    rect $ctype [expr {$x0 + $in}] [expr {$y0 + $in}] [expr {$x1 - $in}] [expr {$y1 - $in}]
    popbox
    tech revert
    resumeall
}

# viali inset L/2: a 1L x 1L contact area in a 2L box, as efx_primitives.mcon().
# Magic's viali has no border, so the mcons sit L/2 in (met1.4/met1.5: 0.03/0.06).
proc efx::mcon_draw {} {
    variable L
    via_draw li viali m1 [expr {$L / 2.0}]
}

# via1 inset via1_in, so the via1s sit 0.085 in, as efx_primitives.via1().
# Magic's via1 type must be at least 0.26 wide, so it can't be 1L.
proc efx::via1_draw {} {
    variable via1_in
    via_draw m1 via1 m2 $via1_in
}
