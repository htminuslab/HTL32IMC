#ifndef TIMER_H
#define TIMER_H

#include <stdint.h>


#ifndef MTIME_FREQ_HZ
	#define MTIME_FREQ_HZ 24576000						// 24.576MHz 
#endif

#define MTIMER_SECONDS_TO_CLOCKS(SEC)         \
    ((uint64_t)(((SEC)*(MTIME_FREQ_HZ))))

#define MTIMER_MSEC_TO_CLOCKS(MSEC)           \
    ((uint64_t)(((MSEC)*(MTIME_FREQ_HZ))/1000))

#define MTIMER_USEC_TO_CLOCKS(USEC)           \
    ((uint64_t)(((USEC)*(MTIME_FREQ_HZ))/1000000))

void set_mtimer(uint64_t clock_offset);
uint64_t get_mtimer(void);
            
#endif // #ifdef TIMER_H

