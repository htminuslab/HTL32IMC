---------------------------------------------------------------------------------------------------
--                                                                           
--  HTLRV32 Risc-V Processor                                           
--  Copyright (C) 2019-2025 HT-LAB                                           
--                                                                           
--  https://github.com/htminuslab                                        
--                                                                           
---------------------------------------------------------------------------------------------------
--               
---------------------------------------------------------------------------------------------------
--
--	Synchronous FIFO  
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author     
--  20/01/2005   	1.0 		HABT                             
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;
 
entity syncfifo is
	GENERIC( 
		DATA_WIDTH : integer := 32;
		ADDR_WIDTH : integer := 2;
		RW_PROTECT : boolean := true);								-- RD when empty or WR when full have no effect						
	port(
		clk       : in  std_logic;
        sreset    : in  std_logic;                        			-- Synchronous reset
        datain    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        dataout   : out std_logic_vector(DATA_WIDTH-1 downto 0);           
        wr        : in  std_logic;                        			-- Write Strobe (clk period)
        rd        : in  std_logic;                        			-- Read Strobe (clk period)
		clear     : in  std_logic;									-- Clear FIFO counters, empty flag will be set
        full      : out boolean;                        			-- Sync Full Flag
		nextempty : out boolean; 									-- Next read will set the empty flag
		nextfull  : out boolean; 									-- Next write will set the full flag
        empty     : out boolean;                        			-- Sync Empty Flag
        wcounter  : out std_logic_vector(ADDR_WIDTH-1 downto 0)); 	-- Number of words in the fifo          
end syncfifo;
     
     
architecture rtl of syncfifo is

	type   mem_type is array(0 to (2**ADDR_WIDTH)-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
	signal mem : mem_type;

	signal wraddr_s     : unsigned(ADDR_WIDTH-1 downto 0);
	signal rdaddr_s     : unsigned(ADDR_WIDTH-1 downto 0);
	signal wcounter_s   : unsigned(ADDR_WIDTH downto 0);          	-- Note one extra bit
	signal write_s      : std_logic;
	signal read_s       : std_logic;

	constant ZEROVECTOR_C : unsigned(ADDR_WIDTH downto 0)  :=(others => '0');  	
	constant MAXVECTOR_C  : unsigned(ADDR_WIDTH-1 downto 0):=(others => '1');    
	constant ONEVECTOR_C  : unsigned(ADDR_WIDTH downto 0):=to_unsigned(1,ADDR_WIDTH+1);  
	
	signal  nextempty_s : boolean;
	signal  nextfull_s  : boolean;
	signal  empty_s     : boolean;
	signal  full_s      : boolean;

begin

    -----------------------------------------------------------------------------------------------   
    -- RW_PROTECT is true then RD when empty or WR when full will have no effect
    -----------------------------------------------------------------------------------------------   			
	G1: if RW_PROTECT generate 
		write_s <= '1' when (wr='1' AND full_s=false)  else '0'; 		-- Prevent writing when full
		read_s  <= '1' when (rd='1' AND empty_s=false) else '0'; 		-- Prevent reading when empty
	else generate
		write_s <= wr;
		read_s  <= rd;
	end generate G1;
	
    -----------------------------------------------------------------------------------------------   
    -- Read/Write Memory, synchronous
    -- Check synthesis tool infers correct memory!
    -- Note Asynchronous Read
    -----------------------------------------------------------------------------------------------   
    process (clk)
    begin
        if rising_edge(clk) then    
            if write_s='1' then
                mem(TO_INTEGER(wraddr_s)) <= datain; 
			--pragma synthesis_off
			elsif empty_s then			
				for i in 0 to (2**ADDR_WIDTH)-1 loop
					mem(i) <= (others => '0');
				end loop;
			-- pragma synthesis_on
            end if;
			-- if read_s='1' then 
				-- dataout <= mem(TO_INTEGER(rdaddr_s));  
			-- end if;			
        end if;
    end process;
    dataout <= mem(TO_INTEGER(rdaddr_s));               


    -----------------------------------------------------------------------------------------------   
    -- Read/Write pointers
    -----------------------------------------------------------------------------------------------   
    process (clk) 
	begin
		if rising_edge(clk) then 
			if sreset='1' then                     					-- Asynchronous reset 
				wraddr_s <= (others => '0');
				rdaddr_s <= (others => '0');
			else		
				if clear='1' then		
					wraddr_s <= (others => '0');
					rdaddr_s <= (others => '0');
				else 
					if write_s='1' then
						wraddr_s <= wraddr_s + 1;       -- Wrap around
					end if;
					if read_s='1' then
						rdaddr_s <= rdaddr_s + 1;
					end if;
				end if;
			end if;
		end if;
    end process;
     
    -----------------------------------------------------------------------------------------------   
    -- FIFO usage Counter 
    -----------------------------------------------------------------------------------------------   
	nextempty_s <= true when wcounter_s=ONEVECTOR_C else false;		
	nextfull_s  <= true when wcounter_s(ADDR_WIDTH-1 downto 0)=MAXVECTOR_C else false;
	
    process (clk)
    begin
        if rising_edge(clk) then
			if sreset='1' then
				wcounter_s <= (others => '0');
				full_s     <= false;                           
				empty_s    <= true;    
			else
				if clear='1' then
					wcounter_s <= (others => '0');
					full_s     <= false;                           
					empty_s    <= true;              				
				elsif (write_s='1' AND read_s='0') then    				-- Write FIFO 
					wcounter_s <= wcounter_s + 1;
					if nextfull_s then 			
						full_s <= true;
					end if;  
					if wcounter_s=ZEROVECTOR_C then
						empty_s <= false;
					end if;  
		
				elsif write_s='0' AND read_s='1' then 					-- Read FIFO
					wcounter_s <= wcounter_s - 1;
					if (wcounter_s(ADDR_WIDTH)='1') then
						full_s <= false;
					end if;  
					if nextempty_s then 								-- if wcounter=1 and RD strobe then set empty flag
						empty_s <= true;
					end if;  
				end if;
			end if;

        end if;
    end process;
    				
    wcounter <= std_logic_vector(wcounter_s(ADDR_WIDTH-1 downto 0)); 
	nextempty<= nextempty_s;
	nextfull <= nextfull_s;
    empty    <= empty_s;
    full     <= full_s;

end rtl;