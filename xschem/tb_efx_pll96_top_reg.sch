v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 990 -890 990 -840 {lab=vdd_ref}
N 1180 -890 1180 -840 {lab=vdd_vco}
N 1370 -890 1370 -840 {lab=vdd_div}
N 800 -950 840 -950 {
lab=vdd_ref}
N 800 -930 840 -930 {
lab=vdd_vco}
N 800 -910 840 -910 {
lab=vdd_div}
N 900 -690 930 -690 {
lab=clk_out}
N 270 -250 270 -200 {
lab=c4}
N 350 -250 350 -200 {
lab=c3}
N 430 -250 430 -200 {
lab=c2}
N 510 -250 510 -200 {
lab=c1}
N 590 -250 590 -200 {
lab=c0}
N 460 -590 500 -590 {
lab=c4}
N 460 -570 500 -570 {
lab=c3}
N 460 -550 500 -550 {
lab=c2}
N 460 -530 500 -530 {
lab=c1}
N 460 -510 500 -510 {
lab=c0}
N 800 -550 820 -550 {
lab=GND}
N 820 -510 820 -490 {
lab=GND}
N 800 -530 820 -530 {
lab=GND}
N 820 -550 820 -530 {
lab=GND}
N 800 -510 820 -510 {
lab=GND}
N 820 -530 820 -510 {
lab=GND}
N 20 -950 20 -810 {
lab=clk}
N 460 -910 500 -910 {
lab=r1}
N 460 -890 500 -890 {
lab=r0}
N 460 -930 500 -930 {
lab=divr_en}
N 460 -810 500 -810 {
lab=cpb1}
N 460 -830 500 -830 {
lab=cpb2}
N 460 -750 500 -750 {
lab=csc}
N 30 -250 30 -200 {
lab=divr_en}
N 110 -250 110 -200 {
lab=r1}
N 190 -250 190 -200 {
lab=r0}
N 750 -250 750 -200 {
lab=cpb0}
N 910 -250 910 -200 {
lab=cpb2}
N 990 -250 990 -200 {
lab=csc}
N 820 -670 820 -650 {
lab=clk_out_div2}
N 900 -690 900 -650 {
lab=clk_out}
N 800 -690 900 -690 {
lab=clk_out}
N 820 -670 930 -670 {
lab=clk_out_div2}
N 800 -670 820 -670 {
lab=clk_out_div2}
N 650 -470 650 -440 {
lab=ibnp_1u}
N 460 -850 500 -850 {
lab=chp_en}
N 460 -670 500 -670 {
lab=tst2}
N 460 -650 500 -650 {
lab=tst1}
N 460 -630 500 -630 {
lab=tst0}
N 1310 -250 1310 -200 {
lab=tst0}
N 1390 -250 1390 -200 {
lab=tst1}
N 1470 -250 1470 -200 {
lab=tst2}
N 20 -950 500 -950 {
lab=clk}
N -50 -250 -50 -200 {
lab=chp_en}
N 460 -790 500 -790 {
lab=cpb0}
N 460 -730 500 -730 {
lab=rsc1}
N 460 -710 500 -710 {
lab=rsc0}
N 830 -250 830 -200 {
lab=cpb1}
N 1070 -250 1070 -200 {
lab=rsc1}
N 1150 -250 1150 -200 {
lab=rsc0}
C {title_efx.sym} 200 0 0 0 {name=l1 author="ejfogleman"}
C {devices/code_shown.sym} 10 120 0 0 {name=s1 only_toplevel=false value="* PLL top level testbench
.lib ~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice tt
*** efx_pll96 regression
*** run with:
*** ngspice -b -r top_reg.raw -o top_reg.out tb_efx_pll96_top_reg.spice

*** simulation setup
.option temp=27
.param VDD=1.8
.param TD_REF=50n
.param T_RF=300p
.param T_RAMP=50n
.param CP=10f
.param CLOAD=10f
.param IB=1u
.param VDIVR_EN=1.8
.param VCHP_EN=1.8
.param VTST0=0
.param VTST1=0
.param VTST2=0

*** mode-dependent options
.include config.inc
"}
C {devices/code.sym} 10 610 0 0 {name=s4 only_toplevel=false value="tcleval(* lvdig standard cells (layout-extracted, C parasitics; symbols are primitives)
.include $::LVDIG_SPICE/sky130_efx_lvdig_c.spice)"}
C {devices/code_shown.sym} 860 120 0 0 {name=s2 only_toplevel=false value="* Run transient
* default reltol=1e-3 vntol=1e-6 abstol=1e-12
.options  reltol=1e-4 vntol=1e-7 abstol=1e-13
*.options klu
* sim length T_SIM comes from config.inc; measurements use the last 2 us
.csparam t_sim = \{T_SIM\}
.csparam vdd_p = \{VDD\}
.csparam t_ref = \{T_REF\}
.csparam p_vr0 = \{VR0\}
.csparam p_vr1 = \{VR1\}
.csparam p_vc0 = \{VC0\}
.csparam p_vc1 = \{VC1\}
.csparam p_vc2 = \{VC2\}
.csparam p_vc3 = \{VC3\}
.csparam p_vc4 = \{VC4\}
.control
   save i(v_vdd_ref) i(v_vdd_vco) i(v_vdd_div) 
   save clk clk_out clk_out_div2 ibnp_1u
   save xpll.qref xpll.qref_b xpll.qclk xpll.qclk_b xpll.vc xpll.vco_outp xpll.vco_outn
   save xpll.xvco.vhi xpll.clk_divf xpll.clk_ref
   save xpll.xvco.x0p xpll.xvco.x0n xpll.xvco.x1p xpll.xvco.x1n xpll.xvco.x2p xpll.xvco.x2n xpll.xvco.x3p xpll.xvco.x3n
   save xpll.xchp.vc_repl xpll.xchp.mp1g xpll.xchp.mn1g xpll.xchp.mn1cg
   save xpll.xchp.mn1d xpll.xchp.mp1d xpll.xchp.mp1cd xpll.xchp.mn1cd
   save xpll.vc2 xpll.xchp.mp20d
   tran 1n $&t_sim
   write tb_efx_pll96_top_reg.raw
   let t_m0 = t_sim - 2e-6
   let t_mh = t_sim - 1e-6
   meas tran idd_ref avg i(v_vdd_ref) from=$&t_m0 to=$&t_sim
   meas tran idd_vco avg i(v_vdd_vco) from=$&t_m0 to=$&t_sim
   meas tran idd_div avg i(v_vdd_div) from=$&t_m0 to=$&t_sim
*  lock check: clk_out frequency over 10 periods within 0.25% of N/(R*T_REF), and
*  vc settled (avg of last two 1 us windows differ < 1% VDD) at 0.25..0.75 VDD
   let T_CLK10 = 0
   meas tran T_CLK10 trig v(clk_out) val=0.9 rise=1 td=$&t_mh targ v(clk_out) val=0.9 rise=11 td=$&t_mh
   meas tran vc_avg avg v(xpll.vc) from=$&t_m0 to=$&t_sim
   meas tran vc_avg1 avg v(xpll.vc) from=$&t_m0 to=$&t_mh
   meas tran vc_avg2 avg v(xpll.vc) from=$&t_mh to=$&t_sim
   meas tran vc_pp pp v(xpll.vc) from=$&t_m0 to=$&t_sim
*  charge-pump replica: its vc_repl should track vc (= vc2 at DC)
   meas tran vc_repl_avg avg v(xpll.xchp.vc_repl) from=$&t_m0 to=$&t_sim
   meas tran vc_repl_pp pp v(xpll.xchp.vc_repl) from=$&t_m0 to=$&t_sim
*  target from the programmed dividers: N = divf_c+1 (code 0 = 33), R from divr_r (00:1, 01:2, 1x:4)
   let divf_c = (p_vc0 gt vdd_p/2) + 2*(p_vc1 gt vdd_p/2) + 4*(p_vc2 gt vdd_p/2) + 8*(p_vc3 gt vdd_p/2) + 16*(p_vc4 gt vdd_p/2)
   let n_div = divf_c + 1 + 32*(divf_c eq 0)
   let r_div = 1 + (p_vr0 gt vdd_p/2)*(p_vr1 lt vdd_p/2) + 3*(p_vr1 gt vdd_p/2)
   let f_tgt = n_div/(r_div*t_ref)
   let T_CLK_OUT = T_CLK10/10
   let f_out = 0
   let f_err = -1
   if T_CLK10 > 0
      let f_out = 1/T_CLK_OUT
      let f_err = f_out/f_tgt - 1
   end
   let vc_frac = vc_avg/vdd_p
   let vc_drift = vc_avg2 - vc_avg1
   let ok_vc = (vc_frac gt 0.25) & (vc_frac lt 0.75) & (abs(vc_drift) lt 0.01*vdd_p)
   let ok_f = abs(f_err) lt 0.0025
   if ok_vc & ok_f
      set res = "PASS"
   else
      set res = "FAIL"
   end
   echo LOCK $res N= $&n_div R= $&r_div f_tgt= $&f_tgt f_out= $&f_out f_err= $&f_err vc= $&vc_avg vc/vdd= $&vc_frac vc_drift= $&vc_drift vc_pp= $&vc_pp
   let vc_repl_err = vc_repl_avg - vc_avg
   echo VC_REPL vc_repl= $&vc_repl_avg vc_repl-vc= $&vc_repl_err vc_repl_pp= $&vc_repl_pp
.endc
"}
C {copyright.sym} 0 40 0 0 {name=s3 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {vsource.sym} 990 -810 0 0 {name=V_VDD_REF value="0 PWL(0 0 \{T_RAMP\} \{VDD\})" savecurrent=true}
C {gnd.sym} 990 -780 0 0 {name=l10 lab=GND}
C {lab_wire.sym} 990 -890 0 1 {name=p13 sig_type=std_logic lab=vdd_ref}
C {vsource.sym} 20 -780 0 0 {name=V1 value="0 PULSE(0 \{VDD\} \{TD_REF\} \{T_RF\} \{T_RF\} \{T_REF/2\} \{T_REF\})"}
C {gnd.sym} 20 -750 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 460 -950 0 0 {name=p5 sig_type=std_logic lab=clk}
C {efx_pll96.sym} 650 -730 0 0 {name=xpll}
C {vsource.sym} 1180 -810 0 0 {name=V_VDD_VCO value="0 PWL(0 0 \{T_RAMP\} \{VDD\})" savecurrent=true}
C {gnd.sym} 1180 -780 0 0 {name=l2 lab=GND}
C {lab_wire.sym} 1180 -890 0 1 {name=p1 sig_type=std_logic lab=vdd_vco}
C {vsource.sym} 1370 -810 0 0 {name=V_VDD_DIV value="0 PWL(0 0 \{T_RAMP\} \{VDD\})" savecurrent=true}
C {gnd.sym} 1370 -780 0 0 {name=l6 lab=GND}
C {lab_wire.sym} 1370 -890 0 1 {name=p4 sig_type=std_logic lab=vdd_div}
C {gnd.sym} 820 -490 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 840 -950 0 1 {name=p6 sig_type=std_logic lab=vdd_ref}
C {lab_wire.sym} 840 -930 0 1 {name=p7 sig_type=std_logic lab=vdd_vco}
C {lab_wire.sym} 840 -910 0 1 {name=p8 sig_type=std_logic lab=vdd_div}
C {lab_wire.sym} 930 -690 0 1 {name=p9 sig_type=std_logic lab=clk_out}
C {vsource.sym} 270 -170 0 0 {name=V2 value=\{VC4\} savecurrent=false}
C {gnd.sym} 270 -140 0 0 {name=V3 lab=GND
value=\{VS3\}}
C {vsource.sym} 350 -170 0 0 {name=V5 value=\{VC3\} savecurrent=false}
C {gnd.sym} 350 -140 0 0 {name=V6 lab=GND
value=\{VS3\}}
C {vsource.sym} 430 -170 0 0 {name=V8 value=\{VC2\} savecurrent=false}
C {gnd.sym} 430 -140 0 0 {name=V9 lab=GND
value=\{VS3\}}
C {vsource.sym} 510 -170 0 0 {name=V11 value=\{VC1\} savecurrent=false}
C {gnd.sym} 510 -140 0 0 {name=V12 lab=GND
value=\{VS3\}}
C {vsource.sym} 590 -170 0 0 {name=V14 value=\{VC0\} savecurrent=false}
C {gnd.sym} 590 -140 0 0 {name=V15 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 270 -250 0 1 {name=p2 sig_type=std_logic lab=c4}
C {lab_wire.sym} 350 -250 0 1 {name=p10 sig_type=std_logic lab=c3}
C {lab_wire.sym} 430 -250 0 1 {name=p11 sig_type=std_logic lab=c2}
C {lab_wire.sym} 510 -250 0 1 {name=p12 sig_type=std_logic lab=c1}
C {lab_wire.sym} 590 -250 0 1 {name=p14 sig_type=std_logic lab=c0}
C {lab_wire.sym} 460 -590 0 0 {name=p23 sig_type=std_logic lab=c4}
C {lab_wire.sym} 460 -570 0 0 {name=p24 sig_type=std_logic lab=c3}
C {lab_wire.sym} 460 -550 0 0 {name=p25 sig_type=std_logic lab=c2}
C {lab_wire.sym} 460 -530 0 0 {name=p26 sig_type=std_logic lab=c1}
C {lab_wire.sym} 460 -510 0 0 {name=p27 sig_type=std_logic lab=c0}
C {lab_wire.sym} 930 -670 0 1 {name=p37 sig_type=std_logic lab=clk_out_div2}
C {isource.sym} 650 -420 0 0 {name=I1 value=\{IB\}}
C {lab_wire.sym} 650 -460 0 1 {name=p3 sig_type=std_logic lab=ibnp_1u}
C {lab_wire.sym} 460 -910 0 0 {name=p39 sig_type=std_logic lab=r1}
C {lab_wire.sym} 460 -890 0 0 {name=p41 sig_type=std_logic lab=r0}
C {lab_wire.sym} 460 -930 0 0 {name=p42 sig_type=std_logic lab=divr_en}
C {lab_wire.sym} 460 -810 0 0 {name=p43 sig_type=std_logic lab=cpb1
}
C {lab_wire.sym} 460 -830 0 0 {name=p44 sig_type=std_logic lab=cpb2
}
C {lab_wire.sym} 460 -750 0 0 {name=p45 sig_type=std_logic lab=csc
}
C {vsource.sym} 30 -170 0 0 {name=V10 value=\{VDIVR_EN\} savecurrent=false}
C {gnd.sym} 30 -140 0 0 {name=V13 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 30 -250 0 1 {name=p46 sig_type=std_logic lab=divr_en}
C {vsource.sym} 110 -170 0 0 {name=V16 value=\{VR1\} savecurrent=false}
C {gnd.sym} 110 -140 0 0 {name=V19 lab=GND
value=\{VS3\}}
C {vsource.sym} 190 -170 0 0 {name=V22 value=\{VR0\} savecurrent=false}
C {gnd.sym} 190 -140 0 0 {name=V25 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 110 -250 0 1 {name=p47 sig_type=std_logic lab=r1}
C {lab_wire.sym} 190 -250 0 1 {name=p48 sig_type=std_logic lab=r0}
C {vsource.sym} 750 -170 0 0 {name=V28 value=\{VCPB0\} savecurrent=false}
C {gnd.sym} 750 -140 0 0 {name=V31 lab=GND
value=\{VS3\}}
C {vsource.sym} 910 -170 0 0 {name=V34 value=\{VCPB2\} savecurrent=false}
C {gnd.sym} 910 -140 0 0 {name=V37 lab=GND
value=\{VS3\}}
C {vsource.sym} 990 -170 0 0 {name=V38 value=\{VCSC\} savecurrent=false}
C {gnd.sym} 990 -140 0 0 {name=V39 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 750 -250 0 1 {name=p49 sig_type=std_logic lab=cpb0}
C {lab_wire.sym} 910 -250 0 1 {name=p50 sig_type=std_logic lab=cpb2}
C {lab_wire.sym} 990 -250 0 1 {name=p51 sig_type=std_logic lab=csc}
C {parax_cap.sym} 820 -640 0 0 {name=C1 gnd=0 value=\{CLOAD\} m=1}
C {parax_cap.sym} 900 -640 0 0 {name=C2 gnd=0 value=\{CLOAD\} m=1}
C {gnd.sym} 650 -390 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 460 -850 0 0 {name=p36 sig_type=std_logic lab=chp_en}
C {lab_wire.sym} 460 -670 0 0 {name=p52 sig_type=std_logic lab=tst2
}
C {lab_wire.sym} 460 -650 0 0 {name=p53 sig_type=std_logic lab=tst1
}
C {lab_wire.sym} 460 -630 0 0 {name=p54 sig_type=std_logic lab=tst0
}
C {vsource.sym} 1310 -170 0 0 {name=V42 value=\{VTST0\} savecurrent=false}
C {gnd.sym} 1310 -140 0 0 {name=V43 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 1310 -250 0 1 {name=p55 sig_type=std_logic lab=tst0}
C {vsource.sym} 1390 -170 0 0 {name=V44 value=\{VTST1\} savecurrent=false}
C {gnd.sym} 1390 -140 0 0 {name=V45 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 1390 -250 0 1 {name=p56 sig_type=std_logic lab=tst1}
C {vsource.sym} 1470 -170 0 0 {name=V46 value=\{VTST2\} savecurrent=false}
C {gnd.sym} 1470 -140 0 0 {name=V47 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 1470 -250 0 1 {name=p57 sig_type=std_logic lab=tst2}
C {vsource.sym} -50 -170 0 0 {name=V48 value=\{VCHP_EN\} savecurrent=false}
C {gnd.sym} -50 -140 0 0 {name=V49 lab=GND
value=\{VS3\}}
C {lab_wire.sym} -50 -250 0 1 {name=p58 sig_type=std_logic lab=chp_en}
C {lab_wire.sym} 460 -790 0 0 {name=p59 sig_type=std_logic lab=cpb0
}
C {lab_wire.sym} 460 -730 0 0 {name=p60 sig_type=std_logic lab=rsc1
}
C {lab_wire.sym} 460 -710 0 0 {name=p61 sig_type=std_logic lab=rsc0
}
C {vsource.sym} 830 -170 0 0 {name=V50 value=\{VCPB1\} savecurrent=false}
C {gnd.sym} 830 -140 0 0 {name=V51 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 830 -250 0 1 {name=p62 sig_type=std_logic lab=cpb1}
C {vsource.sym} 1070 -170 0 0 {name=V52 value=\{VRSC1\} savecurrent=false}
C {gnd.sym} 1070 -140 0 0 {name=V53 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 1070 -250 0 1 {name=p63 sig_type=std_logic lab=rsc1}
C {vsource.sym} 1150 -170 0 0 {name=V54 value=\{VRSC0\} savecurrent=false}
C {gnd.sym} 1150 -140 0 0 {name=V55 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 1150 -250 0 1 {name=p64 sig_type=std_logic lab=rsc0}
