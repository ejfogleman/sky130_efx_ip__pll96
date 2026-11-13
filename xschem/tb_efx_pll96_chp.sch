v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
T {ICP Bias settings:
b[2],b[1],b[0]
1,1,1 ==> 0.667 uA (debug)
1,0,1 ==> 1.0 uA (5 uA chp)
1,0,0 ==> 1.5 uA (7.5 uA chp)
0,1,0 ==> 2.0 uA (10 uA chp)
0,0,0 ==> undefined} 470 -600 0 0 0.4 0.4 {}
N 1190 -190 1190 -160 {lab=GND}
N 1190 -350 1250 -350 {lab=vdd}
N 1400 -320 1400 -300 {lab=#net1}
N 100 -240 100 -220 {lab=p}
N 200 -240 200 -220 {lab=p_b}
N 300 -240 300 -220 {lab=n}
N 400 -240 400 -220 {lab=n_b}
N 1190 -320 1300 -320 {
lab=cp}
N 1360 -320 1400 -320 {
lab=#net1}
N 830 -230 890 -230 {lab=b[0]}
N 830 -190 890 -190 {lab=en}
N 1040 -160 1040 -130 {
lab=ibnp_1u}
N 100 -380 100 -360 {lab=b[2]}
N 300 -380 300 -360 {lab=b[0]}
N 0 -380 0 -360 {
lab=vdd}
N 500 -380 500 -360 {lab=en}
N 200 -380 200 -360 {lab=b[1]}
N 830 -250 890 -250 {lab=b[1]}
N 830 -270 890 -270 {lab=b[2]}
N 830 -350 890 -350 {lab=p}
N 830 -330 890 -330 {lab=p_b}
N 830 -310 890 -310 {lab=n}
N 830 -290 890 -290 {lab=n_b}
C {title_efx.sym} 190 0 0 0 {name=l1 author="ejfogleman"}
C {vsource.sym} 0 -330 0 0 {name=V_VDD value="\{VDD\} AC=1" savecurrent=true}
C {gnd.sym} 0 -300 0 0 {name=l10 lab=GND}
C {lab_wire.sym} 0 -380 0 1 {name=p13 sig_type=std_logic lab=vdd}
C {devices/code_shown.sym} 0 120 0 0 {name=s1 only_toplevel=false value="* ejf_pfd test
.lib ~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice tt
.option temp=27
.param VDD=1.8
.param CP=10f
.param VC=0.85
.param IB=1u
.param VB2=1.8
.param VB1=0
.param VB0=1.8
.param VEN=1.8
"}
C {devices/code_shown.sym} 840 120 0 0 {name=s2 only_toplevel=false value="* 
* default reltol=1e-3 vntol=1e-6 abstol=1e-12
.options  reltol=1e-4 vntol=1e-7 abstol=1e-13
.option sparse
*.option klu
.control
   save all
   noise v(cp) V_VDD dec 10 1 1G
   write tb_efx_pll96_chp.raw
.endc
.end"}
C {efx_pll96_chp.sym} 1040 -320 0 0 {name=xchp}
C {gnd.sym} 1190 -160 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 1250 -350 0 1 {name=p6 sig_type=std_logic lab=vdd}
C {isource.sym} 1040 -110 0 0 {name=I0 value=\{IB\}}
C {lab_wire.sym} 830 -350 0 0 {name=p4 sig_type=std_logic lab=p}
C {lab_wire.sym} 830 -330 0 0 {name=p8 sig_type=std_logic lab=p_b}
C {lab_wire.sym} 830 -310 0 0 {name=p9 sig_type=std_logic lab=n}
C {lab_wire.sym} 830 -290 0 0 {name=p10 sig_type=std_logic lab=n_b}
C {vsource.sym} 1400 -270 0 0 {name=V_VCP value=\{VC\} savecurrent=true}
C {gnd.sym} 1400 -240 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 1250 -320 0 1 {name=p11 sig_type=std_logic lab=cp}
C {lab_wire.sym} 1040 -150 0 1 {name=p1 sig_type=std_logic lab=ibnp_1u}
C {vsource.sym} 100 -190 0 0 {name=V1 value=\{VDD\} savecurrent=true}
C {gnd.sym} 100 -160 0 0 {name=l2 lab=GND}
C {vsource.sym} 200 -190 0 0 {name=V2 value=0 savecurrent=true}
C {gnd.sym} 200 -160 0 0 {name=l3 lab=GND}
C {vsource.sym} 300 -190 0 0 {name=V3 value=\{VDD\} savecurrent=true}
C {gnd.sym} 300 -160 0 0 {name=l5 lab=GND}
C {vsource.sym} 400 -190 0 0 {name=V4 value=0 savecurrent=true}
C {gnd.sym} 400 -160 0 0 {name=l6 lab=GND}
C {lab_wire.sym} 100 -240 0 1 {name=p2 sig_type=std_logic lab=p}
C {lab_wire.sym} 200 -240 0 1 {name=p5 sig_type=std_logic lab=p_b}
C {lab_wire.sym} 300 -240 0 1 {name=p12 sig_type=std_logic lab=n}
C {lab_wire.sym} 400 -240 0 1 {name=p14 sig_type=std_logic lab=n_b}
C {res.sym} 1330 -320 1 0 {name=R1
value="1 noise=0"
m=1}
C {lab_wire.sym} 830 -230 0 0 {name=p15 sig_type=std_logic lab=b[0]}
C {lab_wire.sym} 830 -190 0 0 {name=p17 sig_type=std_logic lab=en}
C {gnd.sym} 1040 -80 0 0 {name=l8 lab=GND}
C {vsource.sym} 100 -330 0 0 {name=V5 value=\{VB2\} savecurrent=true}
C {gnd.sym} 100 -300 0 0 {name=l9 lab=GND}
C {lab_wire.sym} 100 -380 0 1 {name=p3 sig_type=std_logic lab=b[2]}
C {vsource.sym} 300 -330 0 0 {name=V6 value=\{VB0\} savecurrent=true}
C {gnd.sym} 300 -300 0 0 {name=l11 lab=GND}
C {lab_wire.sym} 300 -380 0 1 {name=p18 sig_type=std_logic lab=b[0]}
C {vsource.sym} 500 -330 0 0 {name=V8 value=\{VEN\} savecurrent=true}
C {gnd.sym} 500 -300 0 0 {name=l13 lab=GND}
C {lab_wire.sym} 500 -380 0 1 {name=p20 sig_type=std_logic lab=en}
C {vsource.sym} 200 -330 0 0 {name=V9 value=\{VB1\} savecurrent=true}
C {gnd.sym} 200 -300 0 0 {name=l14 lab=GND}
C {lab_wire.sym} 200 -380 0 1 {name=p16 sig_type=std_logic lab=b[1]}
C {lab_wire.sym} 830 -250 0 0 {name=p21 sig_type=std_logic lab=b[1]}
C {lab_wire.sym} 830 -270 0 0 {name=p22 sig_type=std_logic lab=b[2]}
C {copyright.sym} 0 40 0 0 {name=s3 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {lab_wire.sym} 1190 -300 0 0 {name=p23 sig_type=std_logic lab=cp}
