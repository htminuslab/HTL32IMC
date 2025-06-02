//---------------------------------------------------------------------------
//                                                                           
//    EXE to Hex converted
//    Copyright (C) 2010 HT-LAB                                           
//                                                                           
//---------------------------------------------------------------------------

#ifndef _BIN2TEXT_
#define _BIN2TEXT_		1

#define  MAJOR_VERSION 	0
#define  MINOR_VERSION 	05

#define  DEBUGEXTRA		debug & 0x1000

#define  FALSE        	0
#define  TRUE         	!FALSE

#define  MAX_STRING		80
#define  MAX_NAME     	20

#define  BUFFER_SIZE   	(512*1024)						// 512Kbyte for program EXE processing

#include <stdio.h>	
#include <ctype.h> 
#include <stdlib.h>   
#include <malloc.h>
#include <math.h>
#include <string.h>
#include <assert.h>

#if defined(_MSC_VER)
	typedef signed char    int8_t;
	typedef signed short   int16_t;
	typedef signed long    int32_t;
	typedef unsigned char  uint8_t;
	typedef unsigned short uint16_t;
	typedef unsigned long  uint32_t; 
	#include <time.h> 
#else
	#include <stdint.h> 
	#include <unistd.h>
	#include <sys/time.h>
#endif 

int conv2mem(FILE *fp, char *outfilename, int filelength, int width, int bytesel, uint16_t segment, uint16_t offset);
int conv2binstr(FILE *fp, char *outfilename, int width, int awidth);
int conv2mif(FILE *fp, char *outfilename);
int conv2mifgowin(FILE *fp, char *outfilename, int awidth);
int conv2mif32b(FILE *fp, char *outfilename, uint32_t offset);
int conv2case(FILE *fp, char *outfilename, int filelength, int width, int awidth, int syncout, int enarom,int enareset, char defaultchar);
void conv2case_header(FILE *fpw, char * entityname, int width, int msb, int syncout, int enarom, int enareset);
void conv2case_tail(FILE *fpw, int width, int syncout, int enarom, char defaultchar);
void conv_binary(char *s, int word, int len);
int conv2hex(FILE *fp, char *outfilename, uint16_t segment, uint16_t offset, int iprec, uint16_t ip);
void conv2hex_segm_rec(char *strwr, uint16_t segment);
void conv2hex_data_rec(char *strwr, unsigned char *mem_ptr, uint16_t addr, int len);
void conv2hex_csip_rec(char * strwr, uint16_t cs, uint16_t ip);
char * byte2hexstring(unsigned char b);
void usage_exit(void);

#endif
