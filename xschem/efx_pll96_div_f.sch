v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Initialize to (count-1)
Count down to 5b00000
tc (terminal count) asserted on 5b00000} 830 -20 0 0 0.4 0.4 {}
T {Detect 5b00001 
Pipelined by one cycle
ld asserted on 5b00000} 890 -1130 0 0 0.4 0.4 {}
T {AND q_b to 
eliminate
q=0b00001 + ld=1
stuck state} 810 -830 0 0 0.4 0.4 {}
N 0 -310 20 -310 {lab=q_b[0]}
N 0 -340 0 -310 {lab=q_b[0]}
N 0 -600 20 -600 {lab=q_b[1]}
N 0 -630 0 -600 {lab=q_b[1]}
N 380 -630 380 -580 {lab=q_b[1]}
N 360 -580 380 -580 {lab=q_b[1]}
N 130 -270 130 -150 {lab=clk_bb}
N 0 -890 20 -890 {lab=q_b[2]}
N 0 -920 0 -890 {lab=q_b[2]}
N 380 -920 380 -870 {lab=q_b[2]}
N 130 -560 130 -270 {lab=clk_bb}
N 150 -1270 150 -1180 {lab=t[3]}
N 0 -1180 20 -1180 {lab=q_b[3]}
N 0 -1210 0 -1180 {lab=q_b[3]}
N 380 -1210 380 -1160 {lab=q_b[3]}
N 360 -1160 380 -1160 {lab=q_b[3]}
N 100 -290 180 -290 {lab=#net1}
N 150 -600 180 -600 {lab=q_b[0]}
N 100 -580 180 -580 {lab=#net2}
N 0 -630 380 -630 {lab=q_b[1]}
N 150 -890 180 -890 {lab=t[2]}
N 100 -870 180 -870 {lab=#net3}
N 0 -920 380 -920 {lab=q_b[2]}
N 150 -1180 180 -1180 {lab=t[3]}
N 100 -1160 180 -1160 {lab=#net4}
N 0 -1210 380 -1210 {lab=q_b[3]}
N -30 -230 20 -230 {lab=ld}
N 0 -1470 20 -1470 {lab=q_b[4]}
N 0 -1500 0 -1470 {lab=q_b[4]}
N 380 -1500 380 -1450 {lab=q_b[4]}
N 360 -1450 380 -1450 {lab=q_b[4]}
N 150 -1470 180 -1470 {lab=t[4]}
N 100 -1450 180 -1450 {lab=#net5}
N 0 -1500 380 -1500 {lab=q_b[4]}
N -30 -1390 20 -1390 {lab=ld}
N -30 -520 -30 -230 {lab=ld}
N 380 -290 470 -290 {lab=q_b[0]}
N 360 -870 380 -870 {lab=q_b[2]}
N 130 -270 180 -270 {lab=clk_bb}
N 130 -560 180 -560 {lab=clk_bb}
N 380 -580 500 -580 {lab=q_b[1]}
N 380 -870 530 -870 {lab=q_b[2]}
N 500 -1000 500 -580 {lab=q_b[1]}
N 380 -340 380 -290 {lab=q_b[0]}
N 0 -340 380 -340 {lab=q_b[0]}
N 360 -290 380 -290 {lab=q_b[0]}
N 150 -980 150 -890 {lab=t[2]}
N 150 -690 470 -690 {lab=q_b[0]}
N 150 -690 150 -600 {lab=q_b[0]}
N 150 -1270 250 -1270 {lab=t[3]}
N 150 -1560 150 -1470 {lab=t[4]}
N 150 -1560 250 -1560 {lab=t[4]}
N 470 -960 470 -690 {lab=q_b[0]}
N 370 -960 470 -960 {lab=q_b[0]}
N 470 -1230 470 -960 {lab=q_b[0]}
N 370 -1000 500 -1000 {lab=q_b[1]}
N 500 -1270 500 -1000 {lab=q_b[1]}
N 150 -980 250 -980 {lab=t[2]}
N 370 -1230 470 -1230 {lab=q_b[0]}
N 370 -1310 530 -1310 {lab=q_b[2]}
N 530 -1310 530 -870 {lab=q_b[2]}
N 370 -1270 500 -1270 {lab=q_b[1]}
N 150 -1340 150 -1270 {lab=t[3]}
N 150 -1340 440 -1340 {lab=t[3]}
N 440 -1540 440 -1340 {lab=t[3]}
N 370 -1540 440 -1540 {lab=t[3]}
N 370 -1580 560 -1580 {lab=q_b[3]}
N -30 -230 -30 -80 {lab=ld}
N 130 -850 130 -560 {lab=clk_bb}
N 130 -1430 180 -1430 {lab=clk_bb}
N 130 -1140 180 -1140 {lab=clk_bb}
N 130 -1430 130 -1140 {lab=clk_bb}
N 130 -850 180 -850 {lab=clk_bb}
N 130 -1140 130 -850 {lab=clk_bb}
N -150 -1430 20 -1430 {lab=c[4]}
N -150 -1140 20 -1140 {lab=c[3]}
N -30 -1100 20 -1100 {lab=ld}
N -30 -1390 -30 -1100 {lab=ld}
N -30 -810 20 -810 {lab=ld}
N -30 -1100 -30 -810 {lab=ld}
N -150 -850 20 -850 {lab=c[2]}
N -150 -560 20 -560 {lab=c[1]}
N -30 -520 20 -520 {lab=ld}
N -30 -810 -30 -520 {lab=ld}
N -150 -270 20 -270 {lab=c[0]}
N 1040 -150 1060 -150 {lab=clk_f}
N 130 -150 830 -150 {lab=clk_bb}
N 800 -170 830 -170 {lab=#net6}
N 380 -1160 560 -1160 {lab=q_b[3]}
N 560 -1580 560 -1160 {lab=q_b[3]}
N 360 -850 680 -850 {lab=q[2]}
N 360 -1140 650 -1140 {lab=q[3]}
N 360 -1430 620 -1430 {lab=q[4]}
N -150 -150 10 -150 {lab=clk}
N 360 -270 380 -270 {lab=#net7}
N 1000 -910 1040 -910 {lab=#net6}
N 720 -540 740 -540 {lab=#net8}
N 840 -1270 860 -1270 {lab=#net9}
N 620 -1430 620 -1310 {lab=q[4]}
N 650 -1270 650 -1140 {lab=q[3]}
N 680 -1230 680 -850 {lab=q[2]}
N 1040 -910 1040 -230 {lab=#net6}
N 800 -230 1040 -230 {lab=#net6}
N 800 -230 800 -170 {lab=#net6}
N 1040 -150 1040 -80 {lab=clk_f}
N 1010 -150 1040 -150 {lab=clk_f}
N 90 -150 130 -150 {lab=clk_bb}
N 470 -520 470 -290 {lab=q_b[0]}
N 620 -1310 720 -1310 {lab=q[4]}
N 650 -1270 720 -1270 {lab=q[3]}
N 680 -1230 720 -1230 {lab=q[2]}
N -30 -80 540 -80 {lab=ld}
N 770 -80 820 -80 {lab=ld_b}
N 860 -950 880 -950 {lab=#net9}
N 360 -560 600 -560 {lab=q[1]}
N 470 -520 600 -520 {lab=q_b[0]}
N 470 -690 470 -520 {lab=q_b[0]}
N 860 -1270 860 -950 {lab=#net9}
N 900 -80 1040 -80 {lab=clk_f}
N 740 -910 740 -540 {lab=#net8}
N 740 -910 880 -910 {lab=#net8}
N 770 -870 770 -80 {lab=ld_b}
N 770 -870 880 -870 {lab=ld_b}
N 620 -80 770 -80 {lab=ld_b}
C {title_efx.sym} 10 0 0 0 {name=l1 author="ejfogleman"}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2026 
* SPDX-License-Identifier: Apache-2.0"}
C {ipin.sym} -150 -560 0 0 {name=p6 lab=c[1]}
C {ipin.sym} -150 -850 0 0 {name=p7 lab=c[2]}
C {ipin.sym} -150 -1140 0 0 {name=p8 lab=c[3]}
C {ipin.sym} -150 -150 0 0 {name=p9 lab=clk}
C {opin.sym} 1060 -150 0 0 {name=p11 lab=clk_f}
C {ipin.sym} -150 -270 0 0 {name=p26 lab=c[0]}
C {sky130_efx_lvdig__dfxbp_2.sym} 270 -280 2 1 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 60 -290 0 0 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__edfxbp_1.sym} 270 -580 2 1 {name=x5 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 60 -580 0 0 {name=x6 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__edfxbp_1.sym} 270 -870 2 1 {name=x8 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 60 -870 0 0 {name=x9 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__edfxbp_1.sym} 270 -1160 2 1 {name=x11 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 60 -1160 0 0 {name=x12 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {iopin.sym} -150 -110 0 1 {name=p4 lab=vdd}
C {ipin.sym} -150 -1430 0 0 {name=p5 lab=c[4]}
C {sky130_efx_lvdig__edfxbp_1.sym} 270 -1450 2 1 {name=x15 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 60 -1450 0 0 {name=x21 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 360 -630 0 0 {name=p14 sig_type=std_logic lab=q_b[1]}
C {lab_wire.sym} 360 -920 0 0 {name=p15 sig_type=std_logic lab=q_b[2]}
C {sky130_efx_lvdig__and2_1.sym} 310 -980 0 1 {name=x7 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 470 -1220 3 0 {name=p13 sig_type=std_logic lab=q_b[0]}
C {lab_wire.sym} 500 -1220 3 0 {name=p16 sig_type=std_logic lab=q_b[1]}
C {lab_wire.sym} 530 -1220 3 0 {name=p17 sig_type=std_logic lab=q_b[2]}
C {lab_wire.sym} 560 -1220 3 0 {name=p18 sig_type=std_logic lab=q_b[3]}
C {sky130_efx_lvdig__and2_1.sym} 310 -1560 0 1 {name=x17 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__and3_1.sym} 310 -1270 0 1 {name=x10 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__dfxtp_2.sym} 920 -160 2 1 {name=x16 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {iopin.sym} -150 -90 0 1 {name=p1 lab=gnd}
C {sky130_efx_lvdig__clkbuf_2.sym} 50 -150 0 0 {name=x14 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {noconn.sym} 380 -270 0 1 {name=l6}
C {lab_wire.sym} 210 -980 0 0 {name=p12 sig_type=std_logic lab=t[2]}
C {lab_wire.sym} 210 -1270 0 0 {name=p19 sig_type=std_logic lab=t[3]}
C {lab_wire.sym} 200 -1560 0 0 {name=p21 sig_type=std_logic lab=t[4]}
C {sky130_efx_lvdig__nor2_2.sym} 660 -540 0 0 {name=x3 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__nor3_2.sym} 780 -1270 0 0 {name=x4 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__and3_1.sym} 940 -910 0 0 {name=x13 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 430 -560 0 0 {name=p2 sig_type=std_logic lab=q[1]}
C {lab_wire.sym} 430 -850 0 0 {name=p22 sig_type=std_logic lab=q[2]}
C {lab_wire.sym} 430 -1140 0 0 {name=p23 sig_type=std_logic lab=q[3]}
C {lab_wire.sym} 430 -1430 0 0 {name=p24 sig_type=std_logic lab=q[4]}
C {lab_wire.sym} 340 -1500 0 0 {name=p25 sig_type=std_logic lab=q_b[4]}
C {lab_wire.sym} 430 -290 0 0 {name=p20 sig_type=std_logic lab=q_b[0]}
C {sky130_efx_lvdig__inv_2.sym} 580 -80 0 1 {name=x18 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 450 -80 0 0 {name=p3 sig_type=std_logic lab=ld}
C {lab_wire.sym} 210 -150 0 0 {name=p27 sig_type=std_logic lab=clk_bb}
C {sky130_efx_lvdig__inv_1.sym} 860 -80 0 1 {name=x19 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 710 -80 0 0 {name=p28 sig_type=std_logic lab=ld_b}
