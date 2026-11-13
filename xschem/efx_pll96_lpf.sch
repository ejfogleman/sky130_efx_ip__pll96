v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {8 fF/um^2

C1, C2 Cap scaling
csc:
1 ==> 3.6 pF, 36 pF
0 ==> 1.8 pF, 18 pF } -59.77696300896434 -760 0 0 0.4 0.4 {}
T {Resistor scaling
rsc[1],rsc[0]:
00 ==> R = 69.06 kOhm
01 ==> R = 46.04 kOhm
11 ==> R = 35.43 kOhm} 820 -350 0 0 0.4 0.4 {}
T {vc2: sense-
only node} 250.2230369910357 -620 0 0 0.4 0.4 {}
N 190 -310 200 -310 {
lab=vdd}
N 330 -720 360 -720 {
lab=vdd}
N 330 -820 330 -720 {
lab=vdd}
N 420 -720 450 -720 {
lab=vdd}
N 450 -820 510 -820 {
lab=vdd}
N 220 -430 330 -430 {
lab=#net1}
N 910 -720 940 -720 {
lab=vdd}
N 910 -820 910 -720 {
lab=vdd}
N 1000 -720 1030 -720 {
lab=vdd}
N 1030 -820 1030 -720 {
lab=vdd}
N 510 -720 540 -720 {
lab=vdd}
N 510 -820 510 -720 {
lab=vdd}
N 600 -720 630 -720 {
lab=vdd}
N 630 -820 630 -720 {
lab=vdd}
N 630 -820 730 -820 {
lab=vdd}
N 730 -720 760 -720 {
lab=vdd}
N 730 -820 730 -720 {
lab=vdd}
N 820 -720 850 -720 {
lab=vdd}
N 850 -820 850 -720 {
lab=vdd}
N 180 -360 180 -310 {
lab=vdd}
N 80 -820 180 -820 {
lab=vdd}
N 220 -360 220 -340 {
lab=#net2}
N 180 -390 200 -390 {
lab=vdd}
N 350 -310 370 -310 {
lab=vdd}
N 350 -390 350 -310 {
lab=vdd}
N 350 -390 370 -390 {
lab=vdd}
N 180 -460 180 -390 {
lab=vdd}
N 160 -310 180 -310 {
lab=vdd}
N 140 -360 140 -340 {
lab=vdd}
N 140 -280 140 -260 {
lab=vdd}
N 140 -260 180 -260 {
lab=vdd}
N 180 -300 180 -260 {
lab=vdd}
N 180 -300 190 -300 {
lab=vdd}
N 190 -310 190 -300 {
lab=vdd}
N 180 -310 190 -310 {
lab=vdd}
N 350 -310 350 -230 {
lab=vdd}
N 350 -230 370 -230 {
lab=vdd}
N 330 -190 390 -190 {
lab=#net1}
N 390 -280 390 -270 {
lab=#net3}
N 220 -280 220 -260 {
lab=#net4}
N 220 -200 220 -160 {
lab=vc}
N 90 -160 220 -160 {
lab=vc}
N 180 -260 180 -230 {
lab=vdd}
N 180 -230 200 -230 {
lab=vdd}
N 90 -910 120 -910 {
lab=csc}
N 360 -940 390 -940 {
lab=vdd}
N 360 -920 390 -920 {
lab=csc_bb}
N 360 -900 390 -900 {
lab=csc_b}
N 360 -880 390 -880 {
lab=gnd}
N 180 -820 330 -820 {
lab=vdd}
N 730 -820 850 -820 {
lab=vdd}
N 910 -820 1030 -820 {
lab=vdd}
N 570 -680 570 -620 {
lab=#net5}
N 570 -560 570 -540 {
lab=vc2}
N 390 -540 570 -540 {
lab=vc2}
N 390 -680 390 -540 {
lab=vc2}
N 390 -430 390 -420 {
lab=vc2}
N 390 -540 390 -430 {
lab=vc2}
N 390 -360 390 -340 {
lab=#net6}
N 390 -270 570 -270 {
lab=#net3}
N 570 -360 570 -270 {
lab=#net3}
N 630 -430 630 -340 {
lab=vc2}
N 390 -270 390 -260 {
lab=#net3}
N 140 -360 180 -360 {
lab=vdd}
N 180 -390 180 -360 {
lab=vdd}
N 570 -430 570 -420 {
lab=vc2}
N 390 -430 570 -430 {
lab=vc2}
N 390 -200 390 -190 {
lab=#net1}
N 630 -280 630 -190 {
lab=#net1}
N 220 -430 220 -420 {
lab=#net1}
N 330 -430 330 -190 {
lab=#net1}
N 180 -460 350 -460 {
lab=vdd}
N 180 -820 180 -460 {
lab=vdd}
N 350 -460 350 -390 {
lab=vdd}
N 450 -820 450 -720 {
lab=vdd}
N 330 -820 450 -820 {
lab=vdd}
N 850 -820 910 -820 {
lab=vdd}
N 790 -540 790 -160 {
lab=vc}
N 220 -160 790 -160 {
lab=vc}
N 970 -680 970 -620 {
lab=#net7}
N 970 -560 970 -540 {
lab=vc}
N 790 -540 970 -540 {
lab=vc}
N 790 -680 790 -540 {
lab=vc}
N 1010 -590 1050 -590 {
lab=csc_bb}
N 570 -910 600 -910 {
lab=rsc[1:0]}
N 840 -940 870 -940 {
lab=vdd}
N 840 -920 870 -920 {
lab=rsc_bb[1:0]}
N 840 -900 870 -900 {
lab=rsc_b[1:0]}
N 840 -880 870 -880 {
lab=gnd}
N 510 -820 630 -820 {
lab=vdd}
N 610 -590 630 -590 {
lab=csc_bb}
N 610 -390 690 -390 {
lab=rsc_bb[0]}
N 570 -430 630 -430 {
lab=vc2}
N 390 -190 630 -190 {
lab=#net1}
N 670 -310 690 -310 {
lab=rsc_bb[1]}
N 570 -980 570 -910 {
lab=rsc[1:0]}
N 540 -990 560 -990 {
lab=rsc[1]}
N 540 -970 560 -970 {
lab=rsc[0]}
N 380 -550 390 -550 {lab=vc2}
N 380 -550 380 -540 {lab=vc2}
N 320 -540 380 -540 {lab=vc2}
N 390 -900 450 -900 {lab=csc_b}
N 870 -900 980 -900 {lab=rsc_b[1:0]}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {iopin.sym} 90 -160 0 1 {name=p1 lab=vc}
C {iopin.sym} 90 -820 0 1 {name=p2 lab=vdd}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 790 -700 3 0 {name=MPC2[3:0]
W=6
L=11
body=vdd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 570 -700 3 0 {name=MPC2[79:40]
W=6
L=11
body=vdd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {iopin.sym} 90 -120 0 1 {name=p7 lab=gnd}
C {ipin.sym} 90 -910 0 0 {name=p5 lab=csc}
C {sky130_fd_pr/res_high_po_0p35.sym} 140 -310 0 1 {name=R7[5:0]
L=9.9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 970 -700 3 0 {name=MPC1[4:7]
W=6
L=11
body=vdd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {efx_pll96_dbuf.sym} 240 -910 0 0 {name=x2}
C {lab_pin.sym} 390 -940 0 1 {name=p10 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 390 -880 0 1 {name=p57 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 390 -920 0 1 {name=p58 sig_type=std_logic lab=csc_bb}
C {lab_pin.sym} 390 -900 0 1 {name=p59 sig_type=std_logic lab=csc_b}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 590 -590 0 1 {name=M1
W=10
L=0.15
body=gnd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 990 -590 0 1 {name=M2
W=10
L=0.15
body=gnd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/res_high_po_0p35.sym} 220 -230 0 0 {name=R1
L=9.9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 220 -310 0 0 {name=R2
L=9.9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 220 -390 0 0 {name=R3
L=9.9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 390 -230 0 0 {name=R4
L=9.9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 390 -310 0 0 {name=R5
L=9.9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 390 -390 0 0 {name=R6
L=9.9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 590 -390 0 1 {name=M4
W=10
L=0.15
body=gnd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 650 -310 0 1 {name=M5
W=10
L=0.15
body=gnd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} 630 -590 0 1 {name=p4 sig_type=std_logic lab=csc_bb}
C {lab_pin.sym} 1050 -590 0 1 {name=p6 sig_type=std_logic lab=csc_bb}
C {ipin.sym} 540 -970 0 0 {name=p8 lab=rsc[0]}
C {efx_pll96_dbuf.sym} 720 -910 0 0 {name=x1[1:0]}
C {lab_pin.sym} 870 -940 0 1 {name=p9 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 870 -880 0 1 {name=p11 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 870 -920 0 1 {name=p12 sig_type=std_logic lab=rsc_bb[1:0]}
C {lab_pin.sym} 870 -900 0 1 {name=p13 sig_type=std_logic lab=rsc_b[1:0]}
C {lab_pin.sym} 690 -390 0 1 {name=p14 sig_type=std_logic lab=rsc_bb[0]}
C {lab_pin.sym} 690 -310 0 1 {name=p15 sig_type=std_logic lab=rsc_bb[1]}
C {ipin.sym} 540 -990 0 0 {name=p16 lab=rsc[1]}
C {lab_pin.sym} 570 -910 0 0 {name=p17 sig_type=std_logic lab=rsc[1:0]}
C {bus_connect_nolab.sym} 570 -980 0 1 {name=r7}
C {bus_connect_nolab.sym} 570 -960 0 1 {name=r8}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 390 -700 3 0 {name=MPC3[39:0]
W=6
L=11
body=vdd
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {opin.sym} 320 -540 0 1 {name=p18 lab=vc2}
C {noconn.sym} 450 -900 0 1 {name=l2}
C {noconn.sym} 980 -900 0 1 {name=l3[1:0]}
