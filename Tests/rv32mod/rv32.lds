/**********************************************************************************************
 HTLRV32 Linker script
 HT-LAB 11 2020
**********************************************************************************************/
MEMORY
{
  text    (rx!w) : ORIGIN = 0x40000000, LENGTH = 72K
  data    (rw!x) : ORIGIN = 0x00000000, LENGTH = 32K 
  IO      (rw!x) : ORIGIN = 0x80000000, LENGTH = 8K
}

start = 0;

SECTIONS
{
   /* __stack = 0x201000; */

    .text :
    {
        . = 0x00000000;
/*        *(.startup)
        KEEP (*(.startup))
        . = 0x00000020;
        *(.startirq)
        KEEP (*(.startirq)) */
		
		start*(.text);
        . = ALIGN(4);
        *(.text)           			/* .text sections (code) */
        *(.text*)          			/* .text* sections (code) */
        *(.rodata)         			/* .rodata sections (constants, strings, etc.) */
        *(.rodata*)        			/* .rodata* sections (constants, strings, etc.) */
        *(.srodata)        			/* .rodata sections (constants, strings, etc.) */
        *(.srodata*)       			/* .rodata* sections (constants, strings, etc.) */
        . = ALIGN(4);
          
        _etext = .;                 /* define a global symbol at end of code */
        _sidata = _etext;           /* This is used by the startup in order to initialize the .data section */
	
    } > text

    .data :
    {		
		. = ALIGN(4);
        __data_start = . ;			/* Global start of data symbol used by start.S */

        . = ALIGN(4);
        *(.data)           			/* .data sections */
        *(.data*)         		 	/* .data* sections */
        *(.sdata)           		/* .sdata sections */
        *(.sdata*)          		/* .sdata* sections */
		/* *(.rela*) */
        . = ALIGN(4);

		/* __global_pointer$ = . + 0x800;  */

        __data_end = . ;       	 	/* Global end of data symbol used by start.S */
    } > data AT>text

    .bss :
    {
        __bss_start = . ;			/* Global start of bss symbol used by start.S */
        *(.bss)
        *(.dynsbss)
        *(.sbss .sbss.* .gnu.linkonce.sb.*)
        *(.scommon)
        __bss_end = . ;				/* Global end of bss symbol used by start.S */
		
        /*start_of_stack = . ; */
        _edata = .;
        _end = .;
    } > data AT>text

	
	PROVIDE ( _stack = ORIGIN(data) + LENGTH(data) );
	
}