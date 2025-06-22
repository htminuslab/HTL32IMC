nvc --std=2008 --work=RISCV  -a ../rtl/rv32pack.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/biu_ctrl_rtl.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/syncfifo.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/biu_struct.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/rv32dec.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/rv32sdiv.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/rv32proc.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/rv32reg.vhd 
nvc --std=2008 --work=RISCV  -a ../rtl/htl32rv.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/sram32.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/bootloader.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/redge.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/uart.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/rv32sys_struct.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/uartmon.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/rv32sys_tester_nvc.vhd 
nvc --std=2008 --work=RISCV  -a ../Testbench/rv32sys_tb_struct_nvc.vhd 

@REM wrong nvc --std=2008 --work=RISCV -e rv32sys_tb -r --ieee-warnings=off 
nvc --ieee-warnings=off  --std=2008 --work=RISCV -e rv32sys_tb -r 