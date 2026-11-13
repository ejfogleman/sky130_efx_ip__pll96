v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
T {Input divider 
div r[1:0]
1 ==> 00
2 ==> 01
4 ==> 11} 600 -190 0 0 0.4 0.4 {}
N 240 -470 270 -470 {
lab=#net1}
N 240 -470 240 -420 {
lab=#net1}
N 240 -420 480 -420 {
lab=#net1}
N 480 -470 480 -420 {
lab=#net1}
N 450 -470 480 -470 {
lab=#net1}
N 500 -450 600 -450 {
lab=#net2}
N 570 -470 600 -470 {
lab=#net3}
N 570 -470 570 -420 {
lab=#net3}
N 570 -420 810 -420 {
lab=#net3}
N 810 -470 810 -420 {
lab=#net3}
N 780 -470 810 -470 {
lab=#net3}
N 450 -300 700 -300 {
lab=#net4}
N 500 -450 500 -380 {
lab=#net2}
N 450 -450 500 -450 {
lab=#net2}
N 340 -380 500 -380 {
lab=#net2}
N 340 -380 340 -280 {
lab=#net2}
N 340 -280 370 -280 {
lab=#net2}
N 780 -450 830 -450 {
lab=#net5}
N 830 -450 830 -380 {
lab=#net5}
N 670 -380 830 -380 {
lab=#net5}
N 670 -380 670 -260 {
lab=#net5}
N 670 -260 710 -260 {
lab=#net5}
N 200 -450 270 -450 {
lab=#net6}
N 200 -320 370 -320 {
lab=#net6}
N 240 -530 570 -530 {
lab=en}
N 570 -530 570 -490 {
lab=en}
N 570 -490 600 -490 {
lab=en}
N 240 -490 270 -490 {
lab=en}
N 240 -530 240 -490 {
lab=en}
N 40 -530 240 -530 {
lab=en}
N 30 -240 370 -240 {
lab=r[0]}
N 30 -220 700 -220 {
lab=r[1]}
N 780 -280 880 -280 {
lab=clk_r}
N 200 -450 200 -320 {
lab=#net6}
N 20 -430 60 -430 {
lab=clk}
N 40 -530 40 -470 {
lab=en}
N 30 -530 40 -530 {
lab=en}
N 40 -470 60 -470 {
lab=en}
N 180 -450 200 -450 {
lab=#net6}
C {title_efx.sym} 200 -40 0 0 {name=l1 author="ejfogleman"}
C {sky130_efx_lvdig__dfrbp_2.sym} 360 -470 2 1 {name=xdff0 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ 
}
C {ipin.sym} 30 -430 0 0 {name=p1 lab=clk}
C {sky130_efx_lvdig__mux2_2.sym} 410 -300 0 0 {name=x1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__mux2_2.sym} 740 -280 0 0 {name=x2 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {sky130_efx_lvdig__dfrbp_2.sym} 690 -470 2 1 {name=xdff1 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ 
}
C {iopin.sym} 30 -150 0 1 {name=p2 lab=vdd}
C {iopin.sym} 30 -130 0 1 {name=p3 lab=gnd}
C {ipin.sym} 30 -530 0 0 {name=p4 lab=en}
C {ipin.sym} 30 -240 0 0 {name=p5 lab=r[0]}
C {ipin.sym} 30 -220 0 0 {name=p6 lab=r[1]}
C {opin.sym} 880 -280 0 0 {name=p7 lab=clk_r}
C {sky130_efx_lvdig__and2_2.sym} 120 -450 2 1 {name=x3 VGND=gnd VNB=gnd VPB=vdd VPWR=vdd prefix=sky130_efx_lvdig__ }
C {copyright.sym} 0 10 0 0 {name=s1 place=header value="* Copyright (c) Eric Fogleman 2025 
* SPDX-License-Identifier: Apache-2.0"}
