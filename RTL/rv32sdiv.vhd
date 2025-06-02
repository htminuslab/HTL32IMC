---------------------------------------------------------------------------------------------------
--                                                                           
--  HTLRV32 Risc-V Processor                                           
--  Copyright (C) 2020-2025 HT-LAB                                           
--                                                                           
--  https://github.com/htminuslab                                        
--                                                                           
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--
--  Non-restoring serial unsigned 64/32 divider
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author     
--  19/04/2019   	1.0 		HABT                             
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity rv32sdiv is                         
   port( clk          : in   std_logic;                             -- System Clock   
         sreset       : in   std_logic;                             -- Active high
		 dividend     : in   unsigned(31 downto 0);
         divisor      : in   unsigned(31 downto 0);		 
		 divsigned	  : in   boolean;								-- false=unsigned, true=signed
         quotient     : out  unsigned(31 downto 0);
         remainder    : out  unsigned(31 downto 0);                           
         start        : in   boolean;
		 done         : out  std_logic);							-- conversion done
end rv32sdiv;                                                        

architecture rtl of rv32sdiv is
		
	type   states is (sIdle,sAddLoad,sRestore,sDone);        		-- Controlling FSM ,sTwos
	signal state: states;
	
	signal count_s    : unsigned(4 downto 0);         				-- Number of iterations

	signal divsigned_l: boolean;									-- Latched version as proc only gives pulse
	signal twos       : std_logic;									-- Correct Quotient
	signal divisor_is_zero_s : boolean;
	
	signal M          : unsigned(32 downto 0);
	signal minM       : unsigned(32 downto 0);
	
begin

	divisor_is_zero_s <= TRUE when divisor=X"00000000" else FALSE;	-- Detect divide by zero
		 
	minM <= NOT(M) + 1;												-- Twos complement	

	-----------------------------------------------------------------------------------------------
	-- Control FSM
	-----------------------------------------------------------------------------------------------
	process (clk)      
		variable A_v  : unsigned(32 downto 0); 
		variable Q_v  : unsigned(31 downto 0);
	begin
		if rising_edge(clk) then  
			if sreset = '1' then     
				state   <= sIdle; 
				count_s <= (others => '0');
				done    <= '0';	
				twos    <= '0';	
				divsigned_l <= false;				
			else
				done <= '0';										-- Default
				case state is
					when sIdle =>   
						A_v  := (others => '0');					
						divsigned_l <= divsigned AND (dividend(31)='1');	-- Latch for later usage
						if divsigned then										
							if dividend(31)='1' then
								Q_v  :=  NOT(dividend) + 1;			-- Twos complement	
							else
								Q_v  :=  dividend;	
							end if;
							if divisor(31)='1' then
								M <= NOT(divisor(31)&divisor) + 1;	-- Twos complement	
							else
								M <= '0'&divisor;	
							end if;
							
							if dividend(31) XOR divisor(31) then
								twos <= '1';						-- Correct sign after conversion
							else
								twos <= '0';						-- No correction
							end if;			
						else
							Q_v  :=  dividend;	
							M  <= '0'&divisor;			
							twos     <= '0';						-- No correction							
						end if;	

						count_s  <= "11111"; 						-- 32	
						quotient  <= (others => '1');				-- Default when divisor=0, quotient=-1	
						remainder <= dividend;						-- Default when divisor=0
				
						if start then 			
							if divisor_is_zero_s then				-- RISC-V special on divide by 0
								done  <= '1';
								state <= sDone;
							else
								state <= sAddLoad;
							end if;											 
						end if; 

					when sAddLoad =>						
						if A_v(32)='1' then 
							A_v := A_v(31 downto 0) & Q_v(31); 		-- shift left
							A_v := A_v + M;
						else
							A_v := A_v(31 downto 0) & Q_v(31); 		-- shift left
							A_v := A_v + minM;
						end if;
					
						if A_v(32)='1' then 
							Q_v := Q_v(30 downto 0) & '0';
						else
							Q_v := Q_v(30 downto 0) & '1';
						end if;
					
						
						if twos='1' then
							quotient  <= NOT(Q_v(31 downto 0)) + 1;	-- Correct Quotient if it is negative
						else					
							quotient  <= Q_v(31 downto 0);
						end if;
						if divsigned_l then 		-- sign remainder is always same size as dividend	
							remainder <= NOT(A_v(31 downto 0)) + 1;	-- Correct Remainder if it is negative
						else
							remainder <= A_v(31 downto 0);
						end if;
											
						
						count_s <= count_s-1;
						if count_s="00000" then			    
							if A_v(32)='1' then
								state <= sRestore;									
							else 
								done  <= '1';
								state <= sDone;
							end if;
						end if;													
								
					when sRestore =>													
						A_v := A_v + M;	
						
						if twos='1' then
							quotient  <= NOT(Q_v(31 downto 0)) + 1;	-- Correct Quotient if it is negative
						else					
							quotient  <= Q_v(31 downto 0);
						end if;
						if divsigned_l then 		-- sign remainder is always same size as dividend						
							remainder <= NOT(A_v(31 downto 0)) + 1;	-- Correct Remainder if it is negative
						else
							remainder <= A_v(31 downto 0);
						end if;
						done  <= '1';
						state <= sDone;	
									
					when sDone =>				
						state <= sIdle;		
												
				end case;
			end if;													-- sreset
		end if;   													-- clk
	end process;  
end rtl;