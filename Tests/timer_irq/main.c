// RV32 Timer IRQ example

#include "rv32mod.h"
#include "riscv-csr.h"
#include "timer.h"

static void irq_entry(void) __attribute__ ((interrupt ("machine")));


static volatile uint64_t timestamp = 0;
static int global_value_with_init = 2000;

static uint32_t mtimecmp_increment = 0;

void main(void)
{
	uint32_t hi, lo;
	uint64_t timestamp;

	print_str("Timer IRQ Test\n");

	// Setup timer for 1 second interval
    timestamp = get_mtimer();
	timestamp+=6000;
    set_mtimer(timestamp); //MTIMER_SECONDS_TO_CLOCKS(1));
		
	// Setup the IRQ handler entry point
    csr_write_mtvec((uint32_t) irq_entry);

    // Enable MIE.MTI timer interrupt
	csr_write_mie(MIE_MTI_BIT_MASK);

    // Global interrupt enable 
	csr_write_mstatus(MSTATUS_MIE_BIT_MASK);			// 0x00000008 (bit3)
	
	
	for (;;) __asm__ volatile ("wfi"); 

	csr_write_mstatus(0);	
    
}


#pragma GCC push_options
// Force the alignment for mtvec.BASE. A 'C' extension program could be aligned to to bytes.
#pragma GCC optimize ("align-functions=4")
static void irq_entry(void)  {
    uint32_t cause = csr_read_mcause();
	
	switch (cause) {						
		case CAUSE_MTIMER_IRQ :	
			timestamp+=6000;
			set_mtimer(timestamp); //MTIMER_SECONDS_TO_CLOCKS(1));
			
			print_str("\nIRQ TMR=");
			print_hex(timestamp,8);
			print_str("\n");
			break;
		default:
			print_str(">>>> External IRQ");
			print_dec((cause>>4)&3);
			print_str("\n");
	}  
}
#pragma GCC pop_options



