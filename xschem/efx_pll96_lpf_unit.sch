v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {1.8 pF unit cap 
13.32 um x 14.76 um 
72 x 80 lambda} -100 -250 0 0 0.4 0.4 {}
N 200 -380 200 -360 {lab=vc}
N 140 -200 170 -200 {lab=vdd}
N 140 -280 140 -200 {lab=vdd}
N 230 -200 260 -200 {lab=vdd}
N 260 -280 260 -200 {lab=vdd}
N 200 -280 260 -280 {lab=vdd}
N 200 -300 200 -280 {lab=vdd}
N 200 -160 200 -130 {lab=vc}
N 200 -130 330 -130 {lab=vc}
N 200 -380 330 -380 {lab=vc}
N 330 -380 330 -130 {lab=vc}
N 200 -480 200 -460 {lab=vdd}
N 140 -280 200 -280 {lab=vdd}
N 70 -480 70 -280 {lab=vdd}
N 70 -480 200 -480 {lab=vdd}
N 70 -280 140 -280 {lab=vdd}
N 200 -400 200 -380 {lab=vc}
N 0 -480 70 -480 {lab=vdd}
N 0 -130 200 -130 {lab=vc}
C {title_efx.sym} 0 0 0 0 {name=l1 author="designer"}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2026 
* SPDX-License-Identifier: Apache-2.0"}
C {sky130_fd_pr/cap_mim_m3_1.sym} 200 -330 0 1 {name=CMIM3 model=cap_mim_m3_1 W=12.96 L=14.40 MF=1 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_2.sym} 200 -430 2 0 {name=CMIM4 model=cap_mim_m3_2 W=12.96 L=14.40 MF=1 spiceprefix=X}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 200 -180 3 0 {name=MPC
W=13.32
L=5.4
body=vdd
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {ipin.sym} 0 -130 0 0 {name=p1 lab=vc}
C {iopin.sym} 0 -480 0 1 {name=p2 lab=vdd}
