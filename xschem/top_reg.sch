v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {title_efx.sym} 200 -30 0 0 {name=l1 author="ejfogleman"}
C {devices/code_shown.sym} 10 90 0 0 {name=s1 only_toplevel=false value="*** efx_pll96 regression
*** run with:
*** ngspice -b -r top_reg.raw -o top_reg.out top_reg.spice

*** simulation setup
.option temp=27
.param VDD=1.8
.param TD_REF=50n
.param T_RF=300p
.param T_RAMP=50n
.param CP=10f
.param CLOAD=100f
.param IB=1u
.param VDIVR_EN=1.8
.param VCHP_EN=1.8
.param VTST0=0
.param VTST1=0
.param VTST2=0

*** mode-dependent options
.include config.inc

*** netlist and sim
.include tb_efx_pll96_top_template.spice
"}
C {copyright.sym} 0 10 0 0 {name=s3 place=header value="* Copyright (c) Eric Fogleman 2026 
* SPDX-License-Identifier: Apache-2.0"}
