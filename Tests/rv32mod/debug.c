//-------------------------------------------------------------------------------------------------
// HTLRV32 Debug routines
//
//
//-------------------------------------------------------------------------------------------------
#include "rv32mod.h"

void *memcpy(void *aa, const void *bb, long n)
{
	char *a = aa;
	const char *b = bb;
	while (n--) *(a++) = *(b++);
	return aa;
}

void print_chr(char ch)
{
	*((volatile uint8_t*)OUTPORT) = ch;
}

void print_str(const char *p)
{
	while (*p != 0)	*((volatile uint8_t*)OUTPORT) = *(p++);
}

void print_dec(unsigned int val)
{
	char buffer[10];
	char *p = buffer;
	while (val || p == buffer) {
		*(p++) = val % 10;
		val = val / 10;
	}
	while (p != buffer) *((volatile uint8_t*)OUTPORT) = '0' + *(--p);
}

void print_hex(unsigned int val, int digits)
{
	for (int i = (4*digits)-4; i >= 0; i -= 4)
		*((volatile uint8_t*)OUTPORT) = "0123456789ABCDEF"[(val >> i) % 16];
}

void write_uart0(char ch)											// Blocking write to UART0
{
	while (!(READ_PORT(STATUS0_C)&TDRE));
	WRITE_PORT(TXHOLD0_C,ch);
}

uint8_t read_uart0(void)											// Blocking read from UART0
{
	while (!(READ_PORT(STATUS0_C)&RDRF));
	return READ_PORT(RXHOLD0_C);
}

void write_uart1(char ch)											// Blocking write to UART1
{
	while (!(READ_PORT(STATUS1_C)&TDRE));
	WRITE_PORT(TXHOLD1_C,ch);
}

uint8_t read_uart1(void)											// Blocking read from UART1
{
	while (!(READ_PORT(STATUS1_C)&RDRF));
	return READ_PORT(RXHOLD1_C);
}


void print_str_uart0(const char *p)
{
	while (*p != 0)	{
		write_uart0(*(p++));
	}
}

void print_str_uart1(const char *p)
{
	while (*p != 0)	{
		write_uart1(*(p++));
	}
}