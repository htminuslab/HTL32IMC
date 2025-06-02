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
--	Register File, 2 Read Ports 1 write port
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision        Author  
--  25/05/2025      1.1 			HABT, Checked with Questa Base 2025.1, uploaded to github       
--
-- Using 2 clock inputs
-- ***************************************************************
-- Device Utilization for 7S25CSGA324
-- ***************************************************************
-- Resource                          Used    Avail   Utilization
-- ---------------------------------------------------------------
-- IOs                               121     150      80.67%
-- Global Buffers                    2       32        6.25%
-- LUTs                              125     14600     0.86%
-- CLB Slices                        15      3650      0.41%
-- Dffs or Latches                   10      29200     0.03%
-- Block RAMs                        1       45        2.22%
--    RAMB18E1                       2                     
-- DSP48E1s                          0       80        0.00%
-- ---------------------------------------------------------------     
--
-- Using single clock input
-- ***************************************************************
-- Device Utilization for 7S25CSGA324
-- ***************************************************************
-- Resource                          Used    Avail   Utilization
-- ---------------------------------------------------------------
-- IOs                               121     150      80.67%
-- Global Buffers                    1       32        3.13%
-- LUTs                              177     14600     1.21%
-- CLB Slices                        6       3650      0.16%
-- Dffs or Latches                   44      29200     0.15%
-- Block RAMs                        1       45        2.22%
--    RAMB18E1                       2                     
-- DSP48E1s                          0       80        0.00%
-- ---------------------------------------------------------------
--              
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

ENTITY rv32reg IS
   PORT( 
      clk     : IN     std_logic;
      proci   : IN     iproc_in_type;
      rds     : IN     rds_type;
      rs1_sel : IN     std_logic_vector (4 DOWNTO 0);
      rs2_sel : IN     std_logic_vector (4 DOWNTO 0);
      sreset  : IN     std_logic;
      stall   : IN     std_logic;
      rs1     : OUT    signed (31 DOWNTO 0);
      rs2     : OUT    signed (31 DOWNTO 0)
   );

-- Declarations

END rv32reg ;

--
ARCHITECTURE rtl OF rv32reg IS

	type mem_type is array(0 to 31) of std_logic_vector(31 downto 0); 
			
	-- required for Imperas, sp init to 0xFFFFF000
	-- make no difference for synthesis
	signal mem1 : mem_type := (X"00000000",X"00000000",X"FFFFF000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
	                           X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
							   X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
							   X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000");
	signal mem2 : mem_type := (X"00000000",X"00000000",X"FFFFF000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
	                           X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
							   X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
							   X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000");	
	
	signal rs1sel_s   : std_logic_vector(4 downto 0);
	signal rs2sel_s   : std_logic_vector(4 downto 0);

	
begin

	-----------------------------------------------------------------------------------------------
	-- Integer Register File
	-----------------------------------------------------------------------------------------------	
	process(clk)
	begin
		if rising_edge(clk) then
			if (rds.selo/="00000" AND ((rds.wr='1' AND stall='0'))) then 
				mem1(to_integer(unsigned(rds.selo))) <= std_logic_vector(rds.data);
				mem2(to_integer(unsigned(rds.selo))) <= std_logic_vector(rds.data);
			end if; 
			
			if stall='0' then
				rs1sel_s <= rs1_sel;			
				rs2sel_s <= rs2_sel;	
			end if;	
		
		end if;
	end process;
				
	rs1 <= signed(mem1(to_integer(unsigned(rs1sel_s))));	
	rs2 <= signed(mem2(to_integer(unsigned(rs2sel_s))));	

END ARCHITECTURE rtl;
