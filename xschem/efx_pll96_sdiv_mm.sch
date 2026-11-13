v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {pdiv p[3:0] en[3:0]
24 ==> 0111, 1111
16 ==> 1111, 1111
12 ==> x011, 0111
08 ==> x111, 0111
06 ==> xx01, 0011
04 ==> xx11, 0011
03 ==> xxx0, 0001
02 ==> xxx1, 0001} 1080 -400 0 0 0.3 0.3 {}
T {mc == 1:  div2
mc == 0:  div3} 210 -510 0 0 0.3 0.3 {}
T {sdiv s[3:0]
01 ==> 0001
02 ==> 0010
03 ==> 0011
04 ==> 0100
05 ==> 0101
06 ==> 0110
07 ==> 0111
08 ==> 1000
} -110 -470 0 0 0.3 0.3 {}
T {Overall divisor = N*P + S, where:
N = 2
P = \{2, 3, 4, 6, 8, 12, 16, 24\} (static)
S = \{1, 2, ... P-1\} (may update when q == 1)} 870 -210 0 0 0.3 0.3 {}
T {Retime q to vco clk} 1060 -600 0 0 0.3 0.3 {}
N 450 -570 480 -570 {lab=vdd}
N 450 -530 480 -530 {lab=gnd}
N 940 -470 970 -470 {lab=vdd}
N 940 -310 970 -310 {lab=gnd}
N 120 -270 150 -270 {lab=gnd}
N 120 -390 150 -390 {lab=vdd}
N 1230 -540 1260 -540 {
lab=q}
N 940 -390 1040 -390 {
lab=ld}
N 120 -570 150 -570 {lab=vdd}
N 450 -550 530 -550 {
lab=clk_div23}
N 450 -390 530 -390 {
lab=clk_div23}
N -30 -530 150 -530 {
lab=clk}
N 50 -550 150 -550 {
lab=mc}
N 450 -370 470 -370 {
lab=s[3]}
N 450 -350 470 -350 {
lab=s[2]}
N 450 -330 470 -330 {
lab=s[1]}
N 450 -310 470 -310 {
lab=s[0]}
N 620 -450 640 -450 {
lab=p[3]}
N 620 -430 640 -430 {
lab=p[2]}
N 620 -410 640 -410 {
lab=p[1]}
N 620 -390 640 -390 {
lab=p[0]}
N 620 -370 640 -370 {
lab=en[3]}
N 620 -350 640 -350 {
lab=en[2]}
N 620 -330 640 -330 {
lab=en[1]}
N 530 -550 530 -390 {
lab=clk_div23}
N -20 -230 470 -230 {
lab=ens}
N 450 -270 470 -270 {
lab=ens}
N 470 -270 470 -230 {
lab=ens}
N 1040 -390 1040 -290 {
lab=ld}
N 530 -290 1040 -290 {
lab=ld}
N 620 -310 640 -310 {
lab=en[0]}
N 450 -290 530 -290 {lab=ld}
N 50 -550 50 -330 {
lab=mc}
N 50 -330 150 -330 {
lab=mc}
N 30 -600 30 -530 {lab=clk}
N 30 -600 570 -600 {lab=clk}
N 570 -540 1050 -540 {lab=clk}
N 570 -600 570 -540 {lab=clk}
N 1040 -520 1050 -520 {lab=ld}
N 1040 -520 1040 -390 {lab=ld}
N 530 -470 640 -470 {lab=clk_div23}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {iopin.sym} -20 -120 0 1 {name=p2 lab=gnd}
C {ipin.sym} -30 -530 0 0 {name=p3 lab=clk}
C {opin.sym} 1260 -540 0 0 {name=p22 lab=q}
C {iopin.sym} -20 -140 0 1 {name=p1 lab=vdd}
C {efx_pll96_sdiv23.sym} 300 -550 0 0 {name=xn}
C {efx_pll96_sdiv_p.sym} 790 -390 0 0 {name=xp}
C {lab_pin.sym} 480 -570 0 1 {name=p5 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 480 -530 0 1 {name=p6 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 970 -470 0 1 {name=p4 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 970 -310 0 1 {name=p7 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 120 -270 0 0 {name=p8 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 120 -390 0 0 {name=p9 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 120 -570 0 0 {name=p10 sig_type=std_logic lab=vdd}
C {ipin.sym} 620 -450 0 0 {name=p12 lab=p[3]}
C {ipin.sym} 620 -430 0 0 {name=p13 lab=p[2]}
C {ipin.sym} 620 -410 0 0 {name=p14 lab=p[1]}
C {ipin.sym} 620 -390 0 0 {name=p15 lab=p[0]}
C {ipin.sym} 620 -370 0 0 {name=p16 lab=en[3]}
C {ipin.sym} 620 -350 0 0 {name=p17 lab=en[2]}
C {ipin.sym} 620 -330 0 0 {name=p18 lab=en[1]}
C {ipin.sym} 470 -310 0 1 {name=p19 lab=s[0]}
C {ipin.sym} 470 -330 0 1 {name=p20 lab=s[1]}
C {ipin.sym} 470 -350 0 1 {name=p21 lab=s[2]}
C {ipin.sym} 470 -370 0 1 {name=p23 lab=s[3]}
C {lab_wire.sym} 620 -470 0 0 {name=p24 sig_type=std_logic lab=clk_div23}
C {ipin.sym} -20 -230 0 0 {name=p25 lab=ens}
C {ipin.sym} 620 -310 0 0 {name=p26 lab=en[0]}
C {efx_pll96_sdiv_s.sym} 300 -330 0 1 {name=xs}
C {lab_wire.sym} 120 -330 0 0 {name=p11 sig_type=std_logic lab=mc}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2026 
* SPDX-License-Identifier: Apache-2.0"}
C {sky130_efx_lvdig__dfxtp_2.sym} 1140 -530 0 0 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {lab_wire.sym} 1010 -390 0 0 {name=p27 sig_type=std_logic lab=ld}
