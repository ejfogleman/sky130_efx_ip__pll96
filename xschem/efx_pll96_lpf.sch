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
00 ==> R = 40.46 kOhm
01 ==> R = 26.97 kOhm
11 ==> R = 20.23 kOhm} -70 -540 0 0 0.4 0.4 {}
T {vc2: sense-
only node} 250.2230369910357 -620 0 0 0.4 0.4 {}
N 190 -310 200 -310 {
lab=vdd}
N 220 -430 330 -430 {
lab=#net1}
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
N 390 -270 390 -260 {
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
N 360 -900 450 -900 {
lab=csc_b}
N 360 -880 390 -880 {
lab=gnd}
N 180 -820 390 -820 {
lab=vdd}
N 790 -820 970 -820 {
lab=vdd}
N 570 -680 570 -620 {
lab=#net5}
N 390 -430 390 -420 {
lab=vc2}
N 390 -360 390 -340 {
lab=#net6}
N 140 -360 180 -360 {
lab=vdd}
N 180 -390 180 -360 {
lab=vdd}
N 390 -430 720 -430 {
lab=vc2}
N 390 -200 390 -190 {
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
N 390 -820 570 -820 {
lab=vdd}
N 570 -910 600 -910 {
lab=rsc[1:0]}
N 840 -940 870 -940 {
lab=vdd}
N 840 -920 870 -920 {
lab=rsc_bb[1:0]}
N 840 -900 980 -900 {
lab=rsc_b[1:0]}
N 840 -880 870 -880 {
lab=gnd}
N 570 -820 790 -820 {
lab=vdd}
N 390 -190 810 -190 {
lab=#net1}
N 850 -220 870 -220 {
lab=rsc_bb[1]}
N 570 -980 570 -910 {
lab=rsc[1:0]}
N 540 -990 560 -990 {
lab=rsc[1]}
N 540 -970 560 -970 {
lab=rsc[0]}
N 970 -820 970 -740 {lab=vdd}
N 790 -820 790 -740 {lab=vdd}
N 570 -820 570 -740 {lab=vdd}
N 390 -820 390 -740 {lab=vdd}
N 390 -540 390 -430 {
lab=vc2}
N 700 -590 720 -590 {lab=csc_bb}
N 480 -620 570 -620 {lab=#net5}
N 570 -620 660 -620 {lab=#net5}
N 390 -560 660 -560 {lab=vc2}
N 390 -680 390 -560 {
lab=vc2}
N 320 -540 390 -540 {lab=vc2}
N 390 -560 390 -540 {
lab=vc2}
N 420 -590 440 -590 {lab=csc_b}
N 970 -680 970 -620 {
lab=#net7}
N 1100 -590 1120 -590 {lab=csc_bb}
N 880 -620 970 -620 {lab=#net7}
N 970 -620 1060 -620 {lab=#net7}
N 820 -590 840 -590 {lab=csc_b}
N 970 -560 1060 -560 {lab=vc}
N 790 -680 790 -560 {
lab=vc}
N 720 -640 720 -590 {lab=csc_bb}
N 1120 -640 1140 -640 {lab=csc_bb}
N 1120 -640 1120 -590 {lab=csc_bb}
N 720 -640 1120 -640 {lab=csc_bb}
N 820 -590 820 -540 {lab=csc_b}
N 420 -590 420 -540 {lab=csc_b}
N 820 -540 1140 -540 {lab=csc_b}
N 420 -540 820 -540 {lab=csc_b}
N 970 -560 970 -160 {lab=vc}
N 790 -560 970 -560 {lab=vc}
N 220 -160 970 -160 {
lab=vc}
N 390 -280 390 -270 {
lab=#net3}
N 720 -390 810 -390 {lab=vc2}
N 720 -330 810 -330 {lab=#net3}
N 740 -250 810 -250 {lab=vc2}
N 720 -330 720 -270 {lab=#net3}
N 630 -330 720 -330 {lab=#net3}
N 390 -270 720 -270 {lab=#net3}
N 720 -430 720 -390 {lab=vc2}
N 630 -390 720 -390 {lab=vc2}
N 720 -430 740 -430 {lab=vc2}
N 740 -430 740 -250 {lab=vc2}
N 630 -250 740 -250 {lab=vc2}
N 850 -360 870 -360 {lab=rsc_bb[0]}
N 570 -360 590 -360 {lab=rsc_b[0]}
N 570 -220 590 -220 {lab=rsc_b[1]}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {iopin.sym} 90 -160 0 1 {name=p1 lab=vc}
C {iopin.sym} 90 -820 0 1 {name=p2 lab=vdd}
C {iopin.sym} 90 -120 0 1 {name=p7 lab=gnd}
C {ipin.sym} 90 -910 0 0 {name=p5 lab=csc}
C {sky130_fd_pr/res_high_po_0p35.sym} 140 -310 0 1 {name=R7[5:0]
L=5.58
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {efx_pll96_dbuf.sym} 240 -910 0 0 {name=x2}
C {lab_pin.sym} 390 -940 0 1 {name=p10 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 390 -880 0 1 {name=p57 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 390 -920 0 1 {name=p58 sig_type=std_logic lab=csc_bb}
C {lab_pin.sym} 390 -900 0 1 {name=p59 sig_type=std_logic lab=csc_b}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 680 -590 0 1 {name=M1
W=1.08
L=0.15
body=gnd
nf=1
mult=10
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
L=5.58
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 220 -310 0 0 {name=R2
L=5.58
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 220 -390 0 0 {name=R3
L=5.58
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 390 -230 0 0 {name=R4
L=5.58
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 390 -310 0 0 {name=R5
L=5.58
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 390 -390 0 0 {name=R6
L=5.58
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {ipin.sym} 540 -970 0 0 {name=p8 lab=rsc[0]}
C {efx_pll96_dbuf.sym} 720 -910 0 0 {name=x1[1:0]}
C {lab_pin.sym} 870 -940 0 1 {name=p9 sig_type=std_logic lab=vdd}
C {lab_pin.sym} 870 -880 0 1 {name=p11 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 870 -920 0 1 {name=p12 sig_type=std_logic lab=rsc_bb[1:0]}
C {lab_pin.sym} 870 -900 0 1 {name=p13 sig_type=std_logic lab=rsc_b[1:0]}
C {lab_pin.sym} 870 -360 0 1 {name=p14 sig_type=std_logic lab=rsc_bb[0]}
C {lab_pin.sym} 870 -220 0 1 {name=p15 sig_type=std_logic lab=rsc_bb[1]}
C {ipin.sym} 540 -990 0 0 {name=p16 lab=rsc[1]}
C {lab_pin.sym} 570 -910 0 0 {name=p17 sig_type=std_logic lab=rsc[1:0]}
C {bus_connect_nolab.sym} 570 -980 0 1 {name=r7}
C {bus_connect_nolab.sym} 570 -960 0 1 {name=r8}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {opin.sym} 320 -540 0 1 {name=p18 lab=vc2}
C {noconn.sym} 450 -900 0 1 {name=l2}
C {noconn.sym} 980 -900 0 1 {name=l3[1:0]}
C {efx_pll96_lpf_unit.sym} 970 -710 0 0 {name=xc1b}
C {efx_pll96_lpf_unit.sym} 790 -710 0 0 {name=xc1a}
C {efx_pll96_lpf_unit.sym} 570 -710 0 0 {name=xc2b[9:0]}
C {efx_pll96_lpf_unit.sym} 390 -710 0 0 {name=xc2a[9:0]}
C {sky130_fd_pr/pfet3_01v8.sym} 460 -590 0 0 {name=M3
W=0.63
L=0.15
body=vdd
nf=1
mult=10
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 1080 -590 0 1 {name=M6
W=1.08
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
C {lab_pin.sym} 1140 -640 0 1 {name=p3 sig_type=std_logic lab=csc_bb}
C {sky130_fd_pr/pfet3_01v8.sym} 860 -590 0 0 {name=M7
W=0.63
L=0.15
body=vdd
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 1140 -540 0 1 {name=p4 sig_type=std_logic lab=csc_b}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 830 -220 0 1 {name=M2
W=1.08
L=0.15
body=gnd
nf=1
mult=10
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 610 -220 0 0 {name=M8
W=0.63
L=0.15
body=vdd
nf=1
mult=10
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 830 -360 0 1 {name=M4
W=1.08
L=0.15
body=gnd
nf=1
mult=10
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 610 -360 0 0 {name=M5
W=0.63
L=0.15
body=vdd
nf=1
mult=10
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 570 -360 0 0 {name=p6 sig_type=std_logic lab=rsc_b[0]}
C {lab_pin.sym} 570 -220 0 0 {name=p19 sig_type=std_logic lab=rsc_b[1]}
