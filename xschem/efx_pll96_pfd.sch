v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
T {parallel gates
for symmetric 
pull-up} 680 -440 0 0 0.2 0.2 {}
N 150 -580 180 -580 {lab=rst_b}
N 150 -260 180 -260 {lab=rst_b}
N 910 -640 980 -640 {lab=qa}
N 120 -600 180 -600 {lab=vdd}
N 120 -240 180 -240 {lab=vdd}
N 20 -620 180 -620 {lab=a}
N 20 -220 180 -220 {lab=b}
N 640 -480 680 -480 {lab=a_b}
N 360 -620 610 -620 {lab=qa0}
N 910 -200 980 -200 {lab=qb}
N 500 -460 520 -460 {lab=y_par}
N 500 -380 520 -380 {lab=y_par}
N 150 -420 150 -260 {lab=rst_b}
N 640 -400 660 -400 {lab=a_b}
N 360 -220 610 -220 {lab=qb0}
N 640 -440 660 -440 {lab=b_b}
N 640 -360 680 -360 {lab=b_b}
N 660 -400 680 -480 {lab=a_b}
N 660 -440 680 -360 {lab=b_b}
N 910 -660 940 -660 {lab=vdd}
N 910 -580 940 -580 {lab=gnd}
N 910 -180 940 -180 {lab=vdd}
N 910 -260 940 -260 {lab=gnd}
N 910 -620 980 -620 {lab=qa_b}
N 910 -220 980 -220 {lab=qb_b}
N 910 -600 1000 -600 {lab=a_b}
N 1000 -600 1000 -480 {lab=a_b}
N 910 -240 1000 -240 {lab=b_b}
N 1000 -360 1000 -240 {lab=b_b}
N 150 -420 200 -420 {
lab=rst_b}
N 150 -580 150 -420 {lab=rst_b}
N 500 -420 500 -380 {lab=y_par}
N 680 -480 1000 -480 {
lab=a_b}
N 680 -360 1000 -360 {
lab=b_b}
N 280 -420 300 -420 {
lab=#net1}
N 380 -420 400 -420 {
lab=#net2}
N 480 -420 500 -420 {
lab=y_par}
N 500 -460 500 -420 {lab=y_par}
C {sky130_efx_lvdig__nor2_2.sym} 580 -460 0 1 {name=x3 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {iopin.sym} 20 -150 0 1 {name=p1 lab=vdd}
C {iopin.sym} 20 -130 0 1 {name=p2 lab=gnd}
C {sky130_efx_lvdig__clkinv_1.sym} 240 -420 0 1 {name=x4 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {ipin.sym} 20 -620 0 0 {name=p3 lab=a}
C {lab_pin.sym} 120 -600 0 0 {name=p4 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 120 -240 0 0 {name=p5 sig_type=std_logic lab=vdd}
C {ipin.sym} 20 -220 0 0 {name=p6 lab=b}
C {opin.sym} 980 -640 0 0 {name=p7 lab=qa}
C {opin.sym} 980 -200 0 0 {name=p8 lab=qb}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {sky130_efx_lvdig__dfrtp_2.sym} 270 -600 0 0 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__  }
C {sky130_efx_lvdig__dfrtp_2.sym} 270 -240 2 1 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__  }
C {efx_pll96_diff_buf.sym} 760 -620 0 0 {name=x6}
C {efx_pll96_diff_buf.sym} 760 -220 2 1 {name=x7}
C {sky130_efx_lvdig__nor2_2.sym} 580 -380 2 0 {name=x8 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_pin.sym} 940 -660 0 1 {name=p9 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 940 -580 0 1 {name=p10 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 940 -180 0 1 {name=p11 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 940 -260 0 1 {name=p12 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 470 -620 0 0 {name=p13 sig_type=std_logic lab=qa0}
C {lab_wire.sym} 480 -220 0 0 {name=p14 sig_type=std_logic lab=qb0}
C {opin.sym} 980 -620 0 0 {name=p15 lab=qa_b}
C {opin.sym} 980 -220 0 0 {name=p16 lab=qb_b}
C {lab_wire.sym} 770 -480 0 0 {name=p17 sig_type=std_logic lab=a_b
}
C {lab_wire.sym} 770 -360 0 0 {name=p18 sig_type=std_logic lab=b_b}
C {lab_wire.sym} 190 -420 0 0 {name=p19 sig_type=std_logic lab=rst_b
}
C {sky130_efx_lvdig__dlygate4sd3_1.sym} 440 -420 0 1 {name=x10 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ 
}
C {sky130_efx_lvdig__dlygate4sd3_1.sym} 340 -420 0 1 {name=x5 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ 
}
C {lab_wire.sym} 500 -460 0 0 {name=p20 sig_type=std_logic lab=y_par
}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
