# Copyright (c) Eric Fogleman 2026
# SPDX-License-Identifier: Apache-2.0
#
# Schematic check, run inside xschem on one loaded .sch:
#   cd xschem && xschem -x -q -r --rcfile xschemrc --script ../scripts/sch_check.tcl foo.sch
# (-r is required: without it xschem's readline hangs when stdin/stdout aren't
# a terminal.) Exit 0 when clean, 1 on any error, 2 if the check itself fails.
#
# xschem netlists a net with two different names (an ipin/opin/iopin and a
# lab_pin/lab_wire/lab_show, or two labels, on one wire) without any message:
# it keeps one name, chosen by instance order in the file, and drops the other.
# This uses xschem's own connectivity: every wire gets its resolved net name
# (getprop wire n lab), and every pin/label must name the net it sits on, i.e.
# the wire its connection point lies on (endpoint or anywhere along it), or the
# device pin at that point when no wire is there. Reported:
#   name-conflict   pin/label name differs from the net xschem resolved there
#   dangling-label  pin/label touches no wire and no device pin, and its name is
#                   not used by any attached pin/label or instance property
#                   (pins may connect by name to labels, and lvdig power nets by
#                   properties such as VPWR=vdd)
# The last line printed is "<file>: sch_check ok|FAIL ...": anything else (a Tcl
# error, a crash) means the check did not run.

set label_types {label ipin opin iopin show_label}
set errors 0
set sch [xschem get schname]
set short [file tail $sch]

proc report {kind msg} {
  global errors short
  puts "$short: $kind: $msg"
  incr errors
}

proc main {} {
global label_types errors sch short
# Build connectivity: any net query makes xschem resolve all wire names.
for {set i 0} {$i < [xschem get instances]} {incr i} {
  set p [lindex [lindex [xschem instance_pins $i] 0] 0]
  if {$p ne ""} { xschem instance_net $i $p; break }
}

# Wire coordinates. 'xschem wire_coord 0' returns nothing in 3.4.7, and xschem
# doesn't keep wires in file order, so wires 1..n-1 come from xschem and wire 0
# is the one N line of the file left over after removing those (it must be
# exactly one, or the check fails).
proc wkey {c} {
  lassign $c x1 y1 x2 y2
  set a [list [expr {double($x1)}] [expr {double($y1)}]]
  set b [list [expr {double($x2)}] [expr {double($y2)}]]
  return [lsort [list $a $b]]
}
set fh [open $sch]
set left {}
foreach line [split [read $fh] "\n"] {
  if {[regexp {^N\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)} $line -> x1 y1 x2 y2]} {
    dict incr left [wkey [list $x1 $y1 $x2 $y2]]
  }
}
close $fh
set nw [xschem get wires]
set wires [list {}]
for {set w 1} {$w < $nw} {incr w} {
  set c [xschem wire_coord $w]
  set k [wkey $c]
  if {![dict exists $left $k] || [dict get $left $k] == 0} {
    error "wire $w ($c) in xschem is not an N line of the file"
  }
  dict incr left $k -1
  lappend wires $c
}
set rest {}
dict for {k n} $left { for {set j 0} {$j < $n} {incr j} { lappend rest $k } }
if {$nw > 0} {
  if {[llength $rest] != 1} {
    error "can't identify wire 0: [llength $rest] N lines of the file are not wires 1..[expr {$nw-1}]"
  }
  lassign [lindex $rest 0] a b
  lset wires 0 [concat $a $b]
} elseif {[llength $rest]} {
  error "xschem has no wires, the file has [llength $rest] N lines"
}

proc on_segment {px py x1 y1 x2 y2} {
  set eps 1e-6
  if {$px < min($x1,$x2) - $eps || $px > max($x1,$x2) + $eps} { return 0 }
  if {$py < min($y1,$y2) - $eps || $py > max($y1,$y2) + $eps} { return 0 }
  return [expr {abs(($x2-$x1)*($py-$y1) - ($y2-$y1)*($px-$x1)) < $eps}]
}

# Device pins (non-label instances): coordinate -> {inst pin net}; and all
# property values, for nets connected by name (VPWR=vdd ...)
set ninst [xschem get instances]
set devpins {}
set propvals {}
for {set i 0} {$i < $ninst} {incr i} {
  if {[xschem getprop instance $i cell::type] in $label_types} continue
  foreach {- v} [regexp -all -inline {\m\w+=(\S+)} [xschem getprop instance $i]] { dict set propvals $v 1 }
  foreach p [xschem instance_pins $i] {
    set c [xschem instance_pin_coord $i name $p]
    if {[llength $c] < 3} continue
    lappend devpins [list [lindex $c 1] [lindex $c 2] [xschem getprop instance $i name] $p \
                          [xschem instance_net $i $p]]
  }
}

set attached {}
set loose {}
for {set i 0} {$i < $ninst} {incr i} {
  set type [xschem getprop instance $i cell::type]
  if {$type ni $label_types} continue
  set name [xschem getprop instance $i name]
  set lab [xschem getprop instance $i lab]
  if {$lab eq ""} continue  ;# e.g. lab_show with no lab: displays the net, names nothing
  incr ::nlabels
  set pin [lindex [lindex [xschem instance_pins $i] 0] 0]
  set c [xschem instance_pin_coord $i name $pin]
  set px [lindex $c 1]; set py [lindex $c 2]
  set found 0
  for {set w 0} {$w < $nw} {incr w} {
    lassign [lindex $wires $w] x1 y1 x2 y2
    if {[on_segment $px $py $x1 $y1 $x2 $y2]} {
      set found 1
      set net [xschem getprop wire $w lab]
      if {$net ne $lab} {
        report name-conflict "$name ($type) lab=$lab is on a wire netlisted as '$net' ($px,$py)"
      }
      break
    }
  }
  if {!$found} { foreach d $devpins {
    lassign $d dx dy dinst dpin dnet
    if {$dx == $px && $dy == $py} {
      set found 1
      if {$dnet ne $lab} {
        report name-conflict "$name ($type) lab=$lab is on pin $dinst:$dpin netlisted as '$dnet' ($px,$py)"
      }
      break
    }
  } }
  if {$found} {
    dict set attached $lab 1
  } else {
    lappend loose [list $name $type $lab $px $py]
  }
}
# A pin/label touching nothing is still connected by name if another pin/label
# with that name is attached, or an instance property names it.
foreach l $loose {
  lassign $l name type lab px py
  if {![dict exists $attached $lab] && ![dict exists $propvals $lab]} {
    report dangling-label "$name ($type) lab=$lab touches no wire or device pin, and nothing else is named $lab ($px,$py)"
  }
}
set ::nwires $nw
}

set nlabels 0; set nwires 0
if {[catch main e]} {
  puts "$short: sch_check FAIL: check did not complete: $e"
  exit 2
}
if {$errors} { puts "$short: sch_check FAIL: $errors error(s)"; exit 1 }
puts "$short: sch_check ok ($nlabels pins/labels, $nwires wires)"
exit 0
