// RV32 Hello World Test
// Send string to ?

#include "rv32mod.h"

void main(void)
{
	uint32_t hi, lo;
	uint64_t ct;
	
	char str[]="** Hello World **\n";

	// Print to Debug port
	print_str(str);


	// Print to UART
    char str2[]="UART0 alive\n\r.....";
	print_str_uart0(str2);

	// End simulation
	__asm__ volatile ("ebreak");
}
