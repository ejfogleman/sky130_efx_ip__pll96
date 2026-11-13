v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 120 -340 140 -340 {lab=inp}
N 120 -200 140 -200 {lab=inp}
N 180 -170 180 -120 {lab=gnd}
N 220 -480 270 -480 {lab=ls_outp}
N 180 -530 180 -510 {lab=vdd}
N 60 -270 120 -270 {lab=inp}
N 120 -270 120 -200 {lab=inp}
N 450 -340 470 -340 {lab=inn}
N 450 -200 470 -200 {lab=inn}
N 410 -170 410 -120 {lab=gnd}
N 410 -530 410 -510 {lab=vdd}
N 410 -450 410 -370 {lab=#net1}
N 180 -530 410 -530 {lab=vdd}
N 180 -450 180 -370 {lab=#net2}
N 180 -270 660 -270 {lab=ls_outn}
N 180 -270 180 -230 {lab=ls_outn}
N 180 -290 270 -290 {lab=ls_outn}
N 180 -310 180 -290 {lab=ls_outn}
N 470 -340 470 -200 {lab=inn}
N 410 -250 410 -230 {lab=ls_outp}
N 320 -480 370 -480 {lab=ls_outn}
N 320 -290 410 -290 {lab=ls_outp}
N 410 -310 410 -290 {lab=ls_outp}
N 270 -480 320 -290 {lab=ls_outp}
N 270 -290 320 -480 {lab=ls_outn}
N 60 -530 180 -530 {lab=vdd}
N 830 -340 850 -340 {lab=ls_outp}
N 830 -200 850 -200 {lab=ls_outp}
N 890 -170 890 -120 {lab=gnd}
N 890 -250 890 -230 {lab=outn}
N 830 -250 830 -200 {lab=ls_outp}
N 890 -250 970 -250 {lab=outn}
N 890 -310 890 -250 {lab=outn}
N 890 -530 890 -370 {
lab=vdd}
N 720 -530 890 -530 {lab=vdd}
N 660 -340 680 -340 {lab=ls_outn}
N 660 -200 680 -200 {lab=ls_outn}
N 720 -170 720 -120 {lab=gnd}
N 660 -270 660 -200 {lab=ls_outn}
N 720 -270 720 -230 {lab=outp}
N 720 -530 720 -370 {
lab=vdd}
N 410 -530 720 -530 {lab=vdd}
N 60 -120 180 -120 {lab=gnd}
N 180 -120 410 -120 {lab=gnd}
N 410 -120 720 -120 {lab=gnd}
N 720 -120 890 -120 {lab=gnd}
N 60 -150 470 -150 {lab=inn}
N 470 -200 470 -150 {
lab=inn}
N 120 -340 120 -270 {lab=inp}
N 180 -290 180 -270 {lab=ls_outn}
N 660 -340 660 -270 {lab=ls_outn}
N 720 -310 720 -270 {lab=outp}
N 720 -270 970 -270 {lab=outp}
N 410 -250 830 -250 {
lab=ls_outp}
N 410 -290 410 -250 {lab=ls_outp}
N 830 -340 830 -250 {lab=ls_outp}
C {ipin.sym} 60 -270 0 0 {name=p7 lab=inp}
C {opin.sym} 970 -250 0 0 {name=p8 lab=outn}
C {ipin.sym} 60 -150 0 0 {name=p9 lab=inn}
C {opin.sym} 970 -270 0 0 {name=p10 lab=outp
}
C {iopin.sym} 60 -530 0 1 {name=p11 lab=vdd}
C {iopin.sym} 60 -120 0 1 {name=p12 lab=gnd}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 390 -480 0 0 {name=M5
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
C {sky130_fd_pr/nfet3_01v8.sym} 160 -200 0 0 {name=M1
W=2
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
C {sky130_fd_pr/nfet3_01v8.sym} 430 -200 0 1 {name=M2
W=2
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 200 -480 0 1 {name=M3
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 160 -340 0 0 {name=M4
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 430 -340 0 1 {name=M6
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
C {sky130_fd_pr/nfet3_01v8.sym} 870 -200 0 0 {name=M7
W=2
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 870 -340 0 0 {name=M8
W=4
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
C {sky130_fd_pr/nfet3_01v8.sym} 700 -200 0 0 {name=M9
W=2
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 700 -340 0 0 {name=M10
W=4
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
C {lab_wire.sym} 550 -270 0 0 {name=p1 sig_type=std_logic lab=ls_outn}
C {lab_wire.sym} 550 -250 0 0 {name=p2 sig_type=std_logic lab=ls_outp}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
