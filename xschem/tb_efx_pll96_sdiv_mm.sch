v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1100 -620 1100 -570 {lab=vdd_div}
N 260 -240 260 -190 {
lab=s3}
N 340 -240 340 -190 {
lab=s2}
N 420 -240 420 -190 {
lab=s1}
N 500 -240 500 -190 {
lab=s0}
N 580 -240 580 -190 {
lab=p3}
N 660 -240 660 -190 {
lab=p2}
N 740 -240 740 -190 {
lab=p1}
N 820 -240 820 -190 {
lab=p0}
N 900 -240 900 -190 {
lab=en3}
N 980 -240 980 -190 {
lab=en2}
N 1060 -240 1060 -190 {
lab=en1}
N 1140 -240 1140 -190 {
lab=en0}
N 1220 -240 1220 -190 {
lab=ens}
N 0 -640 0 -500 {
lab=clk}
N 20 -240 20 -190 {
lab=divr_en}
N 100 -240 100 -190 {
lab=r1}
N 180 -240 180 -190 {
lab=r0}
N 0 -640 480 -640 {
lab=clk}
N 780 -640 820 -640 {
lab=vdd_div}
N 780 -380 820 -380 {lab=GND}
N 820 -380 820 -360 {lab=GND}
N 880 -510 880 -470 {
lab=clk_divf}
N 780 -510 880 -510 {
lab=clk_divf}
N 880 -510 910 -510 {
lab=clk_divf}
N 440 -620 480 -620 {
lab=s3}
N 440 -600 480 -600 {
lab=s2}
N 440 -580 480 -580 {
lab=s1}
N 440 -560 480 -560 {
lab=s0}
N 440 -540 480 -540 {
lab=p3}
N 440 -520 480 -520 {
lab=p2}
N 440 -500 480 -500 {
lab=p1}
N 440 -480 480 -480 {
lab=p0}
N 440 -460 480 -460 {
lab=en3}
N 440 -440 480 -440 {
lab=en2}
N 440 -420 480 -420 {
lab=en1}
N 440 -400 480 -400 {
lab=en0}
N 440 -380 480 -380 {
lab=ens}
N 780 -860 820 -860 {
lab=vdd_ref}
N 780 -800 820 -800 {lab=GND}
N 820 -800 820 -780 {lab=GND}
N 880 -830 880 -790 {
lab=clk_divr}
N 780 -830 880 -830 {
lab=clk_divr}
N 880 -830 910 -830 {
lab=clk_divr}
N 1100 -880 1100 -830 {lab=vdd_ref}
N 0 -820 480 -820 {lab=clk_out}
N 0 -820 0 -780 {lab=clk_out}
N 440 -800 480 -800 {
lab=divr_en}
N 440 -840 480 -840 {
lab=r0}
N 440 -860 480 -860 {
lab=r1}
C {title_efx.sym} 200 0 0 0 {name=l1 author="ejfogleman"}
C {vsource.sym} 0 -470 0 0 {name=V1 value="0 PULSE(0 \{VDD\} \{TD_VCO\} \{T_RF\} \{T_RF\} \{T_VCO/2\} \{T_VCO\})"}
C {gnd.sym} 0 -440 0 0 {name=l3 lab=GND}
C {devices/code_shown.sym} 10 120 0 0 {name=s1 only_toplevel=false value="* ejf_pfd test
.lib ~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice tt
.option temp=27
.param VDD=1.8
.param TD_REF=50n
.param T_RF=300p
.param TD_VCO=2.5n
.param CP=10f
.param CLOAD=10f
.param VDIVR_EN=1.8
.include config_6.inc
"}
C {devices/code.sym} 10 390 0 0 {name=s4 only_toplevel=false value="tcleval(* lvdig standard cells (layout-extracted, C parasitics; symbols are primitives)
.include $::LVDIG_SPICE/sky130_efx_lvdig_c.spice)"}
C {devices/code_shown.sym} 860 110 0 0 {name=s2 only_toplevel=false value="* Run transient
* default reltol=1e-3 vntol=1e-6 abstol=1e-12
.options  reltol=1e-4 vntol=1e-7 abstol=1e-13
*.options klu
.control
   save i(v_vdd_ref) i(v_vdd_div) 
   save clk clk_out clk_divr clk_divf 
   save xdivmm.clk_div23 xdivmm.mc
   save xdivmm.xp.q3 xdivmm.xp.q2 xdivmm.xp.q1 xdivmm.xp.q0 xdivmm.xp.q3_or_dis xdivmm.xp.q2_or_dis xdivmm.xp.q1_or_dis xdivmm.xp.q0_or_dis
   save xdivmm.q
   save xdivmm.xn.q1 xdivmm.xn.d2
   tran 1n 2u
   write tb_efx_pll96_sdiv_mm.raw
   meas tran idd_ref avg i(v_vdd_ref) from=800n to=2u
   meas tran idd_div avg i(v_vdd_div) from=800n to=2u
   meas tran T_CLK_DIVF trig v(clk_divf) val=0.9 rise=1 td=800n targ v(clk_divf) val=0.9 rise=2 td=800n
   print 1/T_CLK_DIVF
   print T_CLK_DIVF/10n
   meas tran T_CLK_DIVR trig v(clk_divr) val=0.9 rise=1 td=800n targ v(clk_divr) val=0.9 rise=2 td=800n
   print 1/T_CLK_DIVR
   print T_CLK_DIVR/200n
   * plot clk_divr clk_divf
.endc
.end"}
C {lab_wire.sym} 440 -640 0 0 {name=p5 sig_type=std_logic lab=clk}
C {vsource.sym} 1100 -540 0 0 {name=V_VDD_DIV value="\{VDD\}" savecurrent=true}
C {gnd.sym} 1100 -510 0 0 {name=l6 lab=GND}
C {lab_wire.sym} 1100 -620 0 1 {name=p4 sig_type=std_logic lab=vdd_div}
C {vsource.sym} 260 -160 0 0 {name=V2 value=\{VS3\} savecurrent=false}
C {gnd.sym} 260 -130 0 0 {name=V3 lab=GND
value=\{VS3\}}
C {vsource.sym} 340 -160 0 0 {name=V5 value=\{VS2\} savecurrent=false}
C {gnd.sym} 340 -130 0 0 {name=V6 lab=GND
value=\{VS3\}}
C {vsource.sym} 420 -160 0 0 {name=V8 value=\{VS1\} savecurrent=false}
C {gnd.sym} 420 -130 0 0 {name=V9 lab=GND
value=\{VS3\}}
C {vsource.sym} 500 -160 0 0 {name=V11 value=\{VS0\} savecurrent=false}
C {gnd.sym} 500 -130 0 0 {name=V12 lab=GND
value=\{VS3\}}
C {vsource.sym} 580 -160 0 0 {name=V14 value=\{VP3\} savecurrent=false}
C {gnd.sym} 580 -130 0 0 {name=V15 lab=GND
value=\{VS3\}}
C {vsource.sym} 660 -160 0 0 {name=V17 value=\{VP2\} savecurrent=false}
C {gnd.sym} 660 -130 0 0 {name=V18 lab=GND
value=\{VS3\}}
C {vsource.sym} 740 -160 0 0 {name=V20 value=\{VP1\} savecurrent=false}
C {gnd.sym} 740 -130 0 0 {name=V21 lab=GND
value=\{VS3\}}
C {vsource.sym} 820 -160 0 0 {name=V23 value=\{VP0\} savecurrent=false}
C {gnd.sym} 820 -130 0 0 {name=V24 lab=GND
value=\{VS3\}}
C {vsource.sym} 900 -160 0 0 {name=V26 value=\{VEN3\} savecurrent=false}
C {gnd.sym} 900 -130 0 0 {name=V27 lab=GND
value=\{VS3\}}
C {vsource.sym} 980 -160 0 0 {name=V29 value=\{VEN2\} savecurrent=false}
C {gnd.sym} 980 -130 0 0 {name=V30 lab=GND
value=\{VS3\}}
C {vsource.sym} 1060 -160 0 0 {name=V32 value=\{VEN1\} savecurrent=false}
C {gnd.sym} 1060 -130 0 0 {name=V33 lab=GND
value=\{VS3\}}
C {vsource.sym} 1140 -160 0 0 {name=V35 value=\{VEN0\} savecurrent=false}
C {gnd.sym} 1140 -130 0 0 {name=V36 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 260 -240 0 1 {name=p2 sig_type=std_logic lab=s3}
C {vsource.sym} 1220 -160 0 0 {name=V4 value="\{VENS\}" savecurrent=false}
C {gnd.sym} 1220 -130 0 0 {name=V7 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 340 -240 0 1 {name=p10 sig_type=std_logic lab=s2}
C {lab_wire.sym} 420 -240 0 1 {name=p11 sig_type=std_logic lab=s1}
C {lab_wire.sym} 500 -240 0 1 {name=p12 sig_type=std_logic lab=s0}
C {lab_wire.sym} 580 -240 0 1 {name=p14 sig_type=std_logic lab=p3}
C {lab_wire.sym} 660 -240 0 1 {name=p15 sig_type=std_logic lab=p2}
C {lab_wire.sym} 740 -240 0 1 {name=p16 sig_type=std_logic lab=p1}
C {lab_wire.sym} 820 -240 0 1 {name=p17 sig_type=std_logic lab=p0}
C {lab_wire.sym} 900 -240 0 1 {name=p18 sig_type=std_logic lab=en3}
C {lab_wire.sym} 980 -240 0 1 {name=p19 sig_type=std_logic lab=en2}
C {lab_wire.sym} 1060 -240 0 1 {name=p20 sig_type=std_logic lab=en1}
C {lab_wire.sym} 1140 -240 0 1 {name=p21 sig_type=std_logic lab=en0}
C {lab_wire.sym} 1220 -240 0 1 {name=p22 sig_type=std_logic lab=ens}
C {vsource.sym} 20 -160 0 0 {name=V10 value=\{VDIVR_EN\} savecurrent=false}
C {gnd.sym} 20 -130 0 0 {name=V13 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 20 -240 0 1 {name=p46 sig_type=std_logic lab=divr_en}
C {vsource.sym} 100 -160 0 0 {name=V16 value=\{VR1\} savecurrent=false}
C {gnd.sym} 100 -130 0 0 {name=V19 lab=GND
value=\{VS3\}}
C {vsource.sym} 180 -160 0 0 {name=V22 value=\{VR0\} savecurrent=false}
C {gnd.sym} 180 -130 0 0 {name=V25 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 100 -240 0 1 {name=p47 sig_type=std_logic lab=r1}
C {lab_wire.sym} 180 -240 0 1 {name=p48 sig_type=std_logic lab=r0}
C {copyright.sym} 0 40 0 0 {name=s3 place=header value="* Copyright (c) Eric Fogleman 2026 
* SPDX-License-Identifier: Apache-2.0"}
C {efx_pll96_sdiv_mm.sym} 630 -510 0 0 {name=xdivmm}
C {lab_wire.sym} 820 -640 0 1 {name=p1 sig_type=std_logic lab=vdd_div}
C {gnd.sym} 820 -360 0 0 {name=l2 lab=GND}
C {parax_cap.sym} 880 -460 0 0 {name=C3 gnd=0 value=\{CLOAD\} m=1}
C {lab_wire.sym} 910 -510 0 1 {name=p13 sig_type=std_logic lab=clk_divf}
C {lab_wire.sym} 440 -620 0 0 {name=p40 sig_type=std_logic lab=s3}
C {lab_wire.sym} 440 -600 0 0 {name=p65 sig_type=std_logic lab=s2}
C {lab_wire.sym} 440 -580 0 0 {name=p66 sig_type=std_logic lab=s1}
C {lab_wire.sym} 440 -560 0 0 {name=p67 sig_type=std_logic lab=s0}
C {lab_wire.sym} 440 -540 0 0 {name=p68 sig_type=std_logic lab=p3}
C {lab_wire.sym} 440 -520 0 0 {name=p69 sig_type=std_logic lab=p2}
C {lab_wire.sym} 440 -500 0 0 {name=p70 sig_type=std_logic lab=p1}
C {lab_wire.sym} 440 -480 0 0 {name=p71 sig_type=std_logic lab=p0}
C {lab_wire.sym} 440 -460 0 0 {name=p72 sig_type=std_logic lab=en3}
C {lab_wire.sym} 440 -440 0 0 {name=p73 sig_type=std_logic lab=en2}
C {lab_wire.sym} 440 -420 0 0 {name=p74 sig_type=std_logic lab=en1}
C {lab_wire.sym} 440 -400 0 0 {name=p75 sig_type=std_logic lab=en0}
C {lab_wire.sym} 440 -380 0 0 {name=p76 sig_type=std_logic lab=ens}
C {efx_pll96_div_r.sym} 630 -830 0 0 {name=xdivr}
C {lab_wire.sym} 820 -860 0 1 {name=p3 sig_type=std_logic lab=vdd_ref}
C {gnd.sym} 820 -780 0 0 {name=l4 lab=GND}
C {parax_cap.sym} 880 -780 0 0 {name=C1 gnd=0 value=\{CLOAD\} m=1}
C {lab_wire.sym} 910 -830 0 1 {name=p6 sig_type=std_logic lab=clk_divr}
C {vsource.sym} 1100 -800 0 0 {name=V_VDD_REF value="\{VDD\}" savecurrent=true}
C {gnd.sym} 1100 -770 0 0 {name=l5 lab=GND}
C {lab_wire.sym} 1100 -880 0 1 {name=p7 sig_type=std_logic lab=vdd_ref}
C {vsource.sym} 0 -760 0 0 {name=V56 value="0 PULSE(0 \{VDD\} \{TD_REF\} \{T_RF\} \{T_RF\} \{T_REF/2\} \{T_REF\})"}
C {gnd.sym} 0 -730 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 440 -800 0 0 {name=p8 sig_type=std_logic lab=divr_en}
C {lab_wire.sym} 440 -840 0 0 {name=p9 sig_type=std_logic lab=r0}
C {lab_wire.sym} 440 -860 0 0 {name=p23 sig_type=std_logic lab=r1}
C {lab_wire.sym} 440 -820 0 0 {name=p24 sig_type=std_logic lab=clk_out}
