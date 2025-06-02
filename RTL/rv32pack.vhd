---------------------------------------------------------------------------------------------------
--                                                                           
--  HTLRV32 Risc-V Processor                                           
--  Copyright (C) 2019-2025 HT-LAB                                                             
--   
--  https://github.com/htminuslab                                                                           
---------------------------------------------------------------------------------------------------                                                    
---------------------------------------------------------------------------------------------------
--
--	RV32 Package
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author         
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package rv32pack is

	constant RESET_VECTOR_C   : unsigned(31 downto 0) := X"40000000";
	constant uNOP_C           : std_logic_vector(31 downto 0):=X"0000000B";-- Used by BIU TODO change this to compressed NOP to reduce fifo_in mux


	constant OUTPORT_C 	     : std_logic_vector(31 downto 0):=X"80000080";-- Debug port
	
    type RV32_ENUM is (
		OP_uNOP,OP_LUI,OP_AUIPC,OP_JAL,OP_JALR,OP_BEQ,OP_BNE,OP_BLT,OP_BGE,OP_BLTU,OP_BGEU,OP_LB,
		OP_LH,OP_LW,OP_LBU,OP_LHU,OP_SB,OP_SH,OP_SW,OP_ADDI,OP_SLTI,OP_SLTIU,OP_XORI,OP_ORI,
		OP_ANDI,OP_SLLI,OP_SRLI,OP_SRAI,OP_ADD,OP_SUB,OP_SLL,OP_SLT,OP_SLTU,OP_XOR,OP_SRL,OP_SRA,
		OP_OR,OP_AND,OP_FENCE,OP_FENCEI,OP_MUL,OP_MULH,OP_MULHSU,OP_MULHU,OP_DIV,OP_DIVU,OP_REM,
		OP_REMU,OP_ECALL,OP_EBREAK,OP_WFI,--,OP_IRQ
		OP_CSRRW,OP_CSRRS,OP_CSRRC,OP_CSRRWI,OP_CSRRSI,OP_CSRRCI,OP_MRET,   -- Zicsr instructions		
		OP_EXCEP);
		
    constant MAXIRQ			 : integer := 4;						-- ..
	
		
	-----------------------------------------------------------------------------------------------
	-- CSR Register addresses
	-----------------------------------------------------------------------------------------------
	constant MSTATUS_ADDR_C  : signed(11 downto 0) := X"300";
	constant MTVEC_ADDR_C    : signed(11 downto 0) := X"305";
	constant MEPC_ADDR_C     : signed(11 downto 0) := X"341";
	constant MDEL_ADDR_C     : signed(11 downto 0) := X"302"; -- medeleg register used for MRET
	constant MCAUSE_ADDR_C   : signed(11 downto 0) := X"342";
	constant MHARTID_ADDR_C  : signed(11 downto 0) := X"F14";  
	constant MIE_ADDR_C      : signed(11 downto 0) := X"304"; -- Machine Interrupt Enable Register
	constant MIP_ADDR_C      : signed(11 downto 0) := X"344"; -- Machine Interrupt Pending Register
	constant CYCLE_CNT_C     : signed(11 downto 0) := X"C00"; -- UnPrivileged	
	constant TIME_CNT_C      : signed(11 downto 0) := X"C01"; -- UnPrivileged	
	constant INSTRET_CNT_C   : signed(11 downto 0) := X"C02"; -- UnPrivileged								 
	constant CYCLEH_CNT_C    : signed(11 downto 0) := X"C80"; -- UnPrivileged	
	constant TIMEH_CNT_C     : signed(11 downto 0) := X"C81"; -- UnPrivileged	
	constant INSTRETH_CNT_C  : signed(11 downto 0) := X"C82"; -- UnPrivileged		
	constant MTIMECMP_CNT_C  : signed(11 downto 0) := X"803"; -- Using custom CSR as mtimecmp register!
	constant MTIMECMPH_CNT_C : signed(11 downto 0) := X"883"; -- Using custom CSR as mtimecmph register! 								 
	constant MCYCLE_CNT_C    : signed(11 downto 0) := X"B00"; -- Machine	
	constant MINSTRET_CNT_C  : signed(11 downto 0) := X"B02"; -- Machine	
	constant MCYCLEH_CNT_C   : signed(11 downto 0) := X"B80"; -- Machine	
	constant MINSTRETH_CNT_C : signed(11 downto 0) := X"B82"; -- Machine	

	-- Exception causes (not all used, only bottom 4 bits listed) loaded into mcause
	-- bit7 is IRQ bit
	-- TODO update so MAXIRQ can be used!
	constant CAUSE_MISALIGNED_FETCH_C  : signed(7 downto 0) := "00000000"; -- 0x0
	constant CAUSE_FAULT_FETCH_C       : signed(7 downto 0) := "00000001"; -- 0x1
	constant CAUSE_ILLEGAL_INST_C	   : signed(7 downto 0) := "00000010"; -- 0x2
	constant CAUSE_BREAKPOINT_C        : signed(7 downto 0) := "00000011"; -- 0x3
	constant CAUSE_MISALIGNED_LOAD_C   : signed(7 downto 0) := "00000100"; -- 0x4
	constant CAUSE_FAULT_LOAD_C        : signed(7 downto 0) := "00000101"; -- 0x5
	constant CAUSE_MISALIGNED_STORE_C  : signed(7 downto 0) := "00000110"; -- 0x6
	constant CAUSE_FAULT_STORE_C       : signed(7 downto 0) := "00000111"; -- 0x7
	constant CAUSE_USER_ECALL_C        : signed(7 downto 0) := "00001000"; -- 0x8
	constant CAUSE_SUPERVISOR_ECALL_C  : signed(7 downto 0) := "00001001"; -- 0x9
	constant CAUSE_HYPERVISOR_ECALL_C  : signed(7 downto 0) := "00001010"; -- 0xA
	constant CAUSE_MACHINE_ECALL_C     : signed(7 downto 0) := "00001011"; -- 0xB
	constant CAUSE_FETCH_PAGE_FAULT_C  : signed(7 downto 0) := "00001100"; -- 0xC
	constant CAUSE_LOAD_PAGE_FAULT_C   : signed(7 downto 0) := "00001101"; -- 0xD
 -- constant CAUSE_RESERVED_C          : signed(7 downto 0) := "00001110"; -- 0xE
	constant CAUSE_STORE_PAGE_FAULT_C  : signed(7 downto 0) := "00001111"; -- 0xF
	
	-- Interrupts
	constant CAUSE_MSOFTWARE_IRQ_C	   : signed(3 downto 0) := "0011"; -- 0x3
	constant CAUSE_MTIMER_IRQ_C	       : signed(3 downto 0) := "0111"; -- 0x7
	constant CAUSE_MEXTERNAL_IRQ_C 	   : signed(3 downto 0) := "1011"; -- 0xB
	

 	-----------------------------------------------------------------------------------------------
	-- idecode registered out record
	-----------------------------------------------------------------------------------------------
	type idec_type is record	 				
		pc         : signed(31 downto 0);							-- Program Counter, signed as we use it mainly for arith jumps
		insn       : std_logic_vector(31 downto 0);					-- Debug only		
		opcode     : rv32_enum;
		compressed : boolean;
		load       : std_logic;										-- Opcode is Load instruction
		store      : std_logic;										-- Opcode is Store instruction
		divrem     : std_logic;										-- Opcode is div/rem instructions
		imm        : signed(31 downto 0);
		rds_sel    : std_logic_vector(4 downto 0);
		rs1_sel    : std_logic_vector(4 downto 0);
		rs2_sel    : std_logic_vector(4 downto 0);
		rds_wr     : std_logic;	  	  
	end record;

	-----------------------------------------------------------------------------------------------
	-- iproc registered out record
	-----------------------------------------------------------------------------------------------
	type iproc_out_type is record					
		jump       : std_logic;		
		load       : std_logic;
		store      : std_logic;
		be         : std_logic_vector(3 downto 0);					-- Byte Select

		memaddr    : unsigned(31 downto 0);							-- Combinatorial output before FF
		memdata    : unsigned(31 downto 0);							-- Combinatorial output before FF
	end record;

 	-----------------------------------------------------------------------------------------------
	-- iproc registered out record 
	-----------------------------------------------------------------------------------------------
	type iproc_in_type is record		
		memdata      : unsigned(31 downto 0);						-- Input (load)
		memdata_s    : unsigned(31 downto 0);						-- unlatched
		lsack		 : std_logic;
	end record;
	
 	-----------------------------------------------------------------------------------------------
	-- register file input
	-----------------------------------------------------------------------------------------------
	type rds_type is record
		opcode     : rv32_enum;
		selo       : std_logic_vector(4 downto 0);					-- To Register File	
		data       : signed(31 downto 0);
		wr         : std_logic;
		memaddr    : unsigned(31 downto 0);	
		pc         : signed(31 downto 0);							-- Debug only
		insn       : std_logic_vector(31 downto 0);					-- Debug only			
	end record;	

end rv32pack;
