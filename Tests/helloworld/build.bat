@REM 
@REM Compile file and write to bootloader.vhd file
@REM 
@echo off
del *.o    > nul 2>&1 
del *.elf  > nul 2>&1 
del hello.bin > nul 2>&1 
del hello.lst > nul 2>&1 

@rem -ffunction-sections -fdata-sections

@ECHO Compiling hello.c
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc -c -Os -I..\rv32mod -mabi=ilp32 -march=rv32im -ffreestanding  -nostdlib hello.c

@ECHO Compiling support files
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc -c -Os -I..\rv32mod -mabi=ilp32 -march=rv32im -ffreestanding -nostdlib ..\rv32mod\debug.c
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc -c -Os -I..\rv32mod -mabi=ilp32 -march=rv32im -ffreestanding -nostdlib ..\rv32mod\start.S

@ECHO Link
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc start.o debug.o hello.o -Wl,-Bstatic,-T,..\rv32mod\rv32.lds,--strip-debug -ffreestanding -nostdlib -o hello.elf

C:\utils\RISC-V_toolchain\bin\riscv-none-embed-objcopy -O binary hello.elf hello.bin

REM @ECHO Create VHDL file
..\rv32mod\bin2text.exe -vhd -clk -ena -width 32 -awidth 14 hello.bin -o bootloader

del *.o
del *.elf
del hello.bin