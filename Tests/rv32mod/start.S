#--------------------------------------------------------------------------------------------------
# Adapted from Clifford Wolf PicoRV32 and Gowin's RISC-V core
#--------------------------------------------------------------------------------------------------
# HT-LAB Nov 2022
#--------------------------------------------------------------------------------------------------

		.section .text
		.global irq
		.global main


reset_vec:										
		j start

#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
.balign 16

#--------------------------------------------------------------------------------------------------
#  Main program
#--------------------------------------------------------------------------------------------------
start:
	
		# set stack pointer to top region of 32KByte SRAM region starting at address 0x7B80 (stack -1 address, then write?)
		# loads a 20bit immediate value into the upper 20 bits and fill the rest with 0's 
		#lui sp,(32*1024)>>12
		li sp, 0x00007B80
		
		
		# Copy data section (initialized variables) from FLASH to RAM
		la a0, _sidata
		la a1, __data_start 
		la a2, __data_end
		bge a1, a2, end_init_data
loop_init_data:
		lw a3, 0(a0)
		sw a3, 0(a1)
		addi a0, a0, 4
		addi a1, a1, 4
		blt a1, a2, loop_init_data
end_init_data:
		
		# zero initialize bss section
		la a0, __bss_start
		la a1, __bss_end
		bge a0, a1, end_init_bss
loop_init_bss:
		sw zero, 0(a0)
		addi a0, a0, 4
		blt a0, a1, loop_init_bss
end_init_bss:		
				
	
		# Call main 
		jal ra,main
	
		# trap, change to restart??
		ebreak
