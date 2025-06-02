---------------------------------------------------------------------------------------------------
--  Simple 32bits SRAM module                                                                           
--                                            
--  Copyright (C) 2013-2025 HT-LAB                                           
--                                                                           
--  Contact/bugs :                                
--  Web          :                                      
--                                                                           
---------------------------------------------------------------------------------------------------       
---------------------------------------------------------------------------------------------------
--
--	Memory
--     Note ADDR_WIDTH in DWORDS!
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          Revision         Author         
--
-- ***************************************************************
-- Device Utilization for 6SLX16CSG324
-- ***************************************************************
-- Resource                          Used    Avail   Utilization
-- ---------------------------------------------------------------
-- IOs                               84      232      36.21%
-- Global Buffers                    1       16        6.25%
-- LUTs                              4       9112      0.04%
-- CLB Slices                        0       2278      0.00%
-- Dffs or Latches                   0       18224     0.00%
-- Block RAMs                        16      32       50.00%
-- RAMB16BWER                     16                    
-- DSP48A1s                          0       32        0.00%
-- ---------------------------------------------------------------
--
-- Using latched address
--
-- Resource                          Used    Avail   Utilization
-- ---------------------------------------------------------------
-- IOs                               84      232      36.21%
-- Global Buffers                    2       16       12.50%
-- LUTs                              4       9112      0.04%
-- CLB Slices                        4       2278      0.18%
-- Dffs or Latches                   32      18224     0.18%
-- Block RAMs                        16      32       50.00%
-- RAMB16BWER                     16                    
-- DSP48A1s                          0       32        0.00%
-- ---------------------------------------------------------------
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;
use std.textio.all;

entity sram32 is
	generic(ADDR_WIDTH   : integer :=13;
		    MEM_INIT	 : boolean :=false;
			RAM_FILENAME : string  :="init_sram.mem");
	PORT(
		clk      : in  std_logic;
		we       : in  std_logic; 									-- Write Enable
		re       : in  std_logic; 									-- Read Enable
		be       : in  std_logic_vector(3 downto 0);				-- Byte Enable
		addr     : in  std_logic_vector(ADDR_WIDTH-1 downto 0); 	
		din      : in  std_logic_vector(31 downto 0); 				-- Data In 
		dout     : out std_logic_vector(31 downto 0));
end entity sram32;

architecture rtl of sram32 is

	type mem_type  is array (0 to (2**ADDR_WIDTH)-1) of std_logic_vector(7 downto 0);
		
	signal mem0,mem1,mem2,mem3 : mem_type;	
	
	signal addr_latched : std_logic_vector(ADDR_WIDTH-1 downto 0);
	
begin

	process (clk)
		--pragma synthesis_off
		variable mem_not_init_v : boolean:=MEM_INIT;
		variable i     : natural;
		variable depth : integer := 2**ADDR_WIDTH;
		variable value : line;
		variable data  : std_logic_vector(31 downto 0);
		file initfile  : text open read_mode is RAM_FILENAME;
		--pragma synthesis_on
	begin

		if rising_edge(clk) then
			--pragma synthesis_off
			if mem_not_init_v then 
				while not endfile(initfile) and i <= depth loop
					readline(initfile,value);
					read(value,data);
					mem0(i) <= data(7 downto 0); 
					mem1(i) <= data(15 downto 8); 
					mem2(i) <= data(23 downto 16);
					mem3(i) <= data(31 downto 24);
					i := i + 1 ;
				end loop ;
				mem_not_init_v:=false;
				report "Memory has been initialised with " & RAM_FILENAME;
			end if;						
			--pragma synthesis_on

			if we='1' then	
				if be(0)='1' then mem0(to_integer(unsigned(addr))) <= din(7 downto 0); end if;	
				if be(1)='1' then mem1(to_integer(unsigned(addr))) <= din(15 downto 8); end if;
				if be(2)='1' then mem2(to_integer(unsigned(addr))) <= din(23 downto 16); end if;
				if be(3)='1' then mem3(to_integer(unsigned(addr))) <= din(31 downto 24); end if;				
			end if ;
			
			--if re='1' then
				addr_latched <= addr;
			--end if;
		end if ;
	end process;	

	-- process(all)
	-- begin	
		-- if re='1' then
			dout(7 downto 0)   <= mem0(to_integer(unsigned(addr_latched)));	-- Block Ram, synchronous read
			dout(15 downto 8)  <= mem1(to_integer(unsigned(addr_latched)));		
			dout(23 downto 16) <= mem2(to_integer(unsigned(addr_latched)));			
			dout(31 downto 24) <= mem3(to_integer(unsigned(addr_latched)));	
		-- end if;	
	-- end process;

		
end architecture rtl;

