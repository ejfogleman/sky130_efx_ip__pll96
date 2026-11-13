v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
T {100 uA} 490 -800 0 0 0.4 0.4 {}
T {Approximate VCO range
vc = 0.9 V ==> 70.8 MHz (tst_mid)
vc = 0.6 V ==> 122 MHz (tst_lo)} 620 -540 0 0 0.4 0.4 {}
N 70 -530 70 -480 {lab=vdd}
N 830 -740 870 -740 {lab=vdd}
N 530 -620 530 -590 {lab=GND}
N 830 -690 940 -690 {lab=vcon}
N 830 -710 1030 -710 {lab=vcop}
N 490 -740 530 -740 {
lab=vdd_vco}
N -30 -530 -30 -480 {lab=vdd_vco}
N 160 -530 160 -480 {
lab=tst_lo}
N 240 -530 240 -480 {
lab=tst_mid}
N 320 -530 320 -480 {
lab=tst_hi}
N 460 -680 530 -680 {
lab=tst_hi}
N 460 -660 530 -660 {
lab=tst_mid}
N 460 -640 530 -640 {
lab=tst_lo}
N 400 -700 530 -700 {
lab=vc}
N 180 -700 340 -700 {
lab=#net1}
N 180 -700 180 -670 {
lab=#net1}
C {vsource.sym} 70 -450 0 0 {name=V_VDD value=\{VDD\} savecurrent=false}
C {gnd.sym} 70 -420 0 0 {name=l10 lab=GND}
C {devices/code_shown.sym} -40 -180 0 0 {name=s1 only_toplevel=false value="* ejf_delaycell test
.lib ~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice tt
.option temp=27
.param VDD=1.8
.param I_PULSE=1u
.param I_SRC=101u
.param CP=20f
.param VC=0.75
.param VTLO=0
.param VTMID=0
.param VTHI=0
.param RC=1
"}
C {devices/code_shown.sym} 800 -190 0 0 {name=s2 only_toplevel=false value="* Run transient
* default reltol=1e-3 vntol=1e-6 abstol=1e-12
.options  reltol=1e-6 vntol=1e-9 abstol=1e-15
.control
   save all
   tran 1n 300n
   write tb_efx_pll96_vco.raw
   plot vcop vcon
   meas tran i_v_vdd_avg avg i(v_vdd) from=10n to=100n
   meas tran i_v_vdd_vco_avg avg i(v_vdd_vco) from=10n to=100n
   meas tran vhi_avg avg xvco.vhi from=10n to=100n
   meas tran delta_t trig vcop val=0.5 rise=20 targ vcop val=0.5 rise=21
   print 1/delta_t
.endc
.end"}
C {lab_wire.sym} 70 -530 0 1 {name=p13 sig_type=std_logic lab=vdd}
C {lab_wire.sym} 870 -740 0 1 {name=p3 sig_type=std_logic lab=vdd}
C {gnd.sym} 530 -590 0 0 {name=l20 lab=GND}
C {parax_cap.sym} 1030 -700 0 0 {name=C1 gnd=0 value=\{CP\} m=1}
C {parax_cap.sym} 940 -680 0 0 {name=C2 gnd=0 value=\{CP\} m=1}
C {lab_wire.sym} 870 -710 0 1 {name=p14 sig_type=std_logic lab=vcop}
C {lab_wire.sym} 870 -690 0 1 {name=p15 sig_type=std_logic lab=vcon}
C {title_efx.sym} 200 -310 0 0 {name=l1 author="ejfogleman"
value="* ejf_delaycell test
.lib ~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice tt
.option temp=27
.param VDD=1.8
.param I_PULSE=0
.param I_SRC=100u
.param CP=10f
"}
C {vsource.sym} 180 -640 0 0 {name=V3 value="\{VC\} PWL(0 0 1n \{VC\})"}
C {lab_wire.sym} 460 -700 0 1 {name=p9 sig_type=std_logic lab=vc}
C {efx_pll96_vco.sym} 680 -700 0 0 {name=xvco}
C {lab_wire.sym} 490 -740 0 1 {name=p11 sig_type=std_logic lab=vdd_vco}
C {vsource.sym} -30 -450 0 0 {name=V_VDD_VCO value=\{VDD\} savecurrent=false}
C {gnd.sym} -30 -420 0 0 {name=l2 lab=GND}
C {lab_wire.sym} -30 -530 0 1 {name=p1 sig_type=std_logic lab=vdd_vco}
C {vsource.sym} 160 -450 0 0 {name=V42 value=\{VTLO\} savecurrent=false}
C {gnd.sym} 160 -420 0 0 {name=V43 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 160 -530 0 1 {name=p55 sig_type=std_logic lab=tst_lo}
C {vsource.sym} 240 -450 0 0 {name=V44 value=\{VTMID\} savecurrent=false}
C {gnd.sym} 240 -420 0 0 {name=V45 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 240 -530 0 1 {name=p56 sig_type=std_logic lab=tst_mid}
C {vsource.sym} 320 -450 0 0 {name=V46 value=\{VTHI\} savecurrent=false}
C {gnd.sym} 320 -420 0 0 {name=V47 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 320 -530 0 1 {name=p57 sig_type=std_logic lab=tst_hi}
C {lab_wire.sym} 460 -680 0 1 {name=p2 sig_type=std_logic lab=tst_hi}
C {lab_wire.sym} 460 -660 0 1 {name=p4 sig_type=std_logic lab=tst_mid}
C {lab_wire.sym} 460 -640 0 1 {name=p5 sig_type=std_logic lab=tst_lo}
C {res.sym} 370 -700 1 0 {name=R1
value=\{RC\}
m=1}
C {gnd.sym} 180 -610 0 0 {name=V1 lab=GND
value=\{VS3\}}
C {copyright.sym} 0 -270 0 0 {name=s3 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
