v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {100 uA} 460 -840 0 0 0.4 0.4 {}
T {Level shift to divider supply} 1500 -330 0 0 0.4 0.4 {}
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
0,0,0 ==> NORMAL MODE} 1550 -820 0 0 0.4 0.4 {}
N 280 -240 340 -240 {lab=x0n}
N 280 -220 340 -220 {lab=x0p}
N 640 -200 640 -160 {lab=gnd_vco}
N 640 -240 700 -240 {lab=x1p}
N 640 -220 700 -220 {lab=x1n}
N 1000 -200 1000 -160 {lab=gnd_vco}
N 1000 -240 1060 -240 {lab=x2n}
N 1000 -220 1060 -220 {lab=x2p}
N -80 -240 -20 -240 {lab=x3n}
N -80 -350 -80 -240 {lab=x3n}
N -80 -220 -80 -110 {lab=x3p}
N -80 -220 -20 -220 {lab=x3p}
N 1420 -240 1490 -240 {lab=x3p}
N 1420 -220 1490 -220 {lab=x3n}
N 680 -310 1040 -310 {lab=vhi}
N 500 -810 500 -790 {lab=vdd_vco}
N 1810 -200 1810 -160 {lab=gnd_vco}
N 1790 -220 1900 -220 {lab=outn}
N -80 -350 1440 -350 {
lab=x3n}
N -80 -110 1440 -110 {
lab=x3p}
N 500 -650 500 -630 {
lab=#net1}
N 500 -730 500 -710 {
lab=#net2}
N 460 -710 460 -680 {
lab=vdd_vco}
N 460 -680 480 -680 {
lab=vdd_vco}
N 460 -760 480 -760 {
lab=vdd_vco}
N 280 -200 280 -160 {lab=gnd_vco}
N 280 -160 640 -160 {
lab=gnd_vco}
N 640 -160 1000 -160 {
lab=gnd_vco}
N 1000 -160 1360 -160 {
lab=gnd_vco}
N 1360 -200 1360 -160 {lab=gnd_vco}
N 1810 -360 1810 -260 {
lab=vdd}
N 1790 -240 1900 -240 {lab=outp}
N 20 -160 280 -160 {
lab=gnd_vco}
N 460 -810 460 -760 {
lab=vdd_vco}
N 300 -810 460 -810 {
lab=vdd_vco}
N 460 -670 460 -650 {
lab=vdd_vco}
N 420 -650 460 -650 {
lab=vdd_vco}
N 420 -710 460 -710 {
lab=vdd_vco}
N 460 -760 460 -710 {
lab=vdd_vco}
N 440 -680 450 -680 {
lab=vdd_vco}
N 450 -680 450 -670 {
lab=vdd_vco}
N 450 -670 460 -670 {
lab=vdd_vco}
N 460 -680 460 -670 {
lab=vdd_vco}
N 1040 -310 1400 -310 {lab=vhi}
N 1050 -500 1050 -480 {
lab=#net3}
N 1050 -730 1050 -700 {
lab=#net4}
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
N 460 -810 500 -810 {
lab=vdd_vco}
N 1050 -810 1050 -780 {
lab=vdd_vco}
N 890 -810 890 -790 {
lab=vdd_vco}
N 890 -430 890 -400 {
lab=gnd_vco}
N 1050 -420 1050 -400 {
lab=gnd_vco}
N 1810 -160 1850 -160 {
lab=gnd_vco}
N 1850 -400 1850 -160 {
lab=gnd_vco}
N 1850 -400 1900 -400 {
lab=gnd_vco}
N 1790 -260 1810 -260 {lab=vdd}
N 1360 -160 1810 -160 {
lab=gnd_vco}
N 1790 -200 1810 -200 {
lab=gnd_vco}
N 830 -760 850 -760 {
lab=tst_b[0]}
N 830 -450 850 -450 {
lab=tst_bb[1]}
N 990 -450 1010 -450 {
lab=tst_bb[0]}
N 990 -760 1010 -760 {
lab=tst_b[2]}
N 1420 -220 1440 -260 {
lab=x3n}
N 1360 -220 1420 -220 {lab=x3n}
N 1420 -240 1440 -200 {
lab=x3p}
N 1360 -240 1420 -240 {lab=x3p}
N 1440 -200 1440 -110 {
lab=x3p}
N 1210 -640 1210 -620 {
lab=#net5}
N 1210 -620 1330 -620 {
lab=#net5}
N 1330 -700 1330 -620 {
lab=#net5}
N 1210 -580 1210 -560 {
lab=#net6}
N 1210 -580 1330 -580 {
lab=#net6}
N 1330 -580 1330 -500 {
lab=#net6}
N 1330 -500 1370 -500 {
lab=#net6}
N 1330 -700 1370 -700 {
lab=#net5}
N 1050 -620 1170 -620 {
lab=#net7}
N 1170 -700 1170 -620 {
lab=#net7}
N 1170 -700 1210 -700 {
lab=#net7}
N 1170 -580 1170 -500 {
lab=#net8}
N 1170 -500 1210 -500 {
lab=#net8}
N 890 -640 890 -620 {
lab=#net4}
N 890 -620 1010 -620 {
lab=#net4}
N 1010 -700 1010 -620 {
lab=#net4}
N 1010 -700 1050 -700 {
lab=#net4}
N 1050 -580 1050 -560 {
lab=#net8}
N 1050 -640 1050 -620 {
lab=#net7}
N 1050 -580 1170 -580 {
lab=#net8}
N 890 -580 1050 -580 {
lab=#net8}
N 890 -580 890 -480 {
lab=#net8}
N 890 -730 890 -700 {
lab=#net9}
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
N 1400 -310 1400 -260 {lab=vhi}
N 1360 -260 1400 -260 {lab=vhi}
N 280 -280 300 -280 {lab=vdd_vco}
N 300 -330 300 -280 {lab=vdd_vco}
N 230 -810 300 -810 {
lab=vdd_vco}
N 300 -810 300 -330 {lab=vdd_vco}
N 1380 -330 1380 -280 {lab=vdd_vco}
N 1360 -280 1380 -280 {lab=vdd_vco}
N 640 -280 660 -280 {lab=vdd_vco}
N 660 -330 660 -280 {lab=vdd_vco}
N 300 -330 660 -330 {lab=vdd_vco}
N 1000 -280 1020 -280 {lab=vdd_vco}
N 1020 -330 1020 -280 {lab=vdd_vco}
N 1020 -330 1380 -330 {lab=vdd_vco}
N 1440 -350 1440 -260 {
lab=x3n}
N 890 -400 1050 -400 {
lab=gnd_vco}
N 730 -810 730 -790 {
lab=vdd_vco}
N 670 -760 690 -760 {
lab=en_bb}
N 1050 -400 1850 -400 {
lab=gnd_vco}
N 500 -810 730 -810 {lab=vdd_vco}
N 890 -810 1050 -810 {lab=vdd_vco}
N 730 -810 890 -810 {
lab=vdd_vco}
N 730 -730 730 -700 {lab=#net9}
N 730 -700 890 -700 {lab=#net9}
N 230 -1040 290 -1040 {lab=en}
N 370 -1040 550 -1040 {lab=en_bb}
N 660 -330 1020 -330 {lab=vdd_vco}
N 230 -600 1370 -600 {lab=vc}
N 1370 -640 1370 -600 {
lab=vc}
N 1390 -670 1390 -530 {lab=vdd_vco}
N 910 -670 1390 -670 {lab=vdd_vco}
N 1390 -810 1390 -670 {lab=vdd_vco}
N 1070 -530 1390 -530 {lab=vdd_vco}
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
C {efx_pll96_vco_dlycell.sym} 1210 -230 0 0 {name=x3}
C {lab_wire.sym} 350 -310 0 1 {name=p2 sig_type=std_logic lab=vhi}
C {efx_pll96_vco_ls.sym} 1640 -230 0 0 {name=xls}
C {lab_wire.sym} 1380 -220 0 1 {name=p16 sig_type=std_logic lab=x3n}
C {lab_wire.sym} 1380 -240 0 1 {name=p17 sig_type=std_logic lab=x3p}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 480 -600 0 0 {name=M1
W=23.76
L=2.38
body=vdd_vco
nf=4
mult=10
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {ipin.sym} 230 -600 0 0 {name=p11 lab=vc}
C {iopin.sym} 230 -810 0 1 {name=p12 lab=vdd_vco}
C {opin.sym} 1900 -240 0 0 {name=p13 lab=outp}
C {iopin.sym} 20 -160 0 1 {name=p18 lab=gnd_vco}
C {iopin.sym} 1810 -360 0 1 {name=p19 lab=vdd}
C {opin.sym} 1900 -220 0 0 {name=p3 lab=outn}
C {sky130_fd_pr/res_high_po_2p85.sym} 500 -760 0 0 {name=R1
L=12.1
model=res_high_po_2p85
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_2p85.sym} 500 -680 0 0 {name=R2
L=12.1
model=res_high_po_2p85
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_2p85.sym} 420 -680 0 1 {name=R10[1:0]
L=12.1
model=res_high_po_2p85
spiceprefix=X
mult=1}
C {sky130_fd_pr/nfet3_01v8.sym} 870 -450 0 0 {name=M2
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
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 870 -760 0 0 {name=M3
W=1.98
L=0.15
body=vdd
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
body=vdd
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
body=gnd
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
body=vdd
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
