v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {mc = 1:  div2  0 1 0 1 0 1...
mc = 0:  div3  0 0 1 0 0 1...

Holds state when en == 0} 500 -180 0 0 0.4 0.4 {}
N 130 -320 150 -320 {lab=clk}
N 130 -320 130 -260 {lab=clk}
N 640 -320 660 -320 {lab=clk}
N 640 -320 640 -260 {lab=clk}
N 350 -320 400 -320 {lab=q1}
N 560 -360 580 -360 {lab=d2}
N 580 -360 580 -340 {lab=d2}
N 580 -340 660 -340 {lab=d2}
N 130 -440 130 -340 {lab=q2_b}
N 130 -340 150 -340 {lab=q2_b}
N 370 -440 870 -440 {lab=q2_b}
N 370 -400 400 -400 {lab=q2_b}
N 370 -440 370 -400 {lab=q2_b}
N 130 -440 370 -440 {lab=q2_b}
N 370 -360 400 -360 {lab=mc}
N 370 -360 370 -190 {lab=mc}
N 130 -260 640 -260 {lab=clk}
N 50 -260 130 -260 {lab=clk}
N 40 -190 370 -190 {lab=mc}
N 110 -360 150 -360 {lab=en}
N 110 -460 110 -360 {lab=en}
N 50 -360 110 -360 {lab=en}
N 110 -460 640 -460 {lab=en}
N 640 -460 640 -360 {lab=en}
N 640 -360 660 -360 {lab=en}
N 840 -340 870 -340 {lab=q2_b}
N 870 -440 870 -340 {lab=q2_b}
N 840 -320 870 -320 {lab=q2}
N 330 -320 350 -320 {lab=q1}
N 870 -320 870 -210 {lab=q2}
N 870 -210 880 -210 {lab=q2}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {sky130_efx_lvdig__o21a_1.sym} 480 -360 2 1 {name=x3 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ 
}
C {ipin.sym} 50 -260 0 0 {name=p1 lab=clk}
C {ipin.sym} 50 -190 0 0 {name=p2 lab=mc}
C {opin.sym} 880 -210 0 0 {name=p3 lab=q2}
C {lab_wire.sym} 360 -320 0 0 {name=p4 sig_type=std_logic lab=q1}
C {lab_wire.sym} 620 -340 0 0 {name=p5 sig_type=std_logic lab=d2}
C {iopin.sym} 40 -150 0 1 {name=p6 lab=vdd}
C {iopin.sym} 40 -130 0 1 {name=p7 lab=gnd}
C {ipin.sym} 50 -360 0 0 {name=p8 lab=en}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2026 
* SPDX-License-Identifier: Apache-2.0"}
C {sky130_efx_lvdig__edfxtp_1.sym} 240 -340 2 1 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__edfxbp_1.sym} 750 -340 2 1 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 850 -440 0 1 {name=p10 sig_type=std_logic lab=q2_b}
