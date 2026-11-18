v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 510 -270 590 -270 {
lab=y}
N 390 -270 430 -270 {
lab=y_b}
N 200 -270 260 -270 {lab=a}
N 390 -270 390 -190 {lab=y_b}
N 340 -270 390 -270 {
lab=y_b}
N 390 -190 590 -190 {lab=y_b}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {ipin.sym} 200 -270 0 0 {name=p26 lab=a}
C {iopin.sym} 200 -370 0 1 {name=p1 lab=vdd}
C {iopin.sym} 200 -170 0 1 {name=p2 lab=gnd}
C {opin.sym} 590 -270 0 0 {name=p3 lab=y}
C {opin.sym} 590 -190 0 0 {name=p4 lab=y_b}
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
C {sky130_efx_lvdig__inv_1.sym} 300 -270 0 0 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd }
C {sky130_efx_lvdig__inv_1.sym} 470 -270 0 0 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd }
