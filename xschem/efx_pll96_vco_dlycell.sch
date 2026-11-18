v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Simulation-only parasitic C (pcapacitor.sym, lvs_ignore=open): layout-extracted from
efx_pll96_vco_dlycell.mag (lvs/pex_c, saved 2026-11-18 06:56), C0..C20 rounded to 0.01 fF.
Reproduces the extracted-C delay cell to about +2% in frequency (the rest is device junction C).} 60 90 0 0 0.3 0.3 {}
N 370 -220 390 -220 {lab=gnd}
N 310 -220 330 -220 {lab=outn}
N 390 -220 390 -160 {lab=gnd}
N 310 -270 310 -220 {lab=outn}
N 370 -190 370 -160 {lab=gnd}
N 370 -270 370 -250 {lab=outp}
N 180 -220 200 -220 {lab=gnd}
N 120 -360 140 -360 {lab=inp}
N 120 -220 140 -220 {lab=inp}
N 180 -410 180 -390 {lab=vhi}
N 180 -360 200 -360 {lab=vdd}
N 200 -220 200 -160 {lab=gnd}
N 120 -310 120 -220 {lab=inp}
N 180 -160 200 -160 {lab=gnd}
N 180 -190 180 -160 {lab=gnd}
N 180 -270 180 -250 {lab=outn}
N 200 -160 370 -160 {lab=gnd}
N 570 -220 590 -220 {lab=gnd}
N 630 -220 650 -220 {lab=outp}
N 570 -220 570 -160 {lab=gnd}
N 650 -270 650 -220 {lab=outp}
N 570 -160 590 -160 {lab=gnd}
N 590 -190 590 -160 {lab=gnd}
N 590 -270 590 -250 {lab=outn}
N 760 -220 780 -220 {lab=gnd}
N 820 -360 840 -360 {lab=inn}
N 820 -220 840 -220 {lab=inn}
N 780 -410 780 -390 {lab=vhi}
N 760 -360 780 -360 {lab=vdd}
N 760 -220 760 -160 {lab=gnd}
N 840 -310 840 -220 {lab=inn}
N 760 -160 780 -160 {lab=gnd}
N 780 -190 780 -160 {lab=gnd}
N 780 -270 780 -250 {lab=outp}
N 590 -160 760 -160 {lab=gnd}
N 80 -310 120 -310 {lab=inp}
N 180 -310 180 -290 {lab=outn}
N 120 -360 120 -310 {lab=inp}
N 840 -310 880 -310 {lab=inn}
N 780 -310 780 -290 {lab=outp}
N 840 -360 840 -310 {lab=inn}
N 390 -160 570 -160 {lab=gnd}
N 370 -160 390 -160 {lab=gnd}
N 180 -270 310 -270 {lab=outn}
N 180 -290 180 -270 {lab=outn}
N 650 -270 780 -270 {lab=outp}
N 780 -290 780 -270 {lab=outp}
N 370 -270 460 -270 {lab=outp}
N 500 -270 590 -270 {lab=outn}
N 180 -290 460 -290 {lab=outn}
N 180 -310 210 -310 {lab=outn}
N 180 -330 180 -310 {lab=outn}
N 500 -290 780 -290 {lab=outp}
N 460 -290 500 -270 {lab=outn}
N 460 -270 500 -290 {lab=outp}
N 750 -310 780 -310 {lab=outp}
N 780 -330 780 -310 {lab=outp}
N 80 -410 180 -410 {lab=vhi}
N 80 -160 180 -160 {lab=gnd}
N 200 -440 760 -440 {lab=vdd}
N 760 -440 760 -360 {lab=vdd}
N 200 -440 200 -360 {lab=vdd}
N 80 -440 200 -440 {lab=vdd}
N 920 -160 980 -160 {lab=gnd}
N 980 -190 980 -160 {lab=gnd}
N 980 -220 1000 -220 {lab=gnd}
N 1000 -220 1000 -160 {lab=gnd}
N 980 -160 1000 -160 {lab=gnd}
N 920 -220 940 -220 {lab=gnd}
N 920 -220 920 -160 {lab=gnd}
N 920 -410 980 -410 {lab=vhi}
N 980 -410 980 -390 {lab=vhi}
N 920 -360 940 -360 {lab=vhi}
N 760 -440 1000 -440 {lab=vdd}
N 780 -160 920 -160 {lab=gnd}
N 180 -410 780 -410 {lab=vhi}
N 980 -360 1000 -360 {lab=vdd}
N 1000 -440 1000 -360 {lab=vdd}
N 980 -330 1020 -330 {lab=vhi}
N 1020 -410 1020 -330 {lab=vhi}
N 980 -410 1020 -410 {lab=vhi}
N 920 -410 920 -360 {lab=vhi}
N 780 -410 920 -410 {lab=vhi}
N 1070 -160 1130 -160 {lab=gnd}
N 1130 -190 1130 -160 {lab=gnd}
N 1130 -220 1150 -220 {lab=gnd}
N 1150 -220 1150 -160 {lab=gnd}
N 1130 -160 1150 -160 {lab=gnd}
N 1070 -220 1090 -220 {lab=gnd}
N 1070 -220 1070 -160 {lab=gnd}
N 1000 -160 1070 -160 {lab=gnd}
N 980 -270 980 -250 {lab=outn}
N 1130 -270 1130 -250 {lab=outp}
C {sky130_fd_pr/nfet_01v8.sym} 350 -220 0 0 {name=MN2P
W=1.26
L=0.44
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
C {sky130_fd_pr/nfet_01v8.sym} 160 -220 0 0 {name=MN1P
W=5.04
L=0.44
nf=4
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
C {sky130_fd_pr/pfet_01v8_hvt.sym} 160 -360 0 0 {name=MP1P
W=19.44
L=0.44
nf=4
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
C {sky130_fd_pr/nfet_01v8.sym} 610 -220 0 1 {name=MN2N
W=1.26
L=0.44
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
C {sky130_fd_pr/nfet_01v8.sym} 800 -220 0 1 {name=MN1N
W=5.04
L=0.44
nf=4
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
C {sky130_fd_pr/pfet_01v8_hvt.sym} 800 -360 0 1 {name=MP1N
W=19.44
L=0.44
nf=4
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
C {ipin.sym} 80 -310 0 0 {name=p7 lab=inp}
C {opin.sym} 210 -310 0 0 {name=p8 lab=outn}
C {ipin.sym} 880 -310 0 1 {name=p9 lab=inn}
C {opin.sym} 750 -310 0 1 {name=p10 lab=outp
}
C {iopin.sym} 80 -410 0 1 {name=p11 lab=vhi}
C {iopin.sym} 80 -160 0 1 {name=p12 lab=gnd}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {iopin.sym} 80 -440 0 1 {name=p1 lab=vdd}
C {sky130_fd_pr/nfet_01v8.sym} 960 -220 0 0 {name=MND1
W=1.26
L=0.44
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
C {sky130_fd_pr/pfet_01v8_hvt.sym} 960 -360 0 0 {name=MPD1[1:0]
W=4.86
L=0.44
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
C {sky130_fd_pr/nfet_01v8.sym} 1110 -220 0 0 {name=MND2
W=1.26
L=0.44
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
C {lab_wire.sym} 980 -270 0 0 {name=p2 sig_type=std_logic lab=outn}
C {lab_wire.sym} 1130 -270 0 0 {name=p3 sig_type=std_logic lab=outp}
C {pcapacitor.sym} 80 200 0 0 {name=CP0 m=1 value=0.18f}
C {lab_pin.sym} 80 170 0 0 {name=lcp0a sig_type=std_logic lab=inn}
C {lab_pin.sym} 80 230 0 0 {name=lcp0b sig_type=std_logic lab=inp}
C {pcapacitor.sym} 250 200 0 0 {name=CP1 m=1 value=0.26f}
C {lab_pin.sym} 250 170 0 0 {name=lcp1a sig_type=std_logic lab=inp}
C {lab_pin.sym} 250 230 0 0 {name=lcp1b sig_type=std_logic lab=vdd}
C {pcapacitor.sym} 420 200 0 0 {name=CP2 m=1 value=1.63f}
C {lab_pin.sym} 420 170 0 0 {name=lcp2a sig_type=std_logic lab=inp}
C {lab_pin.sym} 420 230 0 0 {name=lcp2b sig_type=std_logic lab=outn}
C {pcapacitor.sym} 590 200 0 0 {name=CP3 m=1 value=0.61f}
C {lab_pin.sym} 590 170 0 0 {name=lcp3a sig_type=std_logic lab=vhi}
C {lab_pin.sym} 590 230 0 0 {name=lcp3b sig_type=std_logic lab=inp}
C {pcapacitor.sym} 760 200 0 0 {name=CP4 m=1 value=0.26f}
C {lab_pin.sym} 760 170 0 0 {name=lcp4a sig_type=std_logic lab=inn}
C {lab_pin.sym} 760 230 0 0 {name=lcp4b sig_type=std_logic lab=vdd}
C {pcapacitor.sym} 930 200 0 0 {name=CP5 m=1 value=0.14f}
C {lab_pin.sym} 930 170 0 0 {name=lcp5a sig_type=std_logic lab=inn}
C {lab_pin.sym} 930 230 0 0 {name=lcp5b sig_type=std_logic lab=outn}
C {pcapacitor.sym} 1100 200 0 0 {name=CP6 m=1 value=0.20f}
C {lab_pin.sym} 1100 170 0 0 {name=lcp6a sig_type=std_logic lab=inp}
C {lab_pin.sym} 1100 230 0 0 {name=lcp6b sig_type=std_logic lab=outp}
C {pcapacitor.sym} 80 330 0 0 {name=CP7 m=1 value=0.62f}
C {lab_pin.sym} 80 300 0 0 {name=lcp7a sig_type=std_logic lab=inn}
C {lab_pin.sym} 80 360 0 0 {name=lcp7b sig_type=std_logic lab=vhi}
C {pcapacitor.sym} 250 330 0 0 {name=CP8 m=1 value=1.71f}
C {lab_pin.sym} 250 300 0 0 {name=lcp8a sig_type=std_logic lab=inn}
C {lab_pin.sym} 250 360 0 0 {name=lcp8b sig_type=std_logic lab=outp}
C {pcapacitor.sym} 420 330 0 0 {name=CP9 m=1 value=0.74f}
C {lab_pin.sym} 420 300 0 0 {name=lcp9a sig_type=std_logic lab=vdd}
C {lab_pin.sym} 420 360 0 0 {name=lcp9b sig_type=std_logic lab=outn}
C {pcapacitor.sym} 590 330 0 0 {name=CP10 m=1 value=2.24f}
C {lab_pin.sym} 590 300 0 0 {name=lcp10a sig_type=std_logic lab=vhi}
C {lab_pin.sym} 590 360 0 0 {name=lcp10b sig_type=std_logic lab=vdd}
C {pcapacitor.sym} 760 330 0 0 {name=CP11 m=1 value=1.46f}
C {lab_pin.sym} 760 300 0 0 {name=lcp11a sig_type=std_logic lab=vhi}
C {lab_pin.sym} 760 360 0 0 {name=lcp11b sig_type=std_logic lab=outn}
C {pcapacitor.sym} 930 330 0 0 {name=CP12 m=1 value=0.33f}
C {lab_pin.sym} 930 300 0 0 {name=lcp12a sig_type=std_logic lab=vdd}
C {lab_pin.sym} 930 360 0 0 {name=lcp12b sig_type=std_logic lab=outp}
C {pcapacitor.sym} 1100 330 0 0 {name=CP13 m=1 value=1.73f}
C {lab_pin.sym} 1100 300 0 0 {name=lcp13a sig_type=std_logic lab=outp}
C {lab_pin.sym} 1100 360 0 0 {name=lcp13b sig_type=std_logic lab=outn}
C {pcapacitor.sym} 80 460 0 0 {name=CP14 m=1 value=1.51f}
C {lab_pin.sym} 80 430 0 0 {name=lcp14a sig_type=std_logic lab=vhi}
C {lab_pin.sym} 80 490 0 0 {name=lcp14b sig_type=std_logic lab=outp}
C {pcapacitor.sym} 250 460 0 0 {name=CP15 m=1 value=1.38f}
C {lab_pin.sym} 250 430 0 0 {name=lcp15a sig_type=std_logic lab=outp}
C {lab_pin.sym} 250 490 0 0 {name=lcp15b sig_type=std_logic lab=gnd}
C {pcapacitor.sym} 420 460 0 0 {name=CP16 m=1 value=1.40f}
C {lab_pin.sym} 420 430 0 0 {name=lcp16a sig_type=std_logic lab=outn}
C {lab_pin.sym} 420 490 0 0 {name=lcp16b sig_type=std_logic lab=gnd}
C {pcapacitor.sym} 590 460 0 0 {name=CP17 m=1 value=1.41f}
C {lab_pin.sym} 590 430 0 0 {name=lcp17a sig_type=std_logic lab=inn}
C {lab_pin.sym} 590 490 0 0 {name=lcp17b sig_type=std_logic lab=gnd}
C {pcapacitor.sym} 760 460 0 0 {name=CP18 m=1 value=1.43f}
C {lab_pin.sym} 760 430 0 0 {name=lcp18a sig_type=std_logic lab=inp}
C {lab_pin.sym} 760 490 0 0 {name=lcp18b sig_type=std_logic lab=gnd}
C {pcapacitor.sym} 930 460 0 0 {name=CP19 m=1 value=1.58f}
C {lab_pin.sym} 930 430 0 0 {name=lcp19a sig_type=std_logic lab=vhi}
C {lab_pin.sym} 930 490 0 0 {name=lcp19b sig_type=std_logic lab=gnd}
C {pcapacitor.sym} 1100 460 0 0 {name=CP20 m=1 value=7.34f}
C {lab_pin.sym} 1100 430 0 0 {name=lcp20a sig_type=std_logic lab=vdd}
C {lab_pin.sym} 1100 490 0 0 {name=lcp20b sig_type=std_logic lab=gnd}
