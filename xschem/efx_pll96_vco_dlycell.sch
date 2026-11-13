v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
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
N 180 -360 200 -360 {lab=vhi}
N 200 -410 200 -360 {lab=vhi}
N 180 -410 200 -410 {lab=vhi}
N 200 -220 200 -160 {lab=gnd}
N 120 -310 120 -220 {lab=inp}
N 180 -160 200 -160 {lab=gnd}
N 180 -190 180 -160 {lab=gnd}
N 180 -270 180 -250 {lab=outn}
N 200 -160 370 -160 {lab=gnd}
N 200 -410 760 -410 {lab=vhi}
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
N 760 -360 780 -360 {lab=vhi}
N 760 -410 760 -360 {lab=vhi}
N 760 -410 780 -410 {lab=vhi}
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
C {sky130_fd_pr/nfet_01v8.sym} 350 -220 0 0 {name=MN2P
W=1.22
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
W=4.88
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
nf=6
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
W=1.22
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
W=4.88
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
nf=6
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
