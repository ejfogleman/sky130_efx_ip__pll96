v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Divide by factors of 2 or 3
depending on each stage's mc

mc
1 ==> div2
0 ==> div3

pdiv p[3:0] en[3:0]
24 ==> 0111, 1111
16 ==> 1111, 1111
12 ==> x011, 0111
08 ==> x111, 0111
06 ==> xx01, 0011
04 ==> xx11, 0011
03 ==> xxx0, 0001
02 ==> xxx1, 0001} 1130 -870 0 0 0.4 0.4 {}
N 1250 -350 1290 -350 {
lab=q}
N 260 -250 280 -250 {lab=clk}
N 580 -290 610 -290 {lab=vdd}
N 580 -250 610 -250 {lab=gnd}
N 220 -270 220 -220 {lab=p[0]}
N 220 -270 280 -270 {lab=p[0]}
N 260 -450 280 -450 {lab=clk}
N 260 -450 260 -250 {lab=clk}
N 580 -490 610 -490 {lab=vdd}
N 580 -450 610 -450 {lab=gnd}
N 220 -470 220 -420 {lab=p[1]}
N 220 -470 280 -470 {lab=p[1]}
N 260 -640 280 -640 {lab=clk}
N 580 -680 610 -680 {lab=vdd}
N 580 -640 610 -640 {lab=gnd}
N 220 -660 220 -610 {lab=p[2]}
N 220 -660 280 -660 {lab=p[2]}
N 580 -850 850 -850 {lab=q3}
N 260 -830 280 -830 {lab=clk}
N 260 -640 260 -450 {lab=clk}
N 580 -870 610 -870 {lab=vdd}
N 580 -830 610 -830 {lab=gnd}
N 200 -870 280 -870 {lab=#net1}
N 220 -850 220 -800 {lab=p[3]}
N 220 -850 280 -850 {lab=p[3]}
N 60 -640 80 -640 {lab=#net2}
N 60 -640 60 -590 {lab=#net2}
N 220 -590 220 -490 {lab=#net2}
N 220 -490 280 -490 {lab=#net2}
N 0 -420 220 -420 {lab=p[1]}
N 0 -610 220 -610 {lab=p[2]}
N 0 -800 220 -800 {lab=p[3]}
N 0 -220 220 -220 {lab=p[0]}
N 80 -290 280 -290 {lab=en[0]}
N 40 -680 80 -680 {lab=q1}
N 40 -570 670 -570 {lab=q1}
N 580 -470 670 -470 {lab=q1}
N 60 -830 80 -830 {lab=#net3}
N 260 -830 260 -640 {lab=clk}
N 60 -830 60 -780 {lab=#net3}
N 220 -780 220 -680 {lab=#net3}
N 220 -680 280 -680 {lab=#net3}
N 40 -870 80 -870 {lab=q2}
N 40 -760 670 -760 {lab=q2}
N 580 -660 670 -660 {lab=q2}
N 670 -760 670 -660 {lab=q2}
N 40 -870 40 -760 {lab=q2}
N 670 -570 670 -470 {lab=q1}
N 40 -680 40 -570 {lab=q1}
N 0 -160 260 -160 {lab=clk}
N 260 -250 260 -160 {lab=clk}
N 40 -370 670 -370 {lab=q0}
N 40 -470 40 -370 {lab=q0}
N 580 -270 670 -270 {lab=q0}
N 40 -470 80 -470 {lab=q0}
N 0 -720 730 -720 {lab=en[2]}
N 60 -590 220 -590 {lab=#net2}
N 60 -780 220 -780 {lab=#net3}
N 200 -490 220 -490 {lab=#net2}
N 200 -680 220 -680 {lab=#net3}
N 810 -890 850 -890 {lab=#net4}
N 810 -700 850 -700 {lab=#net5}
N 810 -510 850 -510 {lab=#net6}
N 810 -310 850 -310 {lab=#net7}
N 730 -910 730 -890 {lab=en[3]}
N 0 -910 730 -910 {lab=en[3]}
N 730 -720 730 -700 {lab=en[2]}
N 80 -530 730 -530 {lab=en[1]}
N 730 -530 730 -510 {lab=en[1]}
N 80 -530 80 -510 {lab=en[1]}
N 0 -510 80 -510 {lab=en[1]}
N 80 -330 730 -330 {lab=en[0]}
N 730 -330 730 -310 {lab=en[0]}
N 670 -270 850 -270 {lab=q0}
N 670 -370 670 -270 {lab=q0}
N 80 -330 80 -290 {lab=en[0]}
N 0 -290 80 -290 {lab=en[0]}
N 670 -470 850 -470 {lab=q1}
N 670 -660 850 -660 {lab=q2}
N 970 -290 1130 -290 {lab=q0_or_dis}
N 970 -490 1010 -490 {lab=q1_or_dis}
N 1010 -490 1010 -330 {lab=q1_or_dis}
N 1010 -330 1130 -330 {lab=q1_or_dis}
N 970 -680 1050 -680 {lab=q2_or_dis}
N 1050 -680 1050 -370 {lab=q2_or_dis}
N 1050 -370 1130 -370 {lab=q2_or_dis}
N 1090 -410 1130 -410 {lab=q3_or_dis}
N 970 -870 1090 -870 {lab=q3_or_dis}
N 1090 -870 1090 -410 {lab=q3_or_dis}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {iopin.sym} 0 -120 0 1 {name=p1 lab=vdd}
C {iopin.sym} 0 -100 0 1 {name=p2 lab=gnd}
C {ipin.sym} 0 -160 0 0 {name=p3 lab=clk}
C {ipin.sym} 0 -420 0 0 {name=p15 lab=p[1]}
C {ipin.sym} 0 -610 0 0 {name=p16 lab=p[2]}
C {ipin.sym} 0 -800 0 0 {name=p17 lab=p[3]}
C {ipin.sym} 0 -910 0 0 {name=p18 lab=en[3]}
C {ipin.sym} 0 -720 0 0 {name=p19 lab=en[2]}
C {opin.sym} 1290 -350 0 0 {name=p22 lab=q}
C {lab_wire.sym} 680 -270 0 1 {name=p23 sig_type=std_logic lab=q0}
C {lab_wire.sym} 680 -470 0 1 {name=p24 sig_type=std_logic lab=q1}
C {lab_wire.sym} 680 -660 0 1 {name=p25 sig_type=std_logic lab=q2}
C {lab_wire.sym} 680 -850 0 1 {name=p26 sig_type=std_logic lab=q3}
C {ipin.sym} 0 -510 0 0 {name=p13 lab=en[1]}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {efx_pll96_sdiv23.sym} 430 -270 0 0 {name=x5}
C {ipin.sym} 0 -220 0 0 {name=p21 lab=p[0]}
C {lab_pin.sym} 610 -290 0 1 {name=p28 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 610 -250 0 1 {name=p29 sig_type=std_logic lab=gnd}
C {efx_pll96_sdiv23.sym} 430 -470 0 0 {name=x8}
C {lab_pin.sym} 610 -490 0 1 {name=p31 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 610 -450 0 1 {name=p32 sig_type=std_logic lab=gnd}
C {sky130_efx_lvdig__and2_1.sym} 140 -490 2 1 {name=x9 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {efx_pll96_sdiv23.sym} 430 -660 0 0 {name=x10}
C {lab_pin.sym} 610 -680 0 1 {name=p34 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 610 -640 0 1 {name=p35 sig_type=std_logic lab=gnd}
C {sky130_efx_lvdig__and3_1.sym} 140 -680 2 1 {name=x11 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {efx_pll96_sdiv23.sym} 430 -850 0 0 {name=x12}
C {lab_pin.sym} 610 -870 0 1 {name=p37 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 610 -830 0 1 {name=p38 sig_type=std_logic lab=gnd}
C {ipin.sym} 0 -290 0 0 {name=p30 lab=en[0]}
C {sky130_efx_lvdig__and3_1.sym} 140 -870 2 1 {name=x7 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__or2_1.sym} 910 -870 2 1 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__inv_1.sym} 770 -890 2 1 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__or2_1.sym} 910 -680 2 1 {name=x3 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__inv_1.sym} 770 -700 2 1 {name=x13 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__or2_1.sym} 910 -490 2 1 {name=x14 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__inv_1.sym} 770 -510 2 1 {name=x15 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__or2_1.sym} 910 -290 2 1 {name=x16 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__inv_1.sym} 770 -310 2 1 {name=x17 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {sky130_efx_lvdig__and4_2.sym} 1190 -350 2 1 {name=x18 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__}
C {lab_wire.sym} 980 -290 0 1 {name=p4 sig_type=std_logic lab=q0_or_dis}
C {lab_wire.sym} 980 -490 0 1 {name=p5 sig_type=std_logic lab=q1_or_dis}
C {lab_wire.sym} 980 -680 0 1 {name=p6 sig_type=std_logic lab=q2_or_dis}
C {lab_wire.sym} 980 -870 0 1 {name=p7 sig_type=std_logic lab=q3_or_dis}
