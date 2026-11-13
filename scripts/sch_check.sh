#!/usr/bin/env bash
# Copyright (c) Eric Fogleman 2026
# SPDX-License-Identifier: Apache-2.0
#
# Run scripts/sch_check.tcl on every schematic in a netlist's hierarchy: the
# top schematic plus each "** sch_path:" xschem wrote into the netlist (this
# repo's cells and those of dependencies/). Run from the repo root:
#   scripts/sch_check.sh <netlist.spice> <top.sch>
# Exit 1 if any schematic fails or the check doesn't complete for one.
set -u
netlist=$1; top=$2
root=$(pwd)
mapfile -t schs < <( { realpath "$top"; grep -h '^\*\* sch_path:' "$netlist" | awk '{print $3}'; } | sort -u)
cd xschem || exit 2
fail=0
for s in "${schs[@]}"; do
  out=$(xschem -x -q -r --rcfile xschemrc --script "$root/scripts/sch_check.tcl" "$s" \
          < /dev/null 2> /dev/null | tr -d '\0' | grep -a '\.sch: ')
  if ! grep -q 'sch_check ok' <<< "$out"; then
    fail=1
    if [ -n "$out" ]; then echo "$out" | grep -v 'sch_check ok' >&2
    else echo "$(basename "$s"): sch_check did not run" >&2; fi
  fi
done
[ $fail = 0 ] && echo "sch_check: ${#schs[@]} schematics ok"
exit $fail
