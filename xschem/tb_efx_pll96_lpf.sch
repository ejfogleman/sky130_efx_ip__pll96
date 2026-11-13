v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 0 -240 0 -190 {
lab=csc}
N -190 -240 -190 -190 {lab=vdd}
N 590 -250 620 -250 {
lab=GND}
N 620 -250 620 -220 {
lab=GND}
N 320 -300 370 -300 {
lab=csc}
N 320 -280 370 -280 {
lab=rsc[1]}
N 80 -240 80 -190 {
lab=rsc[1]}
N 170 -240 170 -190 {
lab=rsc[0]}
N 480 -220 480 -170 {
lab=vc}
N 590 -310 640 -310 {
lab=vdd}
N 320 -260 370 -260 {
lab=rsc[0]}
C {title_efx.sym} 110 0 0 0 {name=l1 author="ejfogleman"}
C {vsource.sym} 0 -160 0 0 {name=V38 value=\{VCSC\} savecurrent=false}
C {gnd.sym} 0 -130 0 0 {name=V39 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 0 -240 0 1 {name=p51 sig_type=std_logic lab=csc}
C {vsource.sym} -190 -160 0 0 {name=V_VDD_VCO value=\{VDD\} savecurrent=true}
C {gnd.sym} -190 -130 0 0 {name=l2 lab=GND}
C {lab_wire.sym} -190 -240 0 1 {name=p1 sig_type=std_logic lab=vdd}
C {efx_pll96_lpf.sym} 480 -280 0 0 {name=xlpf}
C {gnd.sym} 620 -220 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 640 -310 0 1 {name=p2 sig_type=std_logic lab=vdd}
C {lab_wire.sym} 320 -280 0 1 {name=p3 sig_type=std_logic lab=rsc[1]}
C {gnd.sym} 480 -110 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 480 -190 0 1 {name=p4 sig_type=std_logic lab=vc}
C {devices/code_shown.sym} -260 140 0 0 {name=s1 only_toplevel=false value="* ejf_pfd test
.lib ~/.ciel/sky130A/libs.tech/combined/sky130.lib.spice tt
.option temp=27
.param VDD=1.8
.param VCSC=0
.param VRSC1=1.8
.param VRSC0=1.8
.param VC=0.9
"}
C {devices/code_shown.sym} 580 140 0 0 {name=s2 only_toplevel=false value="* Run transient
* default reltol=1e-3 vntol=1e-6 abstol=1e-12
.options  reltol=1e-4 vntol=1e-7 abstol=1e-13
.control
   save all 
   ac dec 10 1k 1g
   let i_mag = mag(i(v_vc))
   meas ac i_at_1k find i_mag at=1k
   print i_at_1k/6.283/1e3
   meas ac i_at_100meg find i_mag at=100meg
   print i_at_100meg/6.283/100e6
   write tb_efx_pll96_lpf.raw
.endc
.end"}
C {vsource.sym} 480 -140 0 0 {name=V_VC value="\{VC\} AC=1" savecurrent=true}
C {lab_wire.sym} 320 -300 0 1 {name=p5 sig_type=std_logic lab=csc}
C {vsource.sym} 80 -160 0 0 {name=V1 value=\{VRSC1\} savecurrent=false}
C {gnd.sym} 80 -130 0 0 {name=V2 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 80 -240 0 1 {name=p6 sig_type=std_logic lab=rsc[1]}
C {vsource.sym} 170 -160 0 0 {name=V3 value=\{VRSC0\} savecurrent=false}
C {gnd.sym} 170 -130 0 0 {name=V4 lab=GND
value=\{VS3\}}
C {lab_wire.sym} 170 -240 0 1 {name=p7 sig_type=std_logic lab=rsc[0]}
C {lab_wire.sym} 320 -260 0 1 {name=p8 sig_type=std_logic lab=rsc[0]}
C {copyright.sym} -90 40 0 0 {name=s3 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {lab_wire.sym} 500 -220 0 0 {name=p52 sig_type=std_logic lab=vc2}
C {noconn.sym} 500 -220 0 0 {name=l5}
