vlib RISCV
vcom -quiet -2008 -work RISCV ../rtl/rv32pack.vhd 
vcom -quiet -2008 -work RISCV ../rtl/biu_ctrl_rtl.vhd 
vcom -quiet -2008 -work RISCV ../rtl/syncfifo.vhd 
vcom -quiet -2008 -work RISCV ../rtl/biu_struct.vhd 
vcom -quiet -2008 -work RISCV ../rtl/rv32dec.vhd 
vcom -quiet -2008 -work RISCV ../rtl/rv32sdiv.vhd 
vcom -quiet -2008 -work RISCV ../rtl/rv32proc.vhd 
vcom -quiet -2008 -work RISCV ../rtl/rv32reg.vhd 
vcom -quiet -2008 -work RISCV ../rtl/htl32rv.vhd 

vcom -quiet -2008 -work RISCV ../Testbench/sram32.vhd 
vcom -quiet -2008 -work RISCV ../Testbench/bootloader.vhd 
vcom -quiet -2008 -work RISCV ../Testbench/redge.vhd 
vcom -quiet -2008 -work RISCV ../Testbench/uart.vhd 
vcom -quiet -2008 -work RISCV ../Testbench/rv32sys_struct.vhd 
vcom -quiet -2008 -work RISCV ../Testbench/uartmon.vhd 
vcom -quiet -2008 -work RISCV ../Testbench/rv32sys_tester.vhd 
vcom -quiet -2008 -work RISCV ../Testbench/rv32sys_tb_struct.vhd 

vopt -quiet -work RISCV rv32sys_tb -o rv32sys_tb_vopt