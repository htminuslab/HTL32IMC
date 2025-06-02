@REM 
@REM Compile file and write to bootloader.vhd file
@REM 
@echo off
del *.o    > nul 2>&1 
del *.elf  > nul 2>&1 
del %1.bin > nul 2>&1 
del %1.lst > nul 2>&1 

@rem -ffunction-sections -fdata-sections

@ECHO Compiling %1.c
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc -c -Os -I. -I..\rv32mod -mabi=ilp32 -march=rv32im -ffreestanding  -nostdlib main.c

@ECHO Compiling support files
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc -c -Os -I. -I..\rv32mod -mabi=ilp32 -march=rv32im -ffreestanding -nostdlib ..\rv32mod\timer.c
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc -c -Os -I. -I..\rv32mod -mabi=ilp32 -march=rv32im -ffreestanding -nostdlib ..\rv32mod\debug.c
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc -c -Os -I. -I..\rv32mod -mabi=ilp32 -march=rv32im -ffreestanding -nostdlib ..\rv32mod\start.S

@ECHO Link
C:\utils\RISC-V_toolchain\bin\riscv-none-embed-gcc start.o debug.o timer.o main.o -Wl,-Bstatic,-T,..\rv32mod\rv32.lds,--strip-debug -ffreestanding -nostdlib -o main.elf

C:\utils\RISC-V_toolchain\bin\riscv-none-embed-objcopy -O binary main.elf main.bin

@ECHO Create VHDL file
..\rv32mod\bin2text.exe -vhd -clk -default 0 -ena -width 32 -awidth 14 main.bin -o bootloader

del *.o
del *.elf
del main.bin