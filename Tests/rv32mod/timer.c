
#include "timer.h"
#include "riscv-csr.h"

static inline void csr_write_mtimecmp(uint32_t value) {
    __asm__ volatile ("csrw    0x803, %0" 
                      : /* output: none */ 
                      : "r" (value) /* input : from register */
                      : /* clobbers: none */);
}

static inline void csr_write_mtimecmph(uint32_t value) {
    __asm__ volatile ("csrw    0x883, %0" 
                      : /* output: none */ 
                      : "r" (value) /* input : from register */
                      : /* clobbers: none */);
}

// mtime compare is mapped on custom CSR registers 803 and 883
void set_mtimer(uint64_t clock_offset) {
    // First of all set 
    uint64_t new_mtimecmp = get_mtimer() + clock_offset;

    // AS we are doing 32 bit writes, an intermediate mtimecmp value may cause spurious interrupts.
    // Prevent that by first setting the dummy MSB to an unachievable value
    //*mtimecmph = 0xFFFFFFFF;  // cppcheck-suppress redundantAssignment
	csr_write_mtimecmph(0xFFFFFFFF);
    // set the LSB
    csr_write_mtimecmp((uint32_t)(new_mtimecmp & 0x0FFFFFFFFUL));
    // Set the correct MSB
    csr_write_mtimecmph((uint32_t)(new_mtimecmp >> 32)); // cppcheck-suppress redundantAssignment

}
 
// Read the raw time of the system timer in system timer clocks
uint64_t get_mtimer(void) 
{
    uint32_t mtimeh_val;
    uint32_t mtimel_val;
    do {
        // There is a small risk the mtimeh will tick over after reading mtimel
        mtimeh_val = csr_read_timeh();
        mtimel_val = csr_read_time();
        // Poll mtimeh to ensure it's consistent after reading mtimel
        // The frequency of mtimeh ticking over is low
    } while (mtimeh_val != csr_read_timeh());
    return (uint64_t) ( ( ((uint64_t)mtimeh_val)<<32) | mtimel_val);
} 
