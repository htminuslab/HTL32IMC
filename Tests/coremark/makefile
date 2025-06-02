USE_MYSTDLIB = 0
OBJS = core_main.o core_list_join.o core_matrix.o core_portme.o core_state.o core_util.o ee_printf.o timer.o debug.o start.o
CFLAGS = -MD -Os -mabi=ilp32 -march=rv32imc -I./ -I./barebones -I../rv32mod/ -IC:/utils/RISC-V_toolchain/riscv-none-embed/include \
-DITERATIONS=$(ITERATIONS) -DFLAGS_STR=\"$(FLAGS_STR)\" 
TOOLCHAIN_PREFIX = riscv-none-embed-
CFLAGS += -ffreestanding -nostdlib
CC      = $(TOOLCHAIN_PREFIX)gcc

ITERATIONS     = 1        # Iterations of CoreMark
FLAGS_STR      = "-MD -Os -mabi=ilp32 -march=rv32imc"

core_main.bin: core_main.elf
	$(TOOLCHAIN_PREFIX)objcopy -O binary  $< $@
	$(TOOLCHAIN_PREFIX)size --format=berkeley core_main.elf
	$(TOOLCHAIN_PREFIX)objcopy -O binary core_main.elf core_main.bin
	../rv32mod/bin2text.exe -vhd -default 0 -clk -ena -width 32 -awidth 14 core_main.bin -o bootloader


core_main.elf: $(OBJS) 
	$(TOOLCHAIN_PREFIX)gcc $(CFLAGS) -Wl,-Bstatic,-T,..\rv32mod\rv32.lds,--strip-debug -o $@ $(OBJS) 
	$(TOOLCHAIN_PREFIX)objdump -drwx -S core_main.elf > core_main.asm

%.o: barebones/%.c
	$(TOOLCHAIN_PREFIX)gcc -c $(CFLAGS) $<

%.o: %.c
	$(TOOLCHAIN_PREFIX)gcc -c $(CFLAGS) $<

%.o: ../rv32mod/%.c
	$(TOOLCHAIN_PREFIX)gcc -c $(CFLAGS) $<

%.o: ../rv32mod/%.S
	$(TOOLCHAIN_PREFIX)gcc -c $(CFLAGS) $<

core_main.o: CFLAGS += -Wno-implicit-int -Wno-implicit-function-declaration

clean:
	del /Q /S *.o *.d core_main.elf core_main.map core_main.bin core_main.asm bootloader.vhd

.PHONY: test clean

-include *.d
