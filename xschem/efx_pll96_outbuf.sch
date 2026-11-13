v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 90 -230 110 -230 {
lab=#net1}
N 90 -230 90 -200 {
lab=#net1}
N 90 -200 310 -200 {
lab=#net1}
N 310 -230 310 -200 {
lab=#net1}
N 290 -230 310 -230 {
lab=#net1}
N 90 -350 90 -250 {
lab=in}
N 10 -350 90 -350 {
lab=in}
N 90 -250 110 -250 {
lab=in}
N 90 -350 210 -350 {
lab=in}
N 290 -350 330 -350 {
lab=#net2}
N 410 -350 490 -350 {
lab=out_vco}
N 410 -250 490 -250 {
lab=out_vco_div2}
N 290 -250 330 -250 {
lab=#net3}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {sky130_efx_lvdig__clkinv_2.sym} 250 -350 0 0 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__dfxbp_2.sym} 200 -240 0 0 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {ipin.sym} 10 -350 0 0 {name=p1 lab=in}
C {opin.sym} 490 -250 0 0 {name=p2 lab=out_vco_div2}
C {iopin.sym} 10 -160 0 1 {name=p3 lab=vdd}
C {opin.sym} 490 -350 0 0 {name=p4 lab=out_vco}
C {iopin.sym} 10 -140 0 1 {name=p5 lab=gnd}
C {sky130_efx_lvdig__clkinv_8.sym} 370 -350 0 0 {name=x3 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__clkbuf_8.sym} 370 -250 0 0 {name=x4 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
