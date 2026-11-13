v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 -560 0 -500 {lab=clk}
N 440 -460 480 -460 {lab=clk}
N 440 -560 480 -560 {lab=c4}
N 440 -540 480 -540 {lab=c3}
N 440 -520 480 -520 {lab=c2}
N 440 -500 480 -500 {lab=c1}
N 440 -480 480 -480 {lab=c0}
N 780 -560 820 -560 {lab=vdd}
N 780 -460 820 -460 {lab=GND}
N 820 -460 820 -440 {lab=GND}
N 880 -510 910 -510 {lab=q}
N 880 -510 880 -470 {lab=q}
N 1100 -620 1100 -570 {lab=vdd}
N 100 -240 100 -190 {lab=c4}
N 180 -240 180 -190 {lab=c3}
N 260 -240 260 -190 {lab=c2}
N 340 -240 340 -190 {lab=c1}
N 420 -240 420 -190 {lab=c0}
N 780 -510 880 -510 {lab=q}
C {title_efx.sym} 200 0 0 0 {name=l1 author="ejfogleman"}
C {copyright.sym} 0 40 0 0 {name=s3 place=header value="* Copyright (c) Eric Fogleman 2026
* SPDX-License-Identifier: Apache-2.0"}
C {efx_pll96_div_f.sym} 630 -510 0 0 {name=xdut}
C {vsource.sym} 0 -470 0 0 {name=V1 value="0 PULSE(0 \{VDD\} \{TD_VCO\} \{T_RF\} \{T_RF\} \{T_VCO/2\} \{T_VCO\})"}
C {gnd.sym} 0 -440 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 0 -560 0 1 {name=p1 sig_type=std_logic lab=clk}
C {lab_wire.sym} 440 -460 0 0 {name=p2 sig_type=std_logic lab=clk}
C {lab_wire.sym} 440 -560 0 0 {name=p3 sig_type=std_logic lab=c4}
C {lab_wire.sym} 440 -540 0 0 {name=p4 sig_type=std_logic lab=c3}
C {lab_wire.sym} 440 -520 0 0 {name=p5 sig_type=std_logic lab=c2}
C {lab_wire.sym} 440 -500 0 0 {name=p6 sig_type=std_logic lab=c1}
C {lab_wire.sym} 440 -480 0 0 {name=p7 sig_type=std_logic lab=c0}
C {lab_wire.sym} 820 -560 0 1 {name=p8 sig_type=std_logic lab=vdd}
C {gnd.sym} 820 -440 0 0 {name=l2 lab=GND}
C {parax_cap.sym} 880 -460 0 0 {name=C1 gnd=0 value=\{CLOAD\} m=1}
C {lab_wire.sym} 910 -510 0 1 {name=p9 sig_type=std_logic lab=q}
C {vsource.sym} 1100 -540 0 0 {name=V_VDD value="\{VDD\}" savecurrent=true}
C {gnd.sym} 1100 -510 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 1100 -620 0 1 {name=p10 sig_type=std_logic lab=vdd}
C {vsource.sym} 100 -160 0 0 {name=VC4 value=\{VC4\} savecurrent=false}
C {gnd.sym} 100 -130 0 0 {name=l5 lab=GND}
C {vsource.sym} 180 -160 0 0 {name=VC3 value=\{VC3\} savecurrent=false}
C {gnd.sym} 180 -130 0 0 {name=l6 lab=GND}
C {vsource.sym} 260 -160 0 0 {name=VC2 value=\{VC2\} savecurrent=false}
C {gnd.sym} 260 -130 0 0 {name=l7 lab=GND}
C {vsource.sym} 340 -160 0 0 {name=VC1 value=\{VC1\} savecurrent=false}
C {gnd.sym} 340 -130 0 0 {name=l8 lab=GND}
C {vsource.sym} 420 -160 0 0 {name=VC0 value=\{VC0\} savecurrent=false}
C {gnd.sym} 420 -130 0 0 {name=l9 lab=GND}
C {lab_wire.sym} 100 -240 0 1 {name=p11 sig_type=std_logic lab=c4}
C {lab_wire.sym} 180 -240 0 1 {name=p12 sig_type=std_logic lab=c3}
C {lab_wire.sym} 260 -240 0 1 {name=p13 sig_type=std_logic lab=c2}
C {lab_wire.sym} 340 -240 0 1 {name=p14 sig_type=std_logic lab=c1}
C {lab_wire.sym} 420 -240 0 1 {name=p15 sig_type=std_logic lab=c0}
C {devices/code_shown.sym} 10 120 0 0 {name=s1 only_toplevel=false value="* efx_pll96_div_f test
.lib ~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice tt

*** efx_pll96_div_f code sweep
*** run from sim/ with:
*** ngspice -b -o tb_efx_pll96_div_f.out tb_efx_pll96_div_f.spice
*** Every code c[4:0] in cmin..cmax is run in turn; the .out file gets one
*** line per code: c, measured division ratio N (output period / clk period),
*** and average vdd current (N=0: output not toggling). All runs are written
*** to one .raw file.

*** simulation setup
.option temp=27
.param VDD=1.8
.param TD_VCO=2.5n
.param T_RF=100p
.param T_VCO=10.4167n
.param CLOAD=10f
*** code inputs (overwritten by the sweep below)
.param VC0=0 VC1=0 VC2=0 VC3=0 VC4=0
"}
C {devices/code.sym} 10 550 0 0 {name=s4 only_toplevel=false value="tcleval(* lvdig standard cells (layout-extracted, C parasitics; symbols are primitives)
.include $::LVDIG_SPICE/sky130_efx_lvdig_c.spice)"}
C {devices/code_shown.sym} 860 100 0 0 {name=s2 only_toplevel=false value="* Run transient: sweep the division code
.options reltol=1e-4 vntol=1e-7 abstol=1e-13
.control
   set cmin = 0
   set cmax = 31
   set num_threads = 1
   set vdd = 1.8
   set appendwrite
   save clk q i(v_vdd)
   let c = $cmin
   set cc = $&c
   while $cc <= $cmax
      let c = $cc
      let b0 = c - 2*floor(c/2)
      let b1 = floor(c/2) - 2*floor(c/4)
      let b2 = floor(c/4) - 2*floor(c/8)
      let b3 = floor(c/8) - 2*floor(c/16)
      let b4 = floor(c/16) - 2*floor(c/32)
      let v0 = b0 * $vdd
      alter vc0 = $&v0
      let v1 = b1 * $vdd
      alter vc1 = $&v1
      let v2 = b2 * $vdd
      alter vc2 = $&v2
      let v3 = b3 * $vdd
      alter vc3 = $&v3
      let v4 = b4 * $vdd
      alter vc4 = $&v4
      tran 200p 3u
      let vth = $vdd/2
      let tq = 0
      meas tran tclk trig v(clk) val=$&vth rise=1 td=1u targ v(clk) val=$&vth rise=6 td=1u
      meas tran tq trig v(q) val=$&vth rise=1 td=1u targ v(q) val=$&vth rise=6 td=1u
      meas tran idd avg i(v_vdd) from=1u to=3u
      let n = tq/tclk
      echo DIVF c= $cc N= $&n idd= $&idd
      write tb_efx_pll96_div_f.raw
      let c = $cc + 1
      set cc = $&c
   end
.endc
.end"}
