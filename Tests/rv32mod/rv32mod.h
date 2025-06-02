#pragma once

#include <stdint.h>
#include <stdbool.h>

#define ESC						0x1B								// Triggers Stop during simulation

#define CAUSE_MTIMER_IRQ	 	0x80000000		

#define RXHOLD0_C   			0x80000000							// UART0
#define TXHOLD0_C   			0x80000004							//
#define IRQENA0_C   			0x80000008							// Interrupt Enable Register
#define STATUS0_C   			0x8000000C							// Status Register
				
#define RXHOLD1_C   			0x80000010							// UART1
#define TXHOLD1_C   			0x80000014							//
#define IRQENA1_C   			0x80000018							// Interrupt Enable Register
#define STATUS1_C   			0x8000001C							// Status Register

#define CONFIG_PORT_C  			0x80000070							// Write Only, QPI, LED(4:0)	
#define STATUS_PORT_C  			0x80000070							// Read Only

// No hardware, just a virtual port
#define OUTPORT 				0x80000080							// Debug port
#define TDRE					0x01
#define RDRF					0x02		
#define TDRE_IRQ				0x01
#define RDRF_IRQ				0x02

// Read Status register bits
#define RDRF_CODEC				0x01								// Codec Receive Data Register Full
#define LRCK_CODEC				0x02								// Left/Right Channel

#define WRITE_PORT(port, data) 	*((volatile uint32_t*)port) = data	// data can be byte/word/dword
#define READ_PORT(port) 	    (*((volatile uint32_t*)port))


void *memcpy(void *aa, const void *bb, long n);
void print_chr(char ch);
void print_str(const char *p);
void print_dec(unsigned int val);
void print_hex(unsigned int val, int digits);

void write_uart0(char ch);											// Blocking write to UART0
uint8_t read_uart0(void);											// Blocking read from UART0
void write_uart1(char ch);											// Blocking write to UART1
uint8_t read_uart1(void);	
void print_str_uart0(const char *p);
void print_str_uart1(const char *p);
