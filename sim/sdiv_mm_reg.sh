#!/bin/bash
# 4 MHz reference
cp config_4.inc config.inc
ngspice -b -o sdiv_mm_reg_4.out tb_efx_pll96_sdiv_mm_reg.spice
mv tb_efx_pll96_sdiv_mm_reg.raw sdiv_mm_reg_4.raw

# 5 MHz reference
cp config_5.inc config.inc
ngspice -b -o sdiv_mm_reg_5.out tb_efx_pll96_sdiv_mm_reg.spice
mv tb_efx_pll96_sdiv_mm_reg.raw sdiv_mm_reg_5.raw

# 6 MHz reference
cp config_6.inc config.inc
ngspice -b -o sdiv_mm_reg_6.out tb_efx_pll96_sdiv_mm_reg.spice
mv tb_efx_pll96_sdiv_mm_reg.raw sdiv_mm_reg_6.raw

# 8 MHz reference
cp config_8.inc config.inc
ngspice -b -o sdiv_mm_reg_8.out tb_efx_pll96_sdiv_mm_reg.spice
mv tb_efx_pll96_sdiv_mm_reg.raw sdiv_mm_reg_8.raw

# 10 MHz reference
cp config_10.inc config.inc
ngspice -b -o sdiv_mm_reg_10.out tb_efx_pll96_sdiv_mm_reg.spice
mv tb_efx_pll96_sdiv_mm_reg.raw sdiv_mm_reg_10.raw

# 12 MHz reference
cp config_12.inc config.inc
ngspice -b -o sdiv_mm_reg_12.out tb_efx_pll96_sdiv_mm_reg.spice
mv tb_efx_pll96_sdiv_mm_reg.raw sdiv_mm_reg_12.raw

# 16 MHz reference
cp config_16.inc config.inc
ngspice -b -o sdiv_mm_reg_16.out tb_efx_pll96_sdiv_mm_reg.spice
mv tb_efx_pll96_sdiv_mm_reg.raw sdiv_mm_reg_16.raw

