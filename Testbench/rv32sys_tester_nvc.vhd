---------------------------------------------------------------------------------------------------
--                                                                           
--  HTLRV32 Risc-V Processor                                           
--  Copyright (C) 2019-2025 HT-LAB                                            
--                                                                           
--  https://github.com/htminuslab                                   
--                                                                           
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--
--	Testbench Tester code
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author         
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
--  22/06/2025      1.2         HABT, remove propriety modelsim lib so nvc can be used
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

LIBRARY std;
use std.env.all;
USE std.TEXTIO.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

-- LIBRARY modelsim_lib;
-- USE modelsim_lib.util.all;

ENTITY rv32sys_tester IS
   PORT( 
      PIO_OUT : IN     std_logic_vector (3 DOWNTO 0);
      PIO_IN  : OUT    std_logic_vector (3 DOWNTO 0);
      RX0     : OUT    std_logic;
      RX1     : OUT    std_logic;
      busreq  : OUT    std_logic;
      clk     : OUT    std_logic;
      clkuart : OUT    std_logic;
      resetn  : OUT    std_logic;
      sreset  : OUT    std_logic
   );

-- Declarations

END rv32sys_tester ;

--
ARCHITECTURE rtl OF rv32sys_tester IS

	signal clk_s         : std_logic := '0';
	signal clkuart_s     : std_logic := '0';
	
	type REG_ENUM is (x0, ra, sp, gp, tp, t0, t1, t2, s0, s1, a0, a1, a2, a3, a4, a5,
	                  a6, a7, s2, s3, s4, s5, s6, s7, s8, s9, s10,s11,t3, t4, t5, t6);

	alias dbuso_cpu_s is  << signal .rv32sys_tb.U_DUT.dbuso_cpu : std_logic_vector(31 downto 0) >>;	
	alias abus_s is  << signal .rv32sys_tb.U_DUT.abus : std_logic_vector(31 downto 0) >>;
	alias ads_s is  << signal .rv32sys_tb.U_DUT.ads : std_logic >>;
	
	alias rds_s is  << signal .rv32sys_tb.U_DUT.U_CPU.U_PROC.rds : rds_type >>;
	signal rdsel      : REG_ENUM;
	
	signal opcode_s   : rv32_enum;
	
BEGIN

	clk_s  <= NOT clk_s after 10.4167 ns;							-- 48MHz
	clk    <= clk_s;
	
	clkuart_s <= NOT clkuart_s after 135.6336 ns;					-- UART 16*115200*2
	clkuart   <= clkuart_s;
	
	SRESET <= '1', '0' after 55 ns;
	resetn <= '0', '1' after 39 ns;
	
	busreq <= '0';
	RX0    <= '1';
	RX1    <= '1';
	PIO_IN <= (others => '0');

	rdsel    <= REG_ENUM'val(to_integer(unsigned(rds_s.selo)));
	opcode_s <= rds_s.opcode;
	
	-----------------------------------------------------------------------------------------------
	-- Print Char
	-- debug port monitor 0x80000080
	-----------------------------------------------------------------------------------------------
	process(clk) 
		variable L       : line;
		variable count_v : integer :=0;
		
		function std_to_char(inp: std_logic_vector) return character is
			constant ASCII_TABLE : string (1 to 256) :=
			".......... .. .................. !" & '"' &
			"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHI"  &
			"JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnop"  &
			"qrstuvwxyz{|}~........................."  &
			"......................................."  &
			"......................................."  &
			"..........................";
		variable temp : integer;
		begin  
			temp:=to_integer(unsigned(inp))+1;
			return ASCII_TABLE(temp);
		end std_to_char;
	
	begin
		if rising_edge(clk) then
		
			if abus_s=OUTPORT_C AND ads_s='1' then  				-- Debug port 
				if (dbuso_cpu_s(7 downto 0)=X"0A" OR dbuso_cpu_s(7 downto 0)=X"0D" OR count_v>80) then                
					writeline(output,L);
					count_v:=0;
				else 
					write(L,std_to_char(dbuso_cpu_s(7 downto 0))); 
					count_v:=count_v+1;
				end if;	
			end if;
				
			if opcode_s=OP_EBREAK OR opcode_s=OP_ECALL then
				report "EBREAK/ECALL Detected, rtl simulation ended";
				STOP(0);
			end if;
				
		end if;		
	end process;

	
	
END ARCHITECTURE rtl;

