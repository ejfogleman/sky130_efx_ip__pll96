v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {100 uA} 460 -840 0 0 0.4 0.4 {}
T {Level shift to divider supply} 1500 -330 0 0 0.4 0.4 {}
T {34 uA (test only)} 850 -840 0 0 0.4 0.4 {hcenter=true}
T {34 uA (test only)} 860 -390 0 0 0.4 0.4 {hcenter=true}
T {Test mode to drive vco vc to fixed
levels with charge pump disabled
tst[2],tst[1],tst[0]
1,0,0 ==> 1.8 V
1,0,1 ==> 0.9 V (3/6)
0,0,1 ==> 0.771 V (3/7)
1,1,X ==> 0.72 V (2/5)
0,1,1 ==> 0.6 V (2/6) 
0,1,0 ==> 0 V
0,0,0 ==> NORMAL MODE} 1430 -820 0 0 0.4 0.4 {}
N 280 -310 280 -260 {lab=vhi}
N 280 -240 340 -240 {lab=x0n}
N 280 -220 340 -220 {lab=x0p}
N 640 -200 640 -160 {lab=gnd_vco}
N 640 -310 640 -260 {lab=vhi}
N 640 -240 700 -240 {lab=x1p}
N 640 -220 700 -220 {lab=x1n}
N 1000 -200 1000 -160 {lab=gnd_vco}
N 1000 -310 1000 -260 {lab=vhi}
N 1000 -240 1060 -240 {lab=x2n}
N 1000 -220 1060 -220 {lab=x2p}
N -80 -240 -20 -240 {lab=x3n}
N -80 -350 -80 -240 {lab=x3n}
N -80 -220 -80 -110 {lab=x3p}
N -80 -220 -20 -220 {lab=x3p}
N 1360 -310 1360 -260 {lab=vhi}
N 1420 -240 1490 -240 {lab=x3p}
N 1420 -220 1490 -220 {lab=x3n}
N 640 -310 1000 -310 {lab=vhi}
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
N 230 -810 460 -810 {
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
N 1000 -310 1360 -310 {lab=vhi}
N 940 -500 940 -480 {
lab=#net3}
N 940 -730 940 -700 {
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
N 230 -600 1260 -600 {
lab=vc}
N 500 -310 640 -310 {lab=vhi}
N 280 -310 500 -310 {lab=vhi}
N 780 -810 940 -810 {
lab=vdd_vco}
N 460 -810 500 -810 {
lab=vdd_vco}
N 940 -810 940 -780 {
lab=vdd_vco}
N 780 -810 780 -790 {
lab=vdd_vco}
N 500 -810 780 -810 {
lab=vdd_vco}
N 780 -430 780 -400 {
lab=gnd_vco}
N 940 -420 940 -400 {
lab=gnd_vco}
N 780 -400 940 -400 {
lab=gnd_vco}
N 1810 -160 1850 -160 {
lab=gnd_vco}
N 1850 -400 1850 -160 {
lab=gnd_vco}
N 940 -400 1850 -400 {
lab=gnd_vco}
N 1790 -260 1810 -260 {lab=vdd}
N 1360 -160 1810 -160 {
lab=gnd_vco}
N 1790 -200 1810 -200 {
lab=gnd_vco}
N 720 -760 740 -760 {
lab=tst_b[0]}
N 720 -450 740 -450 {
lab=tst_bb[1]}
N 880 -450 900 -450 {
lab=tst_bb[0]}
N 880 -760 900 -760 {
lab=tst_b[2]}
N 1440 -350 1440 -260 {
lab=x3n}
N 1420 -220 1440 -260 {
lab=x3n}
N 1360 -220 1420 -220 {lab=x3n}
N 1420 -240 1440 -200 {
lab=x3p}
N 1360 -240 1420 -240 {lab=x3p}
N 1440 -200 1440 -110 {
lab=x3p}
N 1100 -640 1100 -620 {
lab=#net5}
N 1100 -620 1220 -620 {
lab=#net5}
N 1220 -700 1220 -620 {
lab=#net5}
N 1100 -580 1100 -560 {
lab=#net6}
N 1100 -580 1220 -580 {
lab=#net6}
N 1220 -580 1220 -500 {
lab=#net6}
N 1220 -500 1260 -500 {
lab=#net6}
N 1080 -720 1080 -530 {
lab=vdd_vco}
N 1080 -720 1240 -720 {
lab=vdd_vco}
N 1220 -700 1260 -700 {
lab=#net5}
N 1240 -720 1240 -530 {
lab=vdd_vco}
N 940 -620 1060 -620 {
lab=#net7}
N 1060 -700 1060 -620 {
lab=#net7}
N 1060 -700 1100 -700 {
lab=#net7}
N 1060 -580 1060 -500 {
lab=#net8}
N 1060 -500 1100 -500 {
lab=#net8}
N 780 -640 780 -620 {
lab=#net4}
N 780 -620 900 -620 {
lab=#net4}
N 900 -700 900 -620 {
lab=#net4}
N 900 -700 940 -700 {
lab=#net4}
N 920 -720 920 -530 {
lab=vdd_vco}
N 920 -720 1080 -720 {
lab=vdd_vco}
N 940 -580 940 -560 {
lab=#net8}
N 1260 -600 1260 -560 {
lab=vc}
N 940 -640 940 -620 {
lab=#net7}
N 940 -580 1060 -580 {
lab=#net8}
N 780 -580 940 -580 {
lab=#net8}
N 780 -580 780 -480 {
lab=#net8}
N 780 -730 780 -700 {
lab=#net9}
N 940 -810 1240 -810 {
lab=vdd_vco}
N 1240 -810 1240 -720 {
lab=vdd_vco}
N 1260 -640 1260 -600 {
lab=vc}
N 760 -720 920 -720 {
lab=vdd_vco}
N 760 -720 760 -670 {
lab=vdd_vco}
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
C {lab_wire.sym} 300 -310 0 1 {name=p2 sig_type=std_logic lab=vhi}
C {efx_pll96_vco_ls.sym} 1640 -230 0 0 {name=xls}
C {lab_wire.sym} 1380 -220 0 1 {name=p16 sig_type=std_logic lab=x3n}
C {lab_wire.sym} 1380 -240 0 1 {name=p17 sig_type=std_logic lab=x3p}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 480 -600 0 0 {name=M1
W=24
L=2.4
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
C {sky130_fd_pr/nfet3_01v8.sym} 760 -450 0 0 {name=M2
W=1
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 760 -760 0 0 {name=M3
W=2
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 920 -760 0 0 {name=M4
W=2
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
C {sky130_fd_pr/nfet3_01v8.sym} 920 -450 0 0 {name=M5
W=1
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
C {lab_wire.sym} 720 -450 0 0 {name=p32 sig_type=std_logic lab=tst_bb[1]}
C {lab_wire.sym} 720 -760 0 0 {name=p33 sig_type=std_logic lab=tst_b[0]}
C {lab_wire.sym} 890 -760 0 0 {name=p34 sig_type=std_logic lab=tst_b[2]}
C {lab_wire.sym} 880 -450 0 0 {name=p35 sig_type=std_logic lab=tst_bb[0]}
C {sky130_fd_pr/res_high_po_0p35.sym} 1100 -530 0 0 {name=R4
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 940 -530 0 0 {name=R3
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1260 -530 0 0 {name=R5
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1260 -670 0 0 {name=R6
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 1100 -670 0 0 {name=R7
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 940 -670 0 0 {name=R8
L=9
model=res_high_po_0p35
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 780 -670 0 0 {name=R9
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
