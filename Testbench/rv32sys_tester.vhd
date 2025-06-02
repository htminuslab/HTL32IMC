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
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

LIBRARY std;
use std.env.all;
USE std.TEXTIO.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

LIBRARY modelsim_lib;
USE modelsim_lib.util.all;

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
	
	signal dbuso_cpu_s   : std_logic_vector(31 downto 0);
	signal abus_s        : std_logic_vector(31 downto 0);
	signal ads_s         : std_logic;
	
	type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
	signal reg_s      : reg_array := (others => (others => '0'));
	
	signal rs1_sel_s  : std_logic_vector(4 downto 0);
	signal rs2_sel_s  : std_logic_vector(4 downto 0);
		
	type REG_ENUM is (x0, ra, sp, gp, tp, t0, t1, t2, s0, s1, a0, a1, a2, a3, a4, a5,
	                  a6, a7, s2, s3, s4, s5, s6, s7, s8, s9, s10,s11,t3, t4, t5, t6);
	
	signal rs1sel     : REG_ENUM;
	signal rs2sel     : REG_ENUM;
	signal rdsel      : REG_ENUM;

	signal deco_s     : idec_type;

	signal opcode_s   : rv32_enum;
	signal proco_s    : iproc_out_type;

	signal rds_s      : rds_type;

	signal cycle_s 	  : unsigned(63 downto 0);						-- Only used if HW_COUNT_G is true
	signal instret_s  : unsigned(63 downto 0);
	
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
	
	-----------------------------------------------------------------------------------------------
	-- Duplicate reg module using signalspy
	-----------------------------------------------------------------------------------------------
    process
    begin		
		
		init_signal_spy("/rv32sys_tb/U_DUT/dbuso_cpu","dbuso_cpu_s",0);
		init_signal_spy("/rv32sys_tb/U_DUT/ads","ads_s",0);
		init_signal_spy("/rv32sys_tb/U_DUT/abus","abus_s",0);		

		init_signal_spy("/rv32sys_tb/U_DUT/U_CPU/U_DEC/deco","deco_s",0);	
		init_signal_spy("/rv32sys_tb/U_DUT/U_CPU/U_PROC/proco","proco_s",0);			
		init_signal_spy("/rv32sys_tb/U_DUT/U_CPU/U_PROC/rds","rds_s");
		init_signal_spy("/rv32sys_tb/U_DUT/U_CPU/U_REG/rs1sel_s","rs1_sel_s",0);
		init_signal_spy("/rv32sys_tb/U_DUT/U_CPU/U_REG/rs1sel_s","rs2_sel_s",0);
		
		init_signal_spy("/rv32sys_tb/U_DUT/U_CPU/U_PROC/cycle","cycle_s",0);
		init_signal_spy("/rv32sys_tb/U_DUT/U_CPU/U_PROC/instret","instret_s",0);
		
		wait;
    end process;
	

	rdsel    <= REG_ENUM'val(to_integer(unsigned(rds_s.selo)));
	opcode_s <= rds_s.opcode;
	
	process(clk_s)													-- Mirror register file
		function reg2string(reg:integer) return string is
		begin
			case reg is
				when 0 => return("x0");
				when 1 => return("ra");				
				when 2 => return("sp");
				when 3 => return("gp");
				when 4 => return("tp");
				when 5 => return("t0");
				when 6 => return("t1");
				when 7 => return("t2");
				when 8 => return("s0");
				when 9 => return("s1");
				when 10 => return("a0");
				when 11 => return("a1");
				when 12 => return("a2");
				when 13 => return("a3");
				when 14 => return("a4");
				when 15 => return("a5");
				when 16 => return("a6");
				when 17 => return("a7");
				when 18 => return("s2");
				when 19 => return("s3");
				when 20 => return("s4");
				when 21 => return("s5");
				when 22 => return("s6");
				when 23 => return("s7");
				when 24 => return("s8");
				when 25 => return("s9");
				when 26 => return("s10");
				when 27 => return("s11");
				when 28 => return("t3");
				when 29 => return("t4");
				when 30 => return("t5");
				when others => return("t6");
			end case;
		end reg2string;	
		
		variable reg_v      : reg_array := (others => (others => '0'));
		variable ipc_v      : real;
	begin
		
        if rising_edge(clk_s) then 

				--if rs_latch_s='1' then
					rs1sel <= REG_ENUM'val(to_integer(unsigned(rs1_sel_s)));
					rs2sel <= REG_ENUM'val(to_integer(unsigned(rs2_sel_s)));
				--end if;
						
				if rds_s.wr='1' then --AND procidle_s then
					reg_v(to_integer(unsigned(rds_s.selo))) := std_logic_vector(unsigned(rds_s.data));
				end if;
		
				if opcode_s=OP_EBREAK OR opcode_s=OP_ECALL then
					report "EBREAK/ECALL Detected, rtl simulation ended";
					if cycle_s(31 downto 0)/=X"00000000" then
						ipc_v := real(to_integer(instret_s(31 downto 0)))/real(to_integer(cycle_s(31 downto 0)));
						if cycle_s(63 downto 32)=X"00000000" then 			-- to_integer can only handle 32bits
							report "IPC="&real'image(ipc_v)&"  cycles="&integer'image(to_integer(cycle_s(31 downto 0)))&"  Instr="&integer'image(to_integer(instret_s(31 downto 0))); 
						end if;
					else
						report "No IPC, 0 cycles"; 
					end if;
					STOP(0);
				end if;
				
				reg_s    <= reg_v;   
			end if;
		-- end if;
	end process;	





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
		end if;		
	end process;

	
	
END ARCHITECTURE rtl;

