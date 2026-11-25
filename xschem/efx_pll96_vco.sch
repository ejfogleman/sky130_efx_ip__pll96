v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {100 uA} 460 -840 0 0 0.4 0.4 {}
T {Level shift to divider supply} 1120 -330 0 0 0.4 0.4 {}
T {34 uA (test only)} 960 -840 0 0 0.4 0.4 {hcenter=true}
T {34 uA (test only)} 970 -390 0 0 0.4 0.4 {hcenter=true}
T {Test mode to drive vco vc to fixed
levels with charge pump disabled
tst[2],tst[1],tst[0]
1,0,0 ==> 1.8 V
1,0,1 ==> 0.9 V (3/6)
0,0,1 ==> 0.771 V (3/7)
1,1,X ==> 0.72 V (2/5)
0,1,1 ==> 0.6 V (2/6) 
0,1,0 ==> 0 V
0,0,0 ==> NORMAL MODE} 1450 -780 0 0 0.4 0.4 {}
N 280 -240 340 -240 {lab=x0n}
N 280 -220 340 -220 {lab=x0p}
N 640 -200 640 -160 {lab=gnd_vco}
N 640 -240 700 -240 {lab=x1p}
N 640 -220 700 -220 {lab=x1n}
N 1000 -200 1000 -160 {lab=gnd_vco}
N -80 -240 -20 -240 {lab=x2n}
N -80 -350 -80 -240 {lab=x2n}
N -80 -220 -80 -110 {lab=x2p}
N -80 -220 -20 -220 {lab=x2p}
N 680 -310 1040 -310 {lab=vhi}
N 500 -810 500 -750 {lab=vdd_vco}
N 1430 -200 1430 -160 {lab=gnd_vco}
N 1410 -220 1520 -220 {lab=outn}
N 500 -650 500 -630 {
lab=rd3m[4:0]}
N 280 -200 280 -160 {lab=gnd_vco}
N 280 -160 640 -160 {
lab=gnd_vco}
N 1430 -360 1430 -260 {
lab=vdd}
N 1410 -240 1520 -240 {lab=outp}
N 20 -160 280 -160 {
lab=gnd_vco}
N 1050 -500 1050 -480 {
lab=#net1}
N 1050 -730 1050 -700 {
lab=#net2}
N 250 -930 270 -930 {
lab=tst[2:0]}
N 500 -580 500 -310 {
lab=vhi}
N 510 -960 550 -960 {
lab=vdd_vco}
N 510 -940 550 -940 {
lab=tst_bb[2:0]}
N 510 -920 550 -920 {
lab=tst_b[2:0]}
N 510 -900 550 -900 {
lab=gnd_vco}
N 500 -310 680 -310 {lab=vhi}
N 1050 -810 1050 -780 {
lab=vdd_vco}
N 890 -810 890 -790 {
lab=vdd_vco}
N 890 -430 890 -400 {
lab=gnd_vco}
N 1050 -420 1050 -400 {
lab=gnd_vco}
N 1430 -160 1470 -160 {
lab=gnd_vco}
N 1470 -400 1470 -160 {
lab=gnd_vco}
N 1410 -260 1430 -260 {lab=vdd}
N 1410 -200 1430 -200 {
lab=gnd_vco}
N 830 -760 850 -760 {
lab=tst_b[0]}
N 830 -450 850 -450 {
lab=tst_bb[1]}
N 990 -450 1010 -450 {
lab=tst_bb[0]}
N 990 -760 1010 -760 {
lab=tst_b[2]}
N 1050 -810 1390 -810 {
lab=vdd_vco}
N 1370 -600 1370 -560 {
lab=vc}
N 250 -1010 250 -930 {
lab=tst[2:0]}
N 230 -1020 240 -1020 {
lab=tst[2]}
N 230 -1000 240 -1000 {
lab=tst[1]}
N 230 -980 240 -980 {
lab=tst[0]}
N 730 -920 770 -920 {
lab=tst_b[1]}
N 730 -940 770 -940 {
lab=tst_bb[2]}
N 280 -260 320 -260 {lab=vhi}
N 320 -310 320 -260 {lab=vhi}
N 320 -310 500 -310 {lab=vhi}
N 640 -260 680 -260 {lab=vhi}
N 680 -310 680 -260 {lab=vhi}
N 1000 -260 1040 -260 {lab=vhi}
N 1040 -310 1040 -260 {lab=vhi}
N 280 -280 300 -280 {lab=vdd_vco}
N 300 -330 300 -280 {lab=vdd_vco}
N 640 -280 660 -280 {lab=vdd_vco}
N 660 -330 660 -280 {lab=vdd_vco}
N 300 -330 660 -330 {lab=vdd_vco}
N 1000 -280 1020 -280 {lab=vdd_vco}
N 1020 -330 1020 -280 {lab=vdd_vco}
N 890 -400 1050 -400 {
lab=gnd_vco}
N 730 -810 730 -790 {
lab=vdd_vco}
N 670 -760 690 -760 {
lab=en_bb}
N 500 -810 730 -810 {lab=vdd_vco}
N 890 -810 1050 -810 {lab=vdd_vco}
N 730 -810 890 -810 {
lab=vdd_vco}
N 730 -720 890 -720 {lab=#net3}
N 230 -1040 290 -1040 {lab=en}
N 370 -1040 550 -1040 {lab=en_bb}
N 660 -330 1020 -330 {lab=vdd_vco}
N 1370 -640 1370 -600 {
lab=vc}
N 1390 -670 1390 -530 {lab=vdd_vco}
N 910 -670 1390 -670 {lab=vdd_vco}
N 1390 -810 1390 -670 {lab=vdd_vco}
N 1070 -530 1390 -530 {lab=vdd_vco}
N 230 -750 230 -700 {lab=vdd_vco}
N 380 -670 500 -670 {lab=rd1m[4:0]}
N 500 -730 620 -730 {lab=rd2m[4:0]}
N 500 -650 620 -650 {lab=rd3m[4:0]}
N 620 -670 620 -650 {lab=rd3m[4:0]}
N 230 -700 230 -670 {lab=vdd_vco}
N 230 -670 260 -670 {lab=vdd_vco}
N 230 -700 600 -700 {lab=vdd_vco}
N 230 -750 500 -750 {lab=vdd_vco}
N 260 -730 380 -730 {lab=rd0m[4:0]}
N 170 -810 500 -810 {lab=vdd_vco}
N 170 -600 1370 -600 {lab=vc}
N 230 -670 230 -330 {lab=vdd_vco}
N 230 -330 300 -330 {lab=vdd_vco}
N 730 -730 730 -720 {lab=#net3}
N 890 -730 890 -720 {
lab=#net3}
N 730 -640 890 -640 {lab=#net3}
N 730 -720 730 -640 {lab=#net3}
N 890 -700 1050 -700 {lab=#net2}
N 1050 -640 1210 -640 {lab=#net4}
N 1210 -700 1370 -700 {lab=#net5}
N 1210 -500 1370 -500 {lab=#net6}
N 1050 -560 1210 -560 {lab=#net7}
N 890 -500 1050 -500 {lab=#net1}
N 890 -500 890 -480 {lab=#net1}
N 1060 -350 1060 -240 {lab=x2n}
N 1060 -220 1060 -110 {lab=x2p}
N 1000 -240 1060 -240 {lab=x2n}
N 1000 -220 1060 -220 {lab=x2p}
N -80 -350 1060 -350 {
lab=x2n}
N -80 -110 1060 -110 {
lab=x2p}
N 640 -160 1000 -160 {
lab=gnd_vco}
N 1000 -160 1430 -160 {
lab=gnd_vco}
N 1050 -400 1470 -400 {
lab=gnd_vco}
N 1060 -240 1110 -240 {lab=x2n}
N 1060 -220 1110 -220 {lab=x2p}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {efx_pll96_vco_dlycell.sym} 490 -230 0 0 {name=x1}
C {efx_pll96_vco_dlycell.sym} 850 -230 0 0 {name=x2}
C {efx_pll96_vco_dlycell.sym} 130 -230 0 0 {name=x0}
C {lab_wire.sym} 300 -240 0 1 {name=p4 sig_type=std_logic lab=x0n}
C {lab_wire.sym} 660 -220 0 1 {name=p5 sig_type=std_logic lab=x1n}
C {lab_wire.sym} 1020 -240 0 1 {name=p6 sig_type=std_logic lab=x2n}
C {lab_wire.sym} 300 -220 0 1 {name=p7 sig_type=std_logic lab=x0p}
C {lab_wire.sym} 660 -240 0 1 {name=p8 sig_type=std_logic lab=x1p}
C {lab_wire.sym} 1020 -220 0 1 {name=p10 sig_type=std_logic lab=x2p}
C {lab_wire.sym} 350 -310 0 1 {name=p2 sig_type=std_logic lab=vhi}
C {efx_pll96_vco_ls.sym} 1260 -230 0 0 {name=xls}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 480 -600 0 0 {name=MP1[4:0]
W=23.76
L=2.38
body=vdd_vco
nf=4
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {ipin.sym} 170 -600 0 0 {name=p11 lab=vc}
C {iopin.sym} 170 -810 0 1 {name=p12 lab=vdd_vco}
C {opin.sym} 1520 -240 0 0 {name=p13 lab=outp}
C {iopin.sym} 20 -160 0 1 {name=p18 lab=gnd_vco}
C {iopin.sym} 1430 -360 0 1 {name=p19 lab=vdd}
C {opin.sym} 1520 -220 0 0 {name=p3 lab=outn}
C {sky130_fd_pr/nfet3_01v8.sym} 870 -450 0 0 {name=M2
W=1.08
L=0.15
body=gnd_vco
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 870 -760 0 0 {name=M3
W=1.98
L=0.15
body=vdd_vco
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_hvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 1030 -760 0 0 {name=M4
W=1.98
L=0.15
body=vdd_vco
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_hvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 1030 -450 0 0 {name=M5
W=1.08
L=0.15
body=gnd_vco
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {efx_pll96_dbuf.sym} 390 -930 0 0 {name=xbuf[2:0]}
C {ipin.sym} 230 -1020 0 0 {name=p1 lab=tst[2]}
C {lab_pin.sym} 550 -960 0 1 {name=p15 sig_type=std_logic lab=vdd_vco}
C {lab_pin.sym} 550 -940 0 1 {name=p20 sig_type=std_logic lab=tst_bb[2:0]}
C {lab_pin.sym} 550 -920 0 1 {name=p21 sig_type=std_logic lab=tst_b[2:0]}
C {lab_pin.sym} 550 -900 0 1 {name=p22 sig_type=std_logic lab=gnd_vco}
C {lab_wire.sym} 830 -450 0 0 {name=p32 sig_type=std_logic lab=tst_bb[1]}
C {lab_wire.sym} 830 -760 0 0 {name=p33 sig_type=std_logic lab=tst_b[0]}
C {lab_wire.sym} 1000 -760 0 0 {name=p34 sig_type=std_logic lab=tst_b[2]}
C {lab_wire.sym} 990 -450 0 0 {name=p35 sig_type=std_logic lab=tst_bb[0]}
C {sky130_fd_pr/res_high_po_0p35.sym} 1210 -530 0 1 {name=R4
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1050 -530 0 1 {name=R3
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1370 -530 0 1 {name=R5
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1370 -670 0 1 {name=R6
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1210 -670 0 1 {name=R7
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1050 -670 0 1 {name=R8
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 890 -670 0 1 {name=R9
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {bus_connect_nolab.sym} 250 -1010 0 1 {name=r10}
C {bus_connect_nolab.sym} 250 -990 0 1 {name=r11}
C {bus_connect_nolab.sym} 250 -970 0 1 {name=r12}
C {ipin.sym} 230 -1000 0 0 {name=p9 lab=tst[1]}
C {ipin.sym} 230 -980 0 0 {name=p14 lab=tst[0]}
C {lab_wire.sym} 250 -930 0 0 {name=p23 sig_type=std_logic lab=tst[2:0]}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {lab_pin.sym} 730 -920 0 0 {name=p24 sig_type=std_logic lab=tst_b[1]}
C {lab_pin.sym} 730 -940 0 0 {name=p25 sig_type=std_logic lab=tst_bb[2]}
C {noconn.sym} 770 -940 0 1 {name=l2}
C {noconn.sym} 770 -920 0 1 {name=l3}
C {sky130_efx_lvdig__buf_1.sym} 330 -1040 0 0 {name=x4 VGND=gnd_vco VNB=gnd_vco VPB=vdd_vco VPWR=vdd_vco }
C {ipin.sym} 230 -1040 0 0 {name=p26 lab=en}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 710 -760 0 0 {name=M6
W=1.98
L=0.15
body=vdd_vco
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_hvt
spiceprefix=X
}
C {lab_wire.sym} 670 -760 0 0 {name=p27 sig_type=std_logic lab=en_bb}
C {lab_pin.sym} 550 -1040 0 1 {name=p28 sig_type=std_logic lab=en_bb
}
C {sky130_fd_pr/res_high_po_0p69.sym} 380 -700 0 0 {name=RD1[4:0]
L=6.84
model=res_high_po_0p69
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p69.sym} 500 -700 2 1 {name=RD2[4:0]
L=6.84
model=res_high_po_0p69
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p69.sym} 620 -700 0 0 {name=RD3[4:0]
L=6.84
model=res_high_po_0p69
spiceprefix=X
mult=1}
C {lab_wire.sym} 590 -730 0 0 {name=p29 sig_type=std_logic lab=rd2m[4:0]}
C {lab_wire.sym} 590 -650 0 0 {name=p30 sig_type=std_logic lab=rd3m[4:0]}
C {lab_wire.sym} 410 -670 2 0 {name=p31 sig_type=std_logic lab=rd1m[4:0]}
C {sky130_fd_pr/res_high_po_0p69.sym} 260 -700 0 0 {name=RD0[4:0]
L=6.84
model=res_high_po_0p69
spiceprefix=X
mult=1}
C {lab_wire.sym} 350 -730 0 0 {name=p36 sig_type=std_logic lab=rd0m[4:0]}
C {sky130_efx_lvdig__decap20.sym} 390 -860 0 0 {name=x5[1:0] VGND=gnd_vco VNB=gnd_vco VPB=vdd_vco VPWR=vdd_vco }
