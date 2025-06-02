/***********************************************************************************
 File name      :  bin2text.c            
                                             
 Purpose        :  Convert Binary file into various text formats        

 Note           :   

 Authors        :  HT-LAB

 Reference      :   

 Note           :  https://github.com/htminuslab       
 
 -----------------------------------------------------------------------------------
 Version  Author   Date        Changes
 0.1      HABT     30 Jan 10   First Version
 0.2      HABT     30 Aug 14   Update to mem section
 0.3      HABT     20 Sep 14   Add mif support
 0.4      HABT     19 Nov 18   Fixed bad "when (!feof(fp))" construct
 0.5      HABT     26 Mar 22   Added mif32b, 32bits written to 4 byte files
 0.6      HABT     22 May 22   Added awidth, use 0 for calculate size
 0.7      HABT     29 May 22   Added Gowin HEX mif support
 0.8      HABT 	   04 Sep 22   Added -ena to VHDL case statement
 0.9      HABT     26 Sep 24   Added reset
 1.0      HABT     18 May 25   Added default vhdl case option
************************************************************************************/

#include "bin2text.h"

int debug=0x0000;                                       // Default limited debug
int quiet=FALSE;                                        // Quiet off by default (show info)
//int verbose=FALSE;                                      // Default off
    

int main(int argc, char * argv[])
{
    int i=1;                                            // Command Line Arguments
    int n,m;
    int quit;
    int filelength;
    FILE *fp=NULL;                                      // Input Filename

	int awidth=0;                                       // CASE format option, Addressbus width, default determine size
    int width=8;                                        // CASE format option, Databus width
	int fileoffset=0;									// File offset

    uint16_t segment=0;                                 // Memory format
    uint32_t offset=0;
	uint16_t ip=0;
	int enarom=FALSE;
	char defaultchar='-';								// when (others => '-')
	int bytesel=FALSE;
	int iprec=FALSE;									// True if execute address is specified (hex)

    int arrayformat=FALSE;                              // Command line options
    int caseformat=FALSE;
    int hexformat=FALSE;                                // Default to Binary format
    int memformat=FALSE;                                // Default to Binary format
	int binstrformat=FALSE;                             // Default to binary string
    int mifformat=FALSE;								// Default to Binary format
	int mifgowinformat=FALSE;						    // Gowin HEX mif format
	int mif32bformat=FALSE;
	int syncout=FALSE;                                  // Default to non-registered output
    int enareset=FALSE;									// Default no async reset
	
    char binfilename[80]="";                            // BIN input file
    char outfilename[80]="";                      		// Output filename
    
    //------------------------------------------------------------------------------
    // Processing Command line argument(s) 
    //------------------------------------------------------------------------------
    while((argc-1)>=i)  {       
        if(strcmp(argv[i],"-q")==0) {                   // quiet mode
            quiet=TRUE;                                 // Do not diplay headers and stuff
            i++;
        } else 
        if(strcmp(argv[i],"-o")==0) {                  // Specify Output filename 
            if ((argc-1)>=i) strcpy(outfilename,argv[++i]);        
                else usage_exit();            
            i++;
        } else
        if(strcmp(argv[i],"-vhd")==0) {                // Select VHDL case format
            caseformat=TRUE;                             
            i++;
        } else 
        if (strcmp(argv[i],"-hex")==0) {                 // Select Intel HEX format
            hexformat=TRUE;                             
            i++;
        } else 
		if (strcmp(argv[i],"-mif")==0) {                 // Xilinx memory format (8 bits only)
            mifformat=TRUE;                             
            i++;
        } else 
		if (strcmp(argv[i],"-mifgowin")==0) {            // Gowin HEX mif format (32 bits only)
            mifgowinformat=TRUE;                             
            i++;
        } else 		
		if (strcmp(argv[i],"-mif32b")==0) {              // Xilinx memory format (32bits in 4 byte files)
            mif32bformat=TRUE;                             
            i++;
        } else 
        if (strcmp(argv[i],"-array")==0) {               // Select .h array format
            arrayformat=TRUE;                             
            i++;
        } else 
        if (strcmp(argv[i],"-ena")==0) {                 // Add enabled to vhdl case statement
            enarom=TRUE;                             
            i++;
        } else 
		if (strcmp(argv[i],"-default")==0) {            	// Use when (others => char)  in VHDL case statement
			if ((argc-1)>i) {
               defaultchar=argv[++i][0];
            } else usage_exit();              
            i++;
        } else 
        if (strcmp(argv[i],"-mem")==0) {                 // Andre' Klindworth Memory format
            memformat=TRUE;                             
            i++;
        } else 
        if(strcmp(argv[i],"-binstr")==0) {              // Simple binary string
            binstrformat=TRUE;                             
            i++;
        } else 						
        if(strcmp(argv[i],"-byte")==0) {                // select byte format, create 2 files if width=16
            bytesel=TRUE;                             
            i++;
        } else                     
        if(stricmp(argv[i],"-seg")==0) {                // Segment, default to 0, used in memory format
            if ((argc-1)>i) {
                sscanf(argv[++i],"%X",&segment);
            } else usage_exit();              
            i++;
        } else
        if(stricmp(argv[i],"-off")==0) {                // Offset, default to 0, used in memory format
            if ((argc-1)>i) {
                sscanf(argv[++i],"%X",&offset);
            } else usage_exit();              
            i++;
        } else

		if(strcmp(argv[i],"-ip")==0) {		   			// Specify Execute Address used for hex format			
			if ((argc-1)>i) {
		    	sscanf(argv[++i],"%X",&ip);				
				iprec=TRUE;
			} else usage_exit();			  
			i++;
	    } else 

        if(strcmp(argv[i],"-width")==0) {               // Databus Width, used for case format
            if ((argc-1)>i) width=(int)strtol(argv[++i],NULL,0);
                else usage_exit();            
            i++;
        } else
		if(strcmp(argv[i],"-awidth")==0) {               // Addressbus Width, used for case format
            if ((argc-1)>i) awidth=(int)strtol(argv[++i],NULL,0);
                else usage_exit();            
            i++;
        } else
        if(strcmp(argv[i],"-clk")==0) {                 // Add synchronous output, used for case format
            syncout=TRUE;                             
            i++;
        } else 
        if(strcmp(argv[i],"-reset")==0) {               // Add asynchronous reset
            enareset=TRUE;
			syncout=TRUE;     							// Always need clock for reset                         
            i++;
        } else 			
        if(stricmp(argv[i],"-fileoff")==0) {            // File Offset, default to 0, used in case format
            if ((argc-1)>i) {
                sscanf(argv[++i],"%X",&fileoffset);
            } else usage_exit();              
            i++;
        } else

        if(strcmp(argv[i],"-h")==0) {                   // Show help
            usage_exit();       
        } else {
            if ((argc-1)>=i && argv[i][0]!='-') strcpy(binfilename,argv[i++]); 
            else usage_exit();
        }                                               // Show usage and exit
    } 
    
    if (strlen(binfilename)==0) usage_exit();
    if (!caseformat && !hexformat && !arrayformat && !memformat && 
	    !mifformat && !mif32bformat &&!mifgowinformat && !binstrformat) usage_exit();
    

    //------------------------------------------------------------------------------
    // Create output filename
    // If -o is not specified then use bin base filename
    //------------------------------------------------------------------------------
    if (strchr(binfilename,'.')==NULL) {                // No .bin extension given?
        strcat(binfilename,".bin");                     // Add .bin extension
    } 
    if (strlen(outfilename)==0) {                       // -o not given
        strncpy(outfilename,binfilename,(strchr(binfilename,'.')-binfilename));
    } else {                                            // Remove file extension!
        if (strchr(outfilename,'.')!=NULL) { 
            n=strchr(outfilename,'.')-outfilename;          
            outfilename[n]='\0';                        // Terminate string at the '.'
        }
    }


    if (!quiet) {
        printf("\nBIN2TEXT Ver %d.%d May 2024 (c) HT-LAB\n\n",MAJOR_VERSION,MINOR_VERSION);
        printf("Input BIN file          : %s\n",binfilename);
    }


    //------------------------------------------------------------------------------
    // Open BIN file and determine size  
    //------------------------------------------------------------------------------
    if ((fp=fopen(binfilename,"rb"))==NULL) {           // open file
        fprintf(stderr, "\nError cannot open BIN input file : %s\n",binfilename);
        return 1;
    }
    fseek(fp,0L,SEEK_END);                              // Seek until end of file
    filelength=ftell(fp);                               // EOF marker added?
    if (!quiet) {
    	printf("Total Filesize          : %d bytes\n",filelength);
		printf("File Offset             : 0x%x (%d bytes)\n",fileoffset,fileoffset);
		printf("Output Offset           : 0x%x (%d bytes)\n",offset,offset);
	}
   // rewind(fp);
	fseek(fp,(long)fileoffset,SEEK_SET);
	filelength-=fileoffset;


    if (caseformat) conv2case(fp,outfilename,filelength,width,awidth,syncout,enarom,enareset,defaultchar);

    if (memformat) conv2mem(fp,outfilename,filelength,width,bytesel,segment,(uint16_t)offset);

	if (hexformat) conv2hex(fp,outfilename,segment,(uint16_t)offset,iprec,ip);
       
	if (mifformat)      conv2mif(fp,outfilename);
	if (mif32bformat)   conv2mif32b(fp,outfilename,offset);
	if (mifgowinformat) conv2mifgowin(fp,outfilename,awidth);
	
	if (binstrformat)   conv2binstr(fp,outfilename,width,awidth);
	 
    if (!quiet) printf("\nDone....\n");

    return 0;
}


//==================================================================================
// Convert to Andre' Klindworth Memory format memory format
//     Format:  decimal_address binary_data
//     example: 0 0110001100 
//              1 0100110011
//              2 0110110101 text ignored
//  If byte format specified then create 2/4 files for word/dword                                                         
//==================================================================================
int conv2mem(FILE *fp, char *outfilename, int filelength, int width, int bytesel, uint16_t segment, uint16_t offset)
{
    FILE *fpw0=NULL;
    FILE *fpw1=NULL;
    FILE *fpw2=NULL;
    FILE *fpw3=NULL;
	
    char fname[80]="";
    char strwr[100]="";

	uint32_t addr=0;
    unsigned char byte[4];
	int len;
   
    //------------------------------------------------------------------------------
    // Do some checks 
    //------------------------------------------------------------------------------
    if (width!=8 && width!=16 && width!=32) {
        fprintf(stderr, "\nError only 8, 16 or 32 databus bits are supported\n");
        return 1;
    }
	// if (bytesel && (width!=16 || width!=32)) {
        // fprintf(stderr, "\nError byte argument only valid for 16 bits databus\n");
        // return 1;
	// }


	if (bytesel && (width==16 || width==32)) {
	
	    //--------------------------------------------------------------------------
	    // Open Output memory file LSB
	    //--------------------------------------------------------------------------
	    strcpy(fname,outfilename);
	    strcat(fname,"0.dat");
	    if ((fpw0=fopen(fname,"wt"))==NULL) {          
	        fprintf(stderr, "\nError cannot open output file : %s\n",fname);
	        return 1;
	    }
		if (!quiet) printf("Output Filename0        : %s\n",fname);
		
	    //--------------------------------------------------------------------------
	    // Open Output memory file MSB
	    //--------------------------------------------------------------------------
	    strcpy(fname,outfilename);
	    strcat(fname,"1.dat");
	    if ((fpw1=fopen(fname,"wt"))==NULL) {          
	        fprintf(stderr, "\nError cannot open output file : %s\n",fname);
	        return 1;
	    }
		if (!quiet) printf("Output Filename1        : %s\n",fname);
 
		if (width==32) {
		
			//--------------------------------------------------------------------------
			// Open Output memory file 2
			//--------------------------------------------------------------------------
			strcpy(fname,outfilename);
			strcat(fname,"2.dat");
			if ((fpw2=fopen(fname,"wt"))==NULL) {          
				fprintf(stderr, "\nError cannot open output file : %s\n",fname);
				return 1;
			}
			if (!quiet) printf("Output Filename2        : %s\n",fname);
			
			//--------------------------------------------------------------------------
			// Open Output memory file 3
			//--------------------------------------------------------------------------
			strcpy(fname,outfilename);
			strcat(fname,"3.dat");
			if ((fpw3=fopen(fname,"wt"))==NULL) {          
				fprintf(stderr, "\nError cannot open output file : %s\n",fname);
				return 1;
			}
			if (!quiet) printf("Output Filename3        : %s\n",fname);
		}
		
	} else {
	    //--------------------------------------------------------------------------
	    // Open single Output memory file
	    //--------------------------------------------------------------------------
	    strcat(outfilename,".dat");
	    if ((fpw0=fopen(outfilename,"wt"))==NULL) {          
	        fprintf(stderr, "\nError cannot open output file : %s\n",outfilename);
	        return 1;
	    }
		if (!quiet) printf("Output Filename         : %s\n",outfilename);
	}

    if (!quiet) {
        printf("Databus width           : %d bits\n",width);
		if (bytesel) printf("File width              : 8 bits\n");
    }

	addr=(segment*16)+offset; //// doesn't work under win64???????????????????????????
	//addr=0;
	
	if (addr&0x01) {
	  fprintf(stderr, "\nError offset must be on word boundary (addr=%05lX)",addr);
	  printf("\nSegment Address         : 0x%04X\n",segment);
	  printf("Offset Address          : 0x%04X\n",offset);
	  printf("Flat Address            : 0x%05lX\n",addr);
	  return 1;
	} else if (!quiet) {   
		printf("Segment Address         : 0x%04X\n",segment);
		printf("Offset Address          : 0x%04X\n",offset);
		printf("Flat Address            : 0x%05lX\n",addr);
	}
	
   	if (width==16) addr=addr>>1;                           		// word
	if (width==32) addr=addr>>2;                           		// DWORD

	while ( (!feof(fp)) ) {// change 

		if (width==32) {
			len=fread(byte,sizeof(unsigned char),4,fp);			// read DWORD
			if (len!=4) break; // result in last bytes left but also prevent file overflow
		} else if (width==16) {
			len=fread(byte,sizeof(unsigned char),2,fp);			// read Word
			if (len!=2) break;
		} else {
			len=fread(byte,sizeof(unsigned char),1,fp);			// read Byte
			if (len!=1) break;
		}

		if (bytesel) {											// Byte only true for 2 files
			if (width==32) {
				fprintf(fpw3,"%lu ",addr);
				fprintf(fpw2,"%lu ",addr);
				fprintf(fpw1,"%lu ",addr);
			} else {
				fprintf(fpw1,"%lu ",addr);
			}
		}
		fprintf(fpw0,"%lu ",addr);

		if (bytesel && width==32) {
			conv_binary(strwr, byte[3],8); fprintf(fpw3,"%s\n",strwr); // convert to 4 8-byte files
			conv_binary(strwr, byte[2],8); fprintf(fpw2,"%s\n",strwr);   
			conv_binary(strwr, byte[1],8); fprintf(fpw1,"%s\n",strwr);   
			conv_binary(strwr, byte[0],8); fprintf(fpw0,"%s\n",strwr);  
		} else if (width==32) {
			conv_binary(strwr, byte[3],8); fprintf(fpw0,"%s",strwr);   // convert 32-bits data
			conv_binary(strwr, byte[2],8); fprintf(fpw0,"%s",strwr);   
			conv_binary(strwr, byte[1],8); fprintf(fpw0,"%s",strwr);   
			conv_binary(strwr, byte[0],8); fprintf(fpw0,"%s\n",strwr);   
		} else if (bytesel && width==16) { 
			conv_binary(strwr, byte[1],8); fprintf(fpw1,"%s\n",strwr); // convert data to binary
			conv_binary(strwr, byte[0],8); fprintf(fpw0,"%s\n",strwr);   
		} else if (width==16) {
			conv_binary(strwr, byte[1],8); fprintf(fpw0,"%s",strwr);   // convert 16-bits data
			conv_binary(strwr, byte[0],8); fprintf(fpw0,"%s\n",strwr);   
		} else {
			conv_binary(strwr, byte[0],8); fprintf(fpw0,"%s\n",strwr); // convert 8-bits data
		}
		addr++;
	}

	if (bytesel && width==32) {
		fclose(fpw3);
		fclose(fpw2);
	}
	if (bytesel) fclose(fpw1);
    fclose(fpw0);
    return 0;
}


//==================================================================================
// Convert to simple binary string format
//==================================================================================
int conv2binstr(FILE *fp, char *outfilename, int width, int awidth)
{
    FILE *fpw=NULL;
    unsigned int addr=0;
	int maxaddr=0;
    uint8_t byte[8];
    char str[MAX_STRING]="";
	int width_in_bytes=0;

    //------------------------------------------------------------------------------
    // Open Output bin string file 
    //------------------------------------------------------------------------------
    strcat(outfilename,".mem");
    if ((fpw=fopen(outfilename,"wt"))==NULL) {          
        fprintf(stderr, "\nError cannot open output file : %s\n",outfilename);
        return 1;
    }
    
    if (!quiet) printf("Output bin string file  : %s\n",outfilename);

	switch(width) {
		case 8 :width_in_bytes=1; break; 
		case 16:width_in_bytes=2; break; 
		case 32:width_in_bytes=4; break; 
		default: 
			fprintf(stderr, "\nError only 8, 16 or 32 width options are supported\n");
			return 1;
    }
    
	//-------------------------------------------------------------------------------
    // Determine Max address, awidth given in bits
    //-------------------------------------------------------------------------------
	if (awidth==0) {
		printf("\nInvalid awidth %d\n",awidth);
		return 1;
	}
	maxaddr=(int)pow(2.0,(double)awidth);
	if (!quiet) printf("Memory Block Size       : %d bytes\n",maxaddr);
	
	while (fread(byte,sizeof(unsigned char),width_in_bytes,fp)==width_in_bytes) {
	
		switch(width) {
			case 8 :conv_binary(str, byte[0],8); fprintf(fpw,"%s\n",str); addr++; break; 
			case 16:conv_binary(str, byte[1],8); fprintf(fpw,"%s",str);
			        conv_binary(str, byte[0],8); fprintf(fpw,"%s\n",str);  addr+=2; break; 
			default:conv_binary(str, byte[3],8); fprintf(fpw,"%s",str);
					conv_binary(str, byte[2],8); fprintf(fpw,"%s",str);
					conv_binary(str, byte[1],8); fprintf(fpw,"%s",str);
					conv_binary(str, byte[0],8); fprintf(fpw,"%s\n",str);addr+=4; 
		}

		if (addr>=maxaddr) break;
       
    } 

	if (!quiet) printf("Bytes written           : %d\n",addr);
	
    fclose(fpw);
    return 0;
}



//==================================================================================
// Convert to mif format
//==================================================================================
int conv2mif(FILE *fp, char *outfilename)
{
    FILE *fpw=NULL;
    unsigned int addr=0;
    uint8_t byte[8];
    char str[MAX_STRING]="";

    //------------------------------------------------------------------------------
    // Open Output mif file 
    //------------------------------------------------------------------------------
    strcat(outfilename,".mif");
    if ((fpw=fopen(outfilename,"wt"))==NULL) {          
        fprintf(stderr, "\nError cannot open output file : %s\n",outfilename);
        return 1;
    }
    
    if (!quiet) {
        printf("Output mif file         : %s\n",outfilename);
        printf("Databus size            : 8 bits\n");			// Fixed!
    }
    
    while ((!feof(fp)) ) {
		fread(byte,sizeof(unsigned char),1,fp);
        conv_binary(str, byte[0],8);
	    fprintf(fpw,"%s\n",str);
        addr++;
    } 

	if (!quiet) {
        printf("Bytes written           : %d\n",addr);
	}
    fclose(fpw);
    return 0;
}

//==================================================================================
// Convert to Gowin mif format
//==================================================================================
int conv2mifgowin(FILE *fp, char *outfilename, int awidth)
{
	FILE *fpw=NULL;
    unsigned int addr=0;
    uint32_t word32;
	int maxaddr=0;
    char str[MAX_STRING]="";

    //------------------------------------------------------------------------------
    // Open Output mif file 
    //------------------------------------------------------------------------------
    strcat(outfilename,".mif");
    if ((fpw=fopen(outfilename,"wt"))==NULL) {          
        fprintf(stderr, "\nError cannot open output file : %s\n",outfilename);
        return 1;
    }
    
    if (!quiet) {
        printf("Output Gowin mif file   : %s\n",outfilename);
        printf("Databus size            : 32 bits\n");			// Fixed!
    }
    
	//-------------------------------------------------------------------------------
    // Determine Max address, awidth given in bits
    //-------------------------------------------------------------------------------
	if (awidth==0) {
		printf("\nInvalid awidth %d\n",awidth);
		return 1;
	}
	maxaddr=(int)pow(2.0,(double)awidth);
	if (!quiet) printf("Memory Block Size       : %d bytes\n",maxaddr);
	
	//-------------------------------------------------------------------------------
	// Write MIF header
	// #File_format=Hex 
	// #Address_depth=8 
	// #Data_width=16 
	//-------------------------------------------------------------------------------	
	fputs("#File_format=Hex\n",fpw);
	fprintf(fpw,"#Address_depth=%d\n",maxaddr);
	fputs("#Data_width=32\n",fpw);
		
    while (fread(&word32,sizeof(unsigned char),4,fp)) {		// Read 32bits
		fprintf(fpw,"%08x\n",word32);
        addr+=4;
		if (addr>maxaddr) {
			printf("\nBinary file exceeds %d ROM size\n",maxaddr);
			return 1;
		}
    } 
	
	for (int i=addr;i<maxaddr;i+=4){						// Padd remaining file with 0xFFFFFFFF
		fputs("FFFFFFFF\n",fpw);	
	}

	if (!quiet) {
        printf("Bytes written           : %d\n",addr);
	}
    fclose(fpw);
    return 0;
}

//==================================================================================
// Convert to mif32b format
//==================================================================================
int conv2mif32b(FILE *fp, char *outfilename, uint32_t offset)
{
	FILE *dfp0=NULL;
	FILE *dfp1=NULL;
	FILE *dfp2=NULL;
	FILE *dfp3=NULL;
	unsigned char byte[4];
	char strwr[100]="";
	char fname[MAX_STRING]="";
	int addr=0;
	
	strcpy(fname,outfilename);
	strcat(fname,"0.mem");  										// add default extension LSB File
	if ((dfp0=fopen(fname,"wt"))==NULL) {       					// open files
		fprintf(stderr, "\nError cannot open output file : %s\n",fname);
		return 1;
	}
	strcpy(fname,outfilename);  
	strcat(fname,"1.mem");  										
	if ((dfp1=fopen(fname,"wt"))==NULL) {       	
		fprintf(stderr, "\nError cannot open output file : %s\n",fname);
		return 1;
	}
	strcpy(fname,outfilename);  
	strcat(fname,"2.mem");  						
	if ((dfp2=fopen(fname,"wt"))==NULL) {       	
		fprintf(stderr, "\nError cannot open output file : %s\n",fname);
		return 1;
	}
	strcpy(fname,outfilename);
	strcat(fname,"3.mem");  						
	if ((dfp3=fopen(fname,"wt"))==NULL) {       	
		fprintf(stderr, "\nError cannot open output file : %s\n",fname);
		return 1;
	}	

	for (int i=0;i<offset;i++) {
		fputs("00000000\n",dfp0); fputs("00000000\n",dfp1); fputs("00000000\n",dfp2); fputs("00000000\n",dfp3);	
	}

	while (fread(byte,sizeof(unsigned char),4,fp)==4) {

		if (debug) printf("Reading %02x%02x%02x%02x\n",byte[3],byte[2],byte[1],byte[0]);
		conv_binary(strwr, byte[3],8); fputs(strwr,dfp3);	// convert data to binary
		conv_binary(strwr, byte[2],8); fputs(strwr,dfp2);	// convert data to binary
		conv_binary(strwr, byte[1],8); fputs(strwr,dfp1);	// convert data to binary
		conv_binary(strwr, byte[0],8); fputs(strwr,dfp0);	// convert data to binary
					
		addr++;
		fputs("\n",dfp0); fputs("\n",dfp1); fputs("\n",dfp2); fputs("\n",dfp3); 
   } 
   
   if (offset) printf("Skipped %x bytes, then filled for %d location\n",offset, addr-1);
          else printf("Filled first %d location\n", addr-1);
   

   fclose(dfp0);
   fclose(dfp1);
   fclose(dfp2);
   fclose(dfp3);
   return 0;
}	
	

//==================================================================================
// Convert to VHDL case statement
//==================================================================================
int conv2case(FILE *fp, char *outfilename, int filelength, int width, int awidth, int syncout, int enarom, int enareset, char defaultchar)
{
    FILE *fpw=NULL;
    int addrmsb;
    unsigned int addr=0;
    uint8_t byte[8];
    char str[MAX_STRING]="";
    char entityname[MAX_STRING]="";

    strcpy(entityname,outfilename);                     // Make entity name equal to the output filename

    //------------------------------------------------------------------------------
    // Open Output VHDL file 
    //------------------------------------------------------------------------------
    strcat(outfilename,".vhd");
    if ((fpw=fopen(outfilename,"wt"))==NULL) {          
        fprintf(stderr, "\nError cannot open output file : %s\n",outfilename);
        return 1;
    }
    
    if (!quiet) {
        printf("Output VHDL file        : %s\n",outfilename);
        printf("Databus size            : %d bits\n",width);	
		printf("Default case            : (when others =>\'%c\')\n",defaultchar);				
        if (syncout) printf("Registered output       : enabled\n");
    }

    //------------------------------------------------------------------------------
    // Do some checks 
    //------------------------------------------------------------------------------
    if (width!=8 && width!=16 && width!=32 ) {
        fprintf(stderr, "\nError only 8, 16 or 32 databus bits are supported\n");
        return 1;
    }

    //------------------------------------------------------------------------------
    // Determine Max address unless awidth!=0
    //------------------------------------------------------------------------------
    if (awidth) {
		addrmsb=awidth;
		if (!quiet) printf("Address size            : %d bits\n",awidth);
	} else {
		addrmsb=(int)(log((double)filelength)/log(2.0));
	}	
    if (!quiet) {
		printf("MSB Address             : A%d\n",addrmsb);
		printf("Read Enable             : %s\n",enarom ? "Added":"Not Added"); 
		if (enareset) printf("Reset                   : enabled\n"); 
	}

    conv2case_header(fpw,entityname,width,addrmsb,syncout,enarom,enareset);     // Write VHDL Header section
    
    while ((!feof(fp)) ) {

        if (width==8) {
            fread(byte,sizeof(unsigned char),1,fp);
            conv_binary(str, addr,addrmsb+1);
        } else if (width==16) {
            fread(byte,sizeof(unsigned char),2,fp);
            conv_binary(str, addr,addrmsb);
        } else {
            fread(byte,sizeof(unsigned char),4,fp);
            conv_binary(str, addr,addrmsb-1);
        }
        fprintf(fpw,"\n\t\t\t\twhen %c%s%c  => dbus <= X%c",34,str,34,34);
        
        if (width==8) {                      
            fprintf(fpw,"%02X",byte[0]);
        } else if (width==16) {
            fprintf(fpw,"%02X%02X",byte[1],byte[0]);
        } else {
            fprintf(fpw,"%02X%02X%02X%02X",byte[3],byte[2],byte[1],byte[0]);
        }

        fprintf(fpw,"%c;",34);
        addr++;
    } 

    conv2case_tail(fpw,width,syncout,enarom,defaultchar);                  // Write VHDL tail section

    fclose(fpw);
    return 0;
}

//----------------------------------------------------------------------------------
// Write conv2case VHDL header
//----------------------------------------------------------------------------------
void conv2case_header(FILE *fpw, char * entityname, int width, int msb, int syncout, int enarom, int enareset)
{
    char   strwr[80]="";

    fputs("-------------------------------------------------------------------------------\n",fpw);
    fprintf(fpw,"--  HTLROM%-2d                                                                 --\n",width);
    fputs("--  Copyright (C) 2002-2025 HT-LAB                                           --\n",fpw);
    fputs("--                                                                           --\n",fpw);
    fputs("-------------------------------------------------------------------------------\n",fpw);
    fputs("-------------------------------------------------------------------------------\n",fpw);
    fputs("-- Project       :                                                           --\n",fpw);
    fputs("-- Purpose       :                                                           --\n",fpw);
    fputs("-- Library       :                                                           --\n",fpw);
    fputs("--                                                                           --\n",fpw);
    fprintf(fpw,"-- Created       : bin2text -vhd version %2d.%d                                --\n",MAJOR_VERSION,MINOR_VERSION);
    fputs("-------------------------------------------------------------------------------\n",fpw);


    fputs("\nlibrary ieee;",fpw);
    fputs("\nuse ieee.std_logic_1164.ALL;",fpw);

    fprintf(fpw,"\n\nentity %s is",entityname);
    if (syncout) {
        fprintf(fpw,"\n\tport(clk    : in  std_logic;");
    } else {
        fprintf(fpw,"\n\tport(");
    }
	if (enareset) {
		fprintf(fpw,"\n\t\t reset   : in  std_logic;");	
	}	
    if (width==8) {
        fprintf(fpw,"\n\t\t abus   : in  std_logic_vector(%d downto 0);",msb);
    } else if (width==16) {
        fprintf(fpw,"\n\t\t abus   : in  std_logic_vector(%d downto 0);",msb-1);
    } else {
        fprintf(fpw,"\n\t\t abus   : in  std_logic_vector(%d downto 0);",msb-2);
    }
	if (enarom)  fprintf(fpw,"\n\t\t ena    : in std_logic;");
    fprintf(fpw,"\n\t\t dbus   : out std_logic_vector(%d downto 0));",width-1);
     
        
    fprintf(fpw,"\nend %s;",entityname);
    fprintf(fpw,"\n\narchitecture rtl of %s is",entityname);
    fputs("\nbegin",fpw); 
    if (syncout) {
		if (enareset) {
			fputs("\n\n\tprocess(clk,reset)",fpw);
        } else {
			fputs("\n\n\tprocess(clk)",fpw);
		}
        fputs("\n\t\tbegin",fpw);
		if (enareset) {
			fputs("\n\t\tif reset='1' then",fpw);
			fputs("\n\t\t\tdbus <= (others => '0');",fpw);
			fputs("\n\t\telsif rising_edge(clk) then",fpw);
		} else {
			fputs("\n\t\tif rising_edge(clk) then",fpw);
		}
    } else {
        fputs("\n\n\tprocess(abus)",fpw);
        fputs("\n\t\tbegin",fpw);
    }
	if (enarom) fputs("\n\t\t\tif ena='1' then",fpw);
    fputs("\n\t\t\tcase abus is",fpw);

}

//----------------------------------------------------------------------------------
// Write conv2case VHDL footer
//----------------------------------------------------------------------------------
void conv2case_tail(FILE *fpw, int width, int syncout, int enarom, char defaultchar)
{
    int n;

    fprintf(fpw,"\n\t\t\t\twhen others    => dbus <= %c",34);
    //for (n=0;n<width;n++) fputs("-",fpw);
	for (n=0;n<width;n++) fputc(defaultchar,fpw);
    fprintf(fpw,"%c;",34);
    fputs("\n\t\t\t\tend case;",fpw);
	if (enarom) fputs("\n\t\t\tend if;",fpw);
    if (syncout) {
        fputs("\n\t\tend if;",fpw);
    }
    fputs("\n\tend process;",fpw);
    fputs("\nend rtl;\n",fpw);  
}

//----------------------------------------------------------------------------------
// Convert to binary string
//----------------------------------------------------------------------------------
void conv_binary(char *s, int word, int len)
{
  int n;
  int shift;

  shift=1<<(len-1); 
  strcpy(s,"");

  for (n=0;n<len;n++) {
    if (word&shift) strcat(s,"1"); else strcat(s,"0");
    shift=shift>>1;
  }
}


//----------------------------------------------------------------------------------
// Convert to Intel Hex
// Return 1 incase of error
//----------------------------------------------------------------------------------
int conv2hex(FILE *fp, char *outfilename, uint16_t segment, uint16_t offset, int iprec, uint16_t ip)
{
    FILE *fpw=NULL;										// Output filepointer

	unsigned char data[32];

   //	int n=0;
	int len=0;
	char strwr[128]="";									// Intel Hex String
	uint16_t addr=0;
	uint16_t codeseg=0;

    //------------------------------------------------------------------------------
    // Open Output hex file 
    //------------------------------------------------------------------------------
    strcat(outfilename,".hex");
    if ((fpw=fopen(outfilename,"wt"))==NULL) {          
        fprintf(stderr, "\nError cannot open output file : %s\n",outfilename);
        return 1;
    }
    
    if (!quiet) {
        printf("Output HEX file         : %s\n",outfilename);
		printf("Load Address            : %04X:%04X\n",segment,offset);
		if (iprec) printf("Execute Address         : %04X:%04X\n",segment,ip);
    }



	//--------------------------------------------------------------------------
	// Start by writing a segment record only if address is not 0 since the main 
	// routine will start by writing a segment record
	//--------------------------------------------------------------------------	
	codeseg=segment;
	addr=offset;

	if (addr!=0) {
		conv2hex_segm_rec(strwr,codeseg);
		fputs(strwr,fpw);
		if (DEBUGEXTRA) printf("Segm > %s segment=%04X",strwr,codeseg);
	}

	//--------------------------------------------------------------------------
	// Write 64Kbyte block of data seperated by segment records
	//--------------------------------------------------------------------------
   //	n=0;
   	while ( (!feof(fp)) ) {
		
		if (addr==0) {
			codeseg+=0x1000;
			conv2hex_segm_rec(strwr,codeseg);
			fputs(strwr,fpw);
			if (DEBUGEXTRA) printf("Segm > %s segment=%04X",strwr,codeseg);
		}

		len=fread(data,sizeof(unsigned char),32,fp);	// Read 32 bytes
		if (len>0) {									// Check for 0 length
			conv2hex_data_rec(strwr, data, addr, len);
			fputs(strwr,fpw);
			if (DEBUGEXTRA) printf("Data > %s addr=%04X, n=%d, len=%d",strwr, addr,len);	    	
	    	//n+=len;   
	        addr=(addr+len)&0xFFFF;						// & just to be sure
		}
	}

	if (iprec) {										// Execute address specified?
		conv2hex_csip_rec(strwr,segment,ip);			// Write Start Address
		fputs(strwr,fpw);
		if (DEBUGEXTRA) printf("CSIP > %s",strwr);
	} else {
   		sprintf(strwr,":00000001FF\n");
		fputs(strwr,fpw);
	}													// else write a terminate record

    fclose(fpw);
    return 0;
}

//----------------------------------------------------------------------------------
// Generate Intel-Hex Segment Record
// If segment address is specified then generate a 02 record first
// Example  : 02 0000 02 0000 FC
//----------------------------------------------------------------------------------
void conv2hex_segm_rec(char *strwr, uint16_t segment)
{
    unsigned checksum=4;								// note 4

    checksum=checksum + ((segment>>8)&0xFF);            // Add address to checksum
    checksum=checksum + (segment&0xFF);
    sprintf(strwr,":02000002%s",byte2hexstring((segment>>8)&0xFF));
	strcat(strwr,byte2hexstring(segment&0xFF));
    strcat(strwr,byte2hexstring((255-checksum)+1));
	strcat(strwr,"\n");
}

//----------------------------------------------------------------------------------
// Generate Intel-Hex Data Record
// : 20 0020 00 8EC006BF000157CB5250BAF902EC240274FBBAF80258EE5AC352BAF902EC2401 83
//----------------------------------------------------------------------------------
void conv2hex_data_rec(char *strwr, unsigned char *mem_ptr, uint16_t addr, int len)
{
    int n;
    unsigned checksum=0;
    unsigned record_type=0;

    if (len>0) {                                        // Check for 0 length

        checksum=checksum+len;

        checksum+=((addr>>8)&0xFF);                     // Add address to checksum
        checksum+=(addr&0xFF);
        checksum+=record_type;                          // Add record type

        sprintf(strwr,":%s",byte2hexstring(len));
        strcat(strwr,byte2hexstring((addr>>8)&0xFF));
        strcat(strwr,byte2hexstring(addr&0xFF));
        strcat(strwr,byte2hexstring(record_type));
        for (n=0;n<len;n++) {
            strcat(strwr,byte2hexstring(mem_ptr[n]));
            checksum=checksum+mem_ptr[n];                  // Add data
        }
        
        strcat(strwr,byte2hexstring((255-checksum)+1));
		strcat(strwr,"\n");
        //addr=addr+len;
    }
}

//----------------------------------------------------------------------------------
// Generate Intel-Hex CS-IP execute Record
// Generate an 03 record 
// Example : 04 0000 03 cs ip CH
// sprintf(strwr,":00000001FF\n"); if no execute address
//----------------------------------------------------------------------------------
void conv2hex_csip_rec(char * strwr, uint16_t cs, uint16_t ip)
{
    unsigned checksum=7;								// note 7

	checksum=checksum + ((cs>>8)&0xFF);			// Add CS address to checksum
	checksum=checksum + (cs&0xFF);
	checksum=checksum + ((ip>>8)&0xFF);					// Add IP address to checksum
	checksum=checksum + (ip&0xFF);
	sprintf(strwr,":04000003%s",byte2hexstring((cs>>8)&0xFF));
	strcat(strwr,byte2hexstring(cs&0xFF));
	strcat(strwr,byte2hexstring((ip>>8)&0xFF));
	strcat(strwr,byte2hexstring(ip&0xFF));
	strcat(strwr,byte2hexstring((255-checksum)+1));
	strcat(strwr,"\n");
}

//----------------------------------------------------------------------------------
// Used for intel-hex converter
//----------------------------------------------------------------------------------
char * byte2hexstring(unsigned char b) 
{

    static char hextable[16] = {
        '0', '1', '2', '3', '4', '5', '6', '7', 
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
    };
    static char str[3];

    str[0]= hextable[((b>>4)&0x0F)];
    str[1]= hextable[(b&0x0F)];
    str[2]='\0';                        // terminate string
    return(str);            			// not particular good coding style! :-(
}


void usage_exit(void)
{

    printf("\nBIN2Text Ver %d.%d Mar 2025 (c) HT-LAB\n",MAJOR_VERSION,MINOR_VERSION);
    printf("\nUsage   : bin2text <options> filename.bin <options>\n");
    printf("\nOptions :\n\n");
    printf("-q               : Quiet, must be specified first in the options list\n");
    printf("-o <filename>    : Optional specify output filename\n");
    printf("-vhd             : write VHDL case ROM file, default file extension .vhd\n");
    printf("-hex             : write Intel HEX file, default file extension .hex\n");
    printf("-ena             : Add read enable signal to VHDL memory\n");	
	printf("-default char    : use when (others => 'char') in VHDL case statement\n");	
	printf("-mem             : write Andre' Klindworth memory format, default file extension .dat\n");
	printf("-mif             : Xilinx mif format, 8bits wide only\n");
	printf("-binstr          : Simple binary string used for memory init functions\n");
	printf("-mif32b          : Xilinx mif format, 32bits in 4 files byte files\n");
	printf("-mifgowin        : Gowin 32bits HEX mif format\n");
    printf("-width           : Databus width, 8, 16 or 32, default to 8\n");
	printf("-awidth          : Address width, 0 means determine max by filesize\n");
	printf("-fileoff <hex>   : File Offset, skip <hex> bytes before converting\n");
    printf("-seg <hex>       : SEGment, default 0x0000\n");
    printf("-off <hex>       : OFFset, default 0x0000\n");
    printf("-ip <hex>        : Execute Address, default 0x0000\n");    
    printf("-byte            : Write byte format\n");
    printf("-clk             : Select synchronous VHDL case statement\n");
	printf("-reset           : Enable asynchronous reset, also enables -clk\n");

    printf("\nExamples:\n\n");
    printf(" bin2text test.bin -vhd\n");
    printf("   -> create a combinatorial VHDL ROM case file\n");
    printf(" bin2text test.bin -vhd -clk\n");
    printf("   -> create a synchronous VHDL ROM case file\n");
    
    printf(" bin2text test.bin -mem -width 16 -seg 0x0080\n");
    printf("   -> create single memory image test.dat file (offset=0000)\n");
    printf(" bin2text test.bin -mem -width 16 -seg 0x0080 -byte\n");
    printf("   -> create 2 memory image files, test0.dat (lsb) and test1.dat (msb)\n");
    
    printf(" bin2text test.bin -hex -off 0x0080 -seg 0x0100\n");
    printf("   -> create Intel hex file text.hex with upload address 0080:0100\n");
    printf(" bin2text test.bin -o test2.hex -hex -off 0x7000 -ip 0x7C00\n");
    printf("   -> create text2.hex, upload address 0000:7000, execute address 0000:7C00\n");

    exit(1);
}
