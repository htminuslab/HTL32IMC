---------------------------------------------------------------------------------------------------
--  UART Controller
--                                                                                                                  
--  Copyright (C) 2013-2025 HT-LAB                                                                    
--                                                                           
---------------------------------------------------------------------------------------------------
--                                                     
---------------------------------------------------------------------------------------------------
--
--	Basic 8N1 UART Module		 
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          Revision         Author         
--
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity uart is
   generic(
		CLK16UART   : integer :=313);								-- 48.0142MHz/(16*9600)=312.59
   port(CLK        	: in  std_logic;            					-- cpu clock
        SRESET      : in  std_logic;            					-- Active high sync reset
        ABUS    	: in  std_logic_vector(1 downto 0); 			-- Only 4 registers used		
		WR         	: in  std_logic;            					-- wr=1, rd=0
		CS        	: in  std_logic;								-- Active high Chip Select
		DBUSO      	: out std_logic_vector(7 downto 0);				-- output from rx reg
		DBUSI      	: in  std_logic_vector(7 downto 0);				-- tx reg
		IRQ        	: out std_logic;								-- IRQ set when enabled and rdrf_s=1, cleared by reading status		
		TX			: out std_logic;
        RX         	: in  std_logic);            					-- receive pin              
end uart;	 

architecture rtl of uart is 

	constant RXHOLD_C   : std_logic_vector(1 downto 0) := "00";
	constant TXHOLD_C   : std_logic_vector(1 downto 0) := "01";
	constant IRQENA_C   : std_logic_vector(1 downto 0) := "10";		-- Interrupt Enable Register
	constant STATUS_C   : std_logic_vector(1 downto 0) := "11";		-- Status Register

	signal rxreg_s      : std_logic_vector(7 downto 0); 			-- Received data register
	signal txreg_s      : std_logic_vector(7 downto 0); 			-- Transmit data register
                      
    signal uartdivcnt_s : integer range 0 to 651; 					--unsigned(7 downto 0);                 

	signal rxclk16_s    : std_logic;                                	
    signal txclk1_s     : std_logic;                               	-- x1 TX clock
    signal div16_s      : unsigned(3 downto 0); 					-- divide by 16 counter
					    
	signal txshift_s    : std_logic_vector(9 downto 0); 			-- Transmit Shift Register 
					    
	signal txbitcnt_s   : unsigned(3 downto 0); 					-- 9 to 0 bit counter
	signal tsrl_s       : std_logic;								-- latch Data
	signal tdre_s       : std_logic;	
	signal tsre_re_s	: std_logic;	
	
    type   rxstates is (sHigh,sLow,sData,sLatch,sError);            -- Receive Statemachine
    signal rxstate      : rxstates;
    
	type   txstates is (txidle,txdata); 			       			-- Transmit Statemachine
    signal txstate      : txstates;
	
	type   rdrfstates is (rdrfidle,rdrfhigh,checkcs,rdhigh); 		-- RDRF flag fsm, keep asserted until after read cycle
    signal rdrfstate    : rdrfstates;
		
    signal rxshift_s    : std_logic_vector(8 downto 0);             -- Receive Shift Register (9 bits!) 
    signal rxbitcnt_s   : integer range 0 to 10;
    signal samplecnt_s  : integer range 0 to 15;
              
	signal rdrf_s       : std_logic;
	signal rsrl_s		: std_logic;								-- Receive Shift Register Latch (RXCLK16)
	signal rsrl_re_s	: std_logic;								-- rsrl rising edge

	signal txirqen_s    : std_logic;								-- Interrupt Enable bits
	signal rxirqen_s    : std_logic;
	
	component redge                             					-- Rising edge strobe set/reset flag
	generic(RESHL  : std_logic:='1';	 							-- Reset Active High/Low
            RESVAL : std_logic:='0');	 							-- Flag default value after reset
    port(clk       : in  std_logic;    								-- System Clock   
        reset      : in  std_logic;           					
        strobe     : in  std_logic;    								-- Flag assert strobe (slow clock)
        clredge    : in  std_logic;    								-- Rising_edge clear signal
   	    pulse      : out std_logic;	 								-- Rising edge clk wide pulse
   	    flag       : out std_logic);            
	end component;

begin 

	EDGE1 :redge generic map ('1','0') port map (clk,SRESET,rsrl_s,'0',rsrl_re_s,OPEN);
	EDGE2 :redge generic map ('1','1') port map (clk,SRESET,tsrl_s,'0',tsre_re_s,OPEN);

	IRQ   <= '1' when (tsre_re_s='1' AND txirqen_s='1') OR (rsrl_re_s='1' AND rxirqen_s='1') else '0';

	-----------------------------------------------------------------------------------------------
	-- Processor I/F					    
	-----------------------------------------------------------------------------------------------
	process(all)
	begin
		if abus=STATUS_C then
			DBUSO <= "000000"&rdrf_s&tdre_s;
		else
			DBUSO <= rxreg_s; 										-- default to RXHOLD_C
		end if;	
	end process;
	
	
	process(clk)  
    begin 			
		if rising_edge(clk) then
			if SRESET='1' then  									-- Sync Reset                   
				txirqen_s 	<= '0';									-- Transmit Enable Interrupt, disabled by default
				rxirqen_s 	<= '0';									-- Receive Enable Interrupt, disabled by default
				tdre_s 		<= '1';
				txreg_s		<= (others => '1');
			else
				if (WR='1' AND CS='1' AND abus=TXHOLD_C) then 		-- Write to Transmit Register
					txreg_s <= DBUSI;
					tdre_s  <= '0';
				elsif tsre_re_s='1' then
					tdre_s <= '1';
				end if;
				
				if (WR='1' AND CS='1' AND abus=IRQENA_C) then		-- Use config Register bit 0 and 1
					txirqen_s <= DBUSI(0);
					rxirqen_s <= DBUSI(1);
				end if;	
			end if;
		end if;
	end process;

    -----------------------------------------------------------------------------------------------
    -- RDRF flag FSM, keep flag asserted until after the read cycle which can span more than one
	-- clk cycle.
	-- Also make sure the rdrf flag is not asserted in the middle of a poll status reg operation.
    -----------------------------------------------------------------------------------------------
	process(clk)  
    begin 			
		if rising_edge(clk) then
			if SRESET='1' then  									-- Sync Reset                   
				rdrfstate <= rdrfidle; 
				rdrf_s    <= '0';
			else
				case rdrfstate is                       
                    when rdrfidle => 
						if rsrl_re_s='1' then
							rdrfstate <= checkcs; 
							--rdrf_s    <= '1';
						end if;
					when checkcs =>									-- Make sure not to assert flag in the middle 
						if CS='0' then 								-- of a check flag read cycle
							rdrfstate<=rdrfhigh; 
							rdrf_s    <= '1';
						end if;
					when rdrfhigh => 
						if CS='1' AND abus=STATUS_C then			-- Wait for Status read
							rdrfstate<=rdhigh; 
						end if;
					when rdhigh =>
						if CS='0' then
							rdrfstate <= rdrfidle;
							rdrf_s    <= '0';
						end if;						
					--when others => rdrfstate <= rdrfidle;         
                end case;   
			end if;
		end if;
	end process;



    -----------------------------------------------------------------------------------------------
    -- UART bitrate divider, create x16 rx and and x1 txclock
	-- System clock CLK is divided by CLK16UART then by another 16 for TX clock (=baudrate)
    -----------------------------------------------------------------------------------------------
    process(clk)                                                    
    begin
        if rising_edge(clk) then 
            if SRESET='1' then                     
                uartdivcnt_s <= 0;  
				div16_s      <= (others => '0');				
                rxclk16_s    <= '0';
				txclk1_s     <= '0';
            else               
                if uartdivcnt_s=CLK16UART-1 then 
                    uartdivcnt_s <= 0;
                    rxclk16_s    <= '1';
					div16_s <= div16_s + 1;					
					if div16_s="1110" then
						txclk1_s <= '1';
					else
						txclk1_s <= '0';
					end if;					
                else 
					rxclk16_s    <= '0';
					txclk1_s     <= '0';
                    uartdivcnt_s <= uartdivcnt_s + 1;
                end if;	
            end if;
      end if;   
    end process;
	
    -----------------------------------------------------------------------------------------------
    -- UART Receiver
    -----------------------------------------------------------------------------------------------
    process(clk)  
    begin           
        if rising_edge(clk) then
            if SRESET='1' then                                      -- Sync Reset                   
                rxreg_s     <= (others => '1');                     -- Sim only 
                rxstate     <= sHigh;                               -- Wait for Rising edge
                samplecnt_s <= 6;
                rxbitcnt_s  <= 0;
                rsrl_s      <= '0';
				rxshift_s   <= (others => '1'); 
            elsif rxclk16_s='1' then                              	-- Only action on Sampling clock
                case rxstate is                       
                    when sHigh => 
                        rsrl_s      <= '0'; 
						samplecnt_s <= 6;
						rxbitcnt_s  <= 0;
                        if RX='1' then                               
                            rxstate <= sHigh;                       -- Wait for falling edge
                        else 
                            rxstate <= sLow;                        -- rx data line is low, start bit?
                        end if;                 
                        
                    when sLow =>                                    -- Next wait 16/2 samples
                        if RX='0' AND samplecnt_s=0 then            -- After 8 samples RX is still low so startbit detected
                            rxstate <= sData;                       -- Start filling RX reg
                            samplecnt_s <= 15;
                        elsif RX='1' then                           -- Not a valid startbit, 
                            rxstate <= sHigh;                         
                        else
                            samplecnt_s <= samplecnt_s-1;			
                        end if;
						
                    when sData =>                                   -- Start logging 8 databits
                        if samplecnt_s=0 then                       -- sample bit
                            rxshift_s <= RX & rxshift_s(8 downto 1);-- 9bits
                            if rxbitcnt_s=8 AND RX='1' then
                                rxstate <= sLatch;    
                            elsif rxbitcnt_s=8 AND RX='0' then      -- Incorrect Stopbit, must be 1
                                rxstate <= sError;    
                            else
                                rxstate <= sData;
                            end if;
                            rxbitcnt_s  <= rxbitcnt_s+1;
							samplecnt_s <= 15;
						else
							samplecnt_s <= samplecnt_s-1;
                        end if;
						
                    when sLatch =>                                  -- Valid frame received latch into rxchar and set RDRF flag
                        rxreg_s <= rxshift_s(7 downto 0);         
                        rsrl_s  <= '1';                     
                        rxstate <= sHigh;
                    
                    when sError =>
                        if RX='0' then                               
                            rxstate <= sError;                      -- Wait RX to go high again
                        else 
                            rxstate <= sHigh;                       -- Restart checking for falling edge
                        end if; 
                         
                    --when others => rxstate <= sHigh;              
                end case;                       
            end if;  
        end if;
    end process;    
    
    -----------------------------------------------------------------------------------------------
    -- TX UART
    -----------------------------------------------------------------------------------------------
	process (clk)  	
    begin        
		if (rising_edge(clk)) then		
			if SRESET='1' then
				txshift_s  <= (others => '1');       				-- init to all '1' (including start bit)                      
				txbitcnt_s <= (others => '0');        				-- bit counter
				txstate    <= txidle;
			else
				if txclk1_s='1' then
					case txstate is
						when txidle =>
							txshift_s  <= (others => '1');      	-- No data, tx continuous 1
							txbitcnt_s <= (others => '0');	
							if tdre_s='0' then
								txstate   <= txdata;
								txshift_s <= '1'&txreg_s&'0';      	-- yes, latch it and start shifting 
							end if;
						when txdata =>	
							if tsrl_s='1' AND tdre_s='0' then  		-- New data pending
								txshift_s  <= '1'&txreg_s&'0';      -- yes, latch it and start shifting again
								txbitcnt_s <= (others => '0');							
							elsif tsrl_s='1' AND tdre_s='1' then	-- No new data pending, goto idle
								txshift_s  <= (others => '1');      -- No data, tx continuous 1
								txbitcnt_s <= (others => '0');	
								txstate    <= txidle;		
							else
								txshift_s  <= '1' & txshift_s(9 downto 1);	-- shift right
								txbitcnt_s <= txbitcnt_s + 1;
							end if; 
						--when others => txstate <= txidle;		
					end case;
				end if;
			end if;
		end if;                                               
	end process; 
	
	tsrl_s <= '1' when txbitcnt_s="1001" else '0';
	tx   <= txshift_s(0);                       					-- transmit pin	
	
	   
end rtl;

