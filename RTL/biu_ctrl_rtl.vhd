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
--	Bus Interface Unit
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author         
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

entity biu_ctrl is
   generic(HW_RVC_G : boolean := true);	  					    -- support compressed instruction set
   port( 
      busreq    : IN     std_logic;
      clk       : IN     std_logic;
      dbusi     : IN     std_logic_vector (31 DOWNTO 0);
	  fifo_full : IN     boolean;
	  proco     : IN     iproc_out_type;
      sreset    : IN     std_logic;
      abus      : OUT    std_logic_vector (31 DOWNTO 0);
      ads       : OUT    std_logic;
	  be        : OUT    std_logic_vector(3 downto 0);
      busack    : OUT    std_logic;
      dbuso     : OUT    std_logic_vector (31 DOWNTO 0);
      fifo_clr  : OUT    std_logic;
      fifo_in   : OUT    std_logic_vector (63 DOWNTO 0);
      fifo_wr   : OUT    std_logic;
      rd        : OUT    std_logic;
      wr        : OUT    std_logic;
	  proci     : OUT    iproc_in_type
   );
   
-- Declarations
END ENTITY biu_ctrl;

--
ARCHITECTURE rtl3 OF biu_ctrl IS

	type   biu_states is (sADS,sJumpWord,sData,sDataTmp162,sBusReq,sLoad,sStore,sStoreAck,sLoadAck);
    signal current_biu_state : biu_states; 						
	signal next_biu_state_s  : biu_states;	
    signal return_state      : biu_states; 						
	signal return_state_s    : biu_states;	

	signal pc_s         : unsigned(31 downto 0);
	signal pc           : unsigned(31 downto 0);
	signal abus_s       : unsigned(31 downto 0);
	signal dbusi_msw    : std_logic_vector(15 downto 0);
	signal dbusi_pre    : std_logic_vector(31 downto 0);			-- Previous dbusi value
	

	signal ads_s        : std_logic;
	signal rd_abus_s    : std_logic;								
	signal rdopc_s      : std_logic; 
	signal rdjmpw_s     : std_logic; 								-- Read msw during odd jump
	signal rdjmpw       : std_logic; 
	signal wr_s         : std_logic; 
	
	signal rdmem_s      : std_logic; 
	signal rdmem        : std_logic;	
	
	signal compr_lsw_s  : boolean;
	signal compr_msw_s  : boolean;
	
	signal split_read   : boolean;									-- 16bits followed by 32bits read, in this case we write
	signal split_read_s : boolean;									--  the MSW from the previous read + LSW of the new read
	
	signal fifo_wr_s    : std_logic;
	
	signal abus_tmp     : unsigned(31 downto 0);					-- Store Address when doing load/store/busreq
	signal temp_read_s  : boolean;
	
	signal pre_read     : boolean;
	signal pre_read_s   : boolean;
	
begin

      
	fifo_wr  <= fifo_wr_s;
	rd       <= rdopc_s OR rdmem OR rdjmpw;
	
	proci.memdata_s <= unsigned(dbusi);								-- Unlatched, used in proc for feedback path
	be       <= proco.be;
	
	-----------------------------------------------------------------------------------------------
    -- Bus Interface FSM
    -----------------------------------------------------------------------------------------------	
    process(all)  
    begin  
		
		fifo_in(31 downto 0)  <= std_logic_vector(pc);
		if pre_read then 
			fifo_in(63 downto 32) <= dbusi_pre;						-- Use previous value
		else
			if split_read OR temp_read_s then
				fifo_in(63 downto 32) <= dbusi(15 downto 0) & dbusi_msw;
			else
				fifo_in(63 downto 32) <= dbusi;		
			end if;
		end if;
		
		-- detect 16bits instructions, not fully decoded, x"0000" not covered 
		compr_lsw_s<= true when fifo_in(33 downto 32)/="11" else false;
		compr_msw_s<= true when fifo_in(49 downto 48)/="11" else false;	
		
		split_read_s <= split_read;									-- Default values
		
		next_biu_state_s <= current_biu_state;
		return_state_s   <= return_state;		

		fifo_clr    <= proco.jump;			
		
		abus_s      <= unsigned(abus);								
		ads_s       <= '0';	
		rdjmpw_s    <= '0';
		pc_s        <= pc;
		fifo_wr_s   <= '0';												
		rdopc_s     <= '0';
		rd_abus_s   <= '0';
		rdmem_s     <= '0';	
		wr_s        <= '0';		
		busack      <= '0';
		proci.lsack <= '0';
		temp_read_s <= FALSE;
		pre_read_s  <= FALSE;
			
		-------------------------------------------------------------------------------------------
		-- We are allowed to read the same opcode address, this is not the case for load operations
		-------------------------------------------------------------------------------------------
		case current_biu_state is  							
			when sADS =>											-- ADS pulse used for init
				rd_abus_s <= '1';
				return_state_s <= sADS;								-- Return state for Load/Store/BusRequest states
				
				if proco.jump='1' then								-- default jump to sData
					ads_s     <= '1';						
					abus_s    <= proco.memaddr(31 downto 2)&"00";
					pc_s      <= proco.memaddr;
					split_read_s <= false;
					
					if proco.memaddr(1)='1' then 					-- odd address from jump
						next_biu_state_s <= sJumpWord;
					end if;			
					
				elsif proco.store='1' then					
					ads_s     <= '1';						
					abus_s    <= proco.memaddr;
					next_biu_state_s <= sStore;	
				elsif proco.load='1' then
					ads_s     <= '1';						
					abus_s    <= proco.memaddr;
					next_biu_state_s <= sLoad;									
				elsif busreq='1' then				
					next_biu_state_s <= sBusReq;												
				else
					ads_s     <= '1';
					abus_s    <= unsigned(abus) + 4;				-- This changed cache output on next cycle
					next_biu_state_s <= sData;
				end if;
		
			when sJumpWord =>										-- Jump to odd address, need to fill dbusi_msw
				ads_s        <= '1';
				rdjmpw_s     <= '1';
				split_read_s <= true;
				abus_s <= unsigned(abus) + 4;						-- This changed cache output on next cycle
				next_biu_state_s <= sAds;
		
			when sData =>	
				return_state_s <= sADS;								-- Return state for Load/Store/BusRequest states
				
				if proco.jump='1' then
					ads_s     <= '1';						
					abus_s    <= proco.memaddr(31 downto 2)&"00";
					pc_s      <= proco.memaddr;
					split_read_s <= false;
					if proco.memaddr(1)='1' then -- odd address from jumo
						next_biu_state_s <= sJumpWord;
					else
						next_biu_state_s <= sADS;
					end if;								
					
				elsif proco.store='1' then					
					ads_s     <= '1';						
					abus_s    <= proco.memaddr;
					next_biu_state_s <= sStore;	
				elsif proco.load='1' then
					ads_s     <= '1';						
					abus_s    <= proco.memaddr;
					next_biu_state_s <= sLoad;									
				elsif busreq='1' then			
					next_biu_state_s <= sBusReq;												
					
				elsif NOT fifo_full then							-- We can write to FIFO

					if compr_lsw_s AND compr_msw_s then				-- Two 16bits opcodes, make 2 FIFO writes, first one here	
						fifo_wr_s <= '1';							-- Write 16bits opcode here first, then write second 16bits opcode	
						rdopc_s   <= '1'; 	
						pc_s      <= pc + 2;
						rd_abus_s <= '1';	
													
						if split_read then 							-- We are in split read mode
							if pc(1)='1' then 						-- back to 32bits sync read
								split_read_s <= FALSE;
								ads_s  <= '1';
								rd_abus_s <= '0';									
								pre_read_s <= TRUE;
							else
								next_biu_state_s <= sDataTmp162;
							end if;
						else
							next_biu_state_s <= sDataTmp162;
						end if;

					elsif compr_lsw_s then 							-- Single 16bits opcode, make 1 FIFO write						
						fifo_wr_s <= '1';								
						rdopc_s   <= '1'; 
						pc_s      <= pc + 2;						
						rd_abus_s <= '1';
						
						if split_read then 							-- We are in split read mode
							if pc(1)='1' then 						-- back to 32bits sync read
								split_read_s <= FALSE;
								ads_s  <= '1';
								pre_read_s <= TRUE;	
								rd_abus_s <= '0';									
							else
								ads_s  <= '1';							
								abus_s <= unsigned(abus) + 4;	
							end if;
						else
							if pc(1)='0' then 						-- we are even , then +2 makes odd
								split_read_s <= TRUE;				-- Next read will be split, use pc(1) for this???
							end if;
							ads_s  <= '1';							
							abus_s <= unsigned(abus) + 4;						
						end if;
				
						
					else 											-- Normal 32bits opcode	
						fifo_wr_s <= '1';	
						rdopc_s   <= '1'; 
						pc_s      <= pc + 4;
						rd_abus_s <= '1';
						
						ads_s     <= '1';	
						abus_s    <= unsigned(abus) + 4;
					end if;

				else												-- FIFO is full
					ads_s  <= '1';
					abus_s <= abus_tmp;					
					next_biu_state_s <= sADS;	
				end if;
							
			when sDataTmp162 =>										-- Second MS 16bits Word FIFO write		

				if proco.jump='1' then
					ads_s     <= '1';						
					abus_s    <= proco.memaddr(31 downto 2)&"00";
					pc_s      <= proco.memaddr;
					split_read_s <= false;
					--next_biu_state_s <= sADS;
					if proco.memaddr(1)='1' then -- odd address from jumo
						next_biu_state_s <= sJumpWord;
					else
						next_biu_state_s <= sADS;
					end if;		
					
					
				elsif proco.store='1' then					
					ads_s     <= '1';						
					abus_s    <= proco.memaddr;
					next_biu_state_s <= sStore;	
					return_state_s <= sDataTmp162;					-- Return state for Load/Store/BusRequest states
				elsif proco.load='1' then
					ads_s     <= '1';						
					abus_s    <= proco.memaddr;
					next_biu_state_s <= sLoad;	
					return_state_s <= sDataTmp162;										
				elsif busreq='1' then				
					next_biu_state_s <= sBusReq;
					return_state_s <= sDataTmp162;										

				elsif NOT fifo_full then							-- We can write to FIFO
					temp_read_s <= TRUE;							-- Force temp read without split_read true
					
					fifo_wr_s <= '1';	
					rdopc_s   <= '1'; 					
					pc_s      <= pc + 2;						
					rd_abus_s <= '1';		
					
					ads_s     <= '1';											
					abus_s    <= unsigned(abus) + 4;
					next_biu_state_s <= sData;
				end if;			
							
			when sBusReq =>											-- Write last data 
				busack <= '1';
				if busreq='0' then
					ads_s  <= '1';
					abus_s <= abus_tmp;
					next_biu_state_s <= return_state;
				end if;
			
			when sStore =>											-- Store Address/ads cycle
				wr_s   <= '1';										-- Assert next cycle
				next_biu_state_s <= sStoreAck;			
			when sStoreAck =>													
				ads_s  <= '1';
				abus_s <= abus_tmp;
				proci.lsack <= '1';
				next_biu_state_s <= return_state;

			when sLoad =>											-- Load Address/ads cycle
				rdmem_s <= '1';										-- assert next cycle							
				--proci.lsack <= '1';
				next_biu_state_s <= sLoadAck;
			when sLoadAck =>										-- Write data to memory	 
				ads_s  <= '1';
				abus_s <= abus_tmp;
				proci.lsack <= '1';
				next_biu_state_s <= return_state;
			
		end case; 				
    end process;  



    process(clk)  
    begin                       	
		if rising_edge(clk) then					
			if sreset='1' then   
				abus         <= std_logic_vector(RESET_VECTOR_C);
				ads          <= '1';				
				abus_tmp     <= RESET_VECTOR_C;
				pc		     <= RESET_VECTOR_C;
				dbuso        <= (others => '0');
				wr 	         <= '0';	
				rdmem 	     <= '0';
				rdjmpw       <= '0';
				proci.memdata<= (others => '0');	
				split_read   <= FALSE;
				dbusi_msw    <= (others => '0');					-- Storage for split reads, 16bits then 32bits
				current_biu_state <= sADS;    						-- First ADS pulse, used only for 0 waitstates				
				return_state <= sADS;								-- Return state used for load/store

			else
				dbuso <= std_logic_vector(proco.memdata);

				rdmem 	  <= rdmem_s;				
				wr 	      <= wr_s;	
				split_read<= split_read_s;	
				pre_read  <= pre_read_s;				
				pc        <= pc_s;
				ads       <= ads_s;
				rdjmpw    <= rdjmpw_s;
				
				abus  <= std_logic_vector(abus_s);

				current_biu_state <= next_biu_state_s;	
				return_state      <= return_state_s;				
					
				if rdjmpw='1' then -- jump to odd address
					dbusi_msw <= dbusi(31 downto 16);	
				end if;
					
				if rdopc_s='1' then 
					if NOT pre_read then
						dbusi_msw <= dbusi(31 downto 16);	
					end if;
					dbusi_pre <= dbusi;			-- fix this			
				end if;
				if rd_abus_s='1' then 
					abus_tmp  <= unsigned(abus);	
				end if;				
				
			
				if rdmem='1' then
					proci.memdata <= unsigned(dbusi);
				end if;

			end if;
		end if;  
    end process;  
END ARCHITECTURE rtl3;

