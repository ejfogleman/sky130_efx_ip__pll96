v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Initialize to (s[3:0])'
Count up to 4b1111
tc (terminal count) asserted on 4b1111
count halts on tc
assert ld (load) to reload count
tie tc (q output) to ld to free run

q asserted on en=0 or tc} 950 -1090 0 0 0.4 0.4 {}
N 480 -380 490 -380 {lab=en[0]}
N 490 -380 490 -290 {lab=en[0]}
N 340 -290 360 -290 {lab=#net1}
N 340 -320 340 -290 {lab=#net1}
N 720 -320 720 -270 {lab=#net1}
N 700 -270 720 -270 {lab=#net1}
N 480 -670 490 -670 {lab=en[1]}
N 490 -670 490 -580 {lab=en[1]}
N 340 -580 360 -580 {lab=#net2}
N 340 -610 340 -580 {lab=#net2}
N 720 -610 720 -560 {lab=#net2}
N 700 -560 720 -560 {lab=#net2}
N 510 -540 510 -250 {lab=clk}
N 480 -960 490 -960 {lab=en[2]}
N 490 -960 490 -870 {lab=en[2]}
N 340 -870 360 -870 {lab=#net3}
N 340 -900 340 -870 {lab=#net3}
N 720 -900 720 -850 {lab=#net3}
N 700 -850 720 -850 {lab=#net3}
N 780 -830 820 -830 {lab=q[2]}
N 510 -830 510 -540 {lab=clk}
N 480 -1250 490 -1250 {lab=#net4}
N 490 -1250 490 -1160 {lab=#net4}
N 340 -1160 360 -1160 {lab=#net5}
N 340 -1190 340 -1160 {lab=#net5}
N 720 -1190 720 -1140 {lab=#net5}
N 700 -1140 720 -1140 {lab=#net5}
N 700 -1120 840 -1120 {lab=q[3]}
N 510 -1120 510 -830 {lab=clk}
N 490 -290 520 -290 {lab=en[0]}
N 440 -270 520 -270 {lab=#net6}
N 340 -320 720 -320 {lab=#net1}
N 510 -250 520 -250 {lab=clk}
N 490 -580 520 -580 {lab=en[1]}
N 440 -560 520 -560 {lab=#net7}
N 340 -610 720 -610 {lab=#net2}
N 510 -540 520 -540 {lab=clk}
N 490 -870 520 -870 {lab=en[2]}
N 440 -850 520 -850 {lab=#net8}
N 340 -900 720 -900 {lab=#net3}
N 510 -830 520 -830 {lab=clk}
N 490 -1160 520 -1160 {lab=#net4}
N 440 -1140 520 -1140 {lab=#net9}
N 340 -1190 720 -1190 {lab=#net5}
N 510 -1120 520 -1120 {lab=clk}
N 510 -250 510 -170 {lab=clk}
N 20 -250 120 -250 {lab=s[0]}
N 800 -290 880 -290 {lab=q[1]}
N 820 -330 880 -330 {lab=q[2]}
N 840 -370 880 -370 {lab=q[3]}
N 800 -540 800 -290 {lab=q[1]}
N 820 -830 820 -330 {lab=q[2]}
N 840 -1120 840 -370 {lab=q[3]}
N 1340 -150 1360 -150 {lab=q}
N 1000 -310 1070 -310 {lab=tc}
N 740 -250 880 -250 {lab=q[0]}
N 490 -460 490 -380 {lab=en[0]}
N 760 -540 800 -540 {lab=q[1]}
N 700 -250 740 -250 {lab=q[0]}
N 260 -920 260 -760 {lab=en[1]}
N 490 -760 490 -670 {lab=en[1]}
N 700 -540 760 -540 {lab=q[1]}
N 490 -1050 490 -960 {lab=en[2]}
N 260 -1210 260 -1050 {lab=en[2]}
N 780 -1320 780 -830 {lab=q[2]}
N 700 -830 780 -830 {lab=q[2]}
N 260 -1320 260 -1250 {lab=q[2]}
N 230 -500 230 -400 {lab=ld_d2}
N 230 -400 360 -400 {lab=ld_d2}
N 230 -210 360 -210 {lab=ld_d2}
N 230 -790 360 -790 {lab=ld_d2}
N 230 -500 360 -500 {lab=ld_d2}
N 260 -630 320 -630 {lab=en[0]}
N 260 -460 490 -460 {lab=en[0]}
N 230 -1080 360 -1080 {lab=ld_d2}
N 260 -740 740 -740 {lab=q[0]}
N 260 -760 490 -760 {lab=en[1]}
N 260 -1030 760 -1030 {lab=q[1]}
N 260 -1050 490 -1050 {lab=en[2]}
N 260 -1320 780 -1320 {lab=q[2]}
N 230 -400 230 -210 {lab=ld_d2}
N 230 -1000 230 -790 {lab=ld_d2}
N 740 -740 740 -250 {lab=q[0]}
N 260 -740 260 -670 {lab=q[0]}
N 260 -630 260 -460 {lab=en[0]}
N 230 -710 230 -500 {lab=ld_d2}
N 260 -1030 260 -960 {lab=q[1]}
N 760 -1030 760 -540 {lab=q[1]}
N 260 -670 320 -670 {lab=q[0]}
N 230 -710 320 -710 {lab=ld_d2}
N 230 -790 230 -710 {lab=ld_d2}
N 230 -1000 320 -1000 {lab=ld_d2}
N 230 -1080 230 -1000 {lab=ld_d2}
N 260 -960 320 -960 {lab=q[1]}
N 260 -920 320 -920 {lab=en[1]}
N 260 -1210 320 -1210 {lab=en[2]}
N 260 -1250 320 -1250 {lab=q[2]}
N 230 -1290 230 -1080 {lab=ld_d2}
N 230 -1290 320 -1290 {lab=ld_d2}
N 20 -170 510 -170 {lab=clk}
N 20 -210 40 -210 {lab=ld}
N 120 -210 230 -210 {lab=ld_d2}
N 20 -540 120 -540 {lab=s[1]}
N 20 -830 120 -830 {lab=s[2]}
N 20 -1120 120 -1120 {lab=s[3]}
N 200 -250 360 -250 {lab=#net10}
N 200 -540 360 -540 {lab=#net11}
N 200 -830 360 -830 {lab=#net12}
N 200 -1120 360 -1120 {lab=#net13}
N 320 -360 360 -360 {lab=tc_b}
N 1200 -170 1200 -150 {lab=tc_b}
N 320 -360 320 -150 {lab=tc_b}
N 20 -130 1220 -130 {lab=en}
N 1200 -310 1200 -170 {lab=tc_b}
N 320 -150 1200 -150 {lab=tc_b}
N 1150 -310 1200 -310 {lab=tc_b}
N 1200 -170 1240 -170 {lab=tc_b}
C {title_efx.sym} 200 -30 0 0 {name=l1 author="ejfogleman"}
C {ipin.sym} 20 -540 0 0 {name=p6 lab=s[1]}
C {ipin.sym} 20 -830 0 0 {name=p7 lab=s[2]}
C {ipin.sym} 20 -1120 0 0 {name=p8 lab=s[3]}
C {ipin.sym} 20 -170 0 0 {name=p9 lab=clk}
C {opin.sym} 1360 -150 0 0 {name=p11 lab=q}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2026
* SPDX-License-Identifier: Apache-2.0"}
C {sky130_efx_lvdig__and4_2.sym} 940 -310 0 0 {name=x3 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {ipin.sym} 20 -210 0 0 {name=p25 lab=ld}
C {ipin.sym} 20 -250 0 0 {name=p26 lab=s[0]}
C {ipin.sym} 20 -130 0 0 {name=p31 lab=en}
C {sky130_efx_lvdig__inv_2.sym} 1110 -310 0 0 {name=x27 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__edfxbp_1.sym} 610 -270 2 1 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 400 -270 0 0 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 1190 -310 0 0 {name=p3 sig_type=std_logic lab=tc_b}
C {lab_wire.sym} 800 -250 0 0 {name=p10 sig_type=std_logic lab=q[0]}
C {sky130_efx_lvdig__edfxbp_1.sym} 610 -560 2 1 {name=x5 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 400 -560 0 0 {name=x6 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 290 -630 0 0 {name=p15 sig_type=std_logic lab=en[0]}
C {lab_wire.sym} 800 -540 0 0 {name=p19 sig_type=std_logic lab=q[1]}
C {sky130_efx_lvdig__edfxbp_1.sym} 610 -850 2 1 {name=x8 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 400 -850 0 0 {name=x9 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 290 -920 0 0 {name=p21 sig_type=std_logic lab=en[1]}
C {lab_wire.sym} 820 -830 0 0 {name=p29 sig_type=std_logic lab=q[2]}
C {sky130_efx_lvdig__edfxbp_1.sym} 610 -1140 2 1 {name=x11 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_1.sym} 400 -1140 0 0 {name=x12 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 280 -1210 0 0 {name=p33 sig_type=std_logic lab=en[2]}
C {lab_wire.sym} 820 -1120 0 0 {name=p37 sig_type=std_logic lab=q[3]}
C {sky130_efx_lvdig__or2_1.sym} 420 -380 2 1 {name=x4 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__inv_1.sym} 160 -250 0 0 {name=x16 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__a21o_1.sym} 400 -670 2 1 {name=x20 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__a21o_1.sym} 400 -960 2 1 {name=x7 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__a21o_1.sym} 400 -1250 2 1 {name=x10 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__buf_2.sym} 80 -210 0 0 {name=x13 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__inv_1.sym} 160 -540 0 0 {name=x17 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__inv_1.sym} 160 -830 0 0 {name=x18 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__inv_1.sym} 160 -1120 0 0 {name=x19 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {lab_wire.sym} 220 -210 0 0 {name=p1 sig_type=std_logic lab=ld_d2}
C {lab_wire.sym} 1040 -310 0 0 {name=p2 sig_type=std_logic lab=tc
}
C {sky130_efx_lvdig__nand2_2.sym} 1280 -150 0 0 {name=x14 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {iopin.sym} 20 -90 0 1 {name=p4 lab=vdd}
C {iopin.sym} 20 -70 0 1 {name=p5 lab=gnd}
