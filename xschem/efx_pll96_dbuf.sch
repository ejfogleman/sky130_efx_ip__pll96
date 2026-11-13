v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 290 -370 290 -340 {
lab=vdd}
N 290 -270 290 -260 {
lab=y_b}
N 230 -310 250 -310 {
lab=a}
N 230 -230 250 -230 {
lab=a}
N 290 -200 290 -170 {
lab=gnd}
N 290 -270 450 -270 {
lab=y_b}
N 290 -280 290 -270 {
lab=y_b}
N 230 -270 230 -230 {
lab=a}
N 200 -270 230 -270 {
lab=a}
N 230 -310 230 -270 {
lab=a}
N 510 -370 510 -340 {
lab=vdd}
N 510 -270 510 -260 {
lab=y}
N 450 -310 470 -310 {
lab=y_b}
N 450 -230 470 -230 {
lab=y_b}
N 510 -200 510 -170 {
lab=gnd}
N 510 -270 590 -270 {
lab=y}
N 510 -280 510 -270 {
lab=y}
N 450 -270 450 -230 {
lab=y_b}
N 450 -310 450 -270 {
lab=y_b}
N 290 -370 510 -370 {
lab=vdd}
N 200 -370 290 -370 {
lab=vdd}
N 290 -170 510 -170 {
lab=gnd}
N 200 -170 290 -170 {
lab=gnd}
N 450 -230 450 -190 {
lab=y_b}
N 450 -190 590 -190 {
lab=y_b}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {ipin.sym} 200 -270 0 0 {name=p26 lab=a}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 270 -310 0 0 {name=MP1
W=1.2
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
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 490 -310 0 0 {name=MP3
W=1.2
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
C {sky130_fd_pr/nfet3_01v8.sym} 490 -230 0 0 {name=MN4
W=0.74
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
C {sky130_fd_pr/nfet3_01v8.sym} 270 -230 0 0 {name=MN2
W=0.74
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
C {iopin.sym} 200 -370 0 1 {name=p1 lab=vdd}
C {iopin.sym} 200 -170 0 1 {name=p2 lab=gnd}
C {opin.sym} 590 -270 0 0 {name=p3 lab=y}
C {opin.sym} 590 -190 0 0 {name=p4 lab=y_b}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
