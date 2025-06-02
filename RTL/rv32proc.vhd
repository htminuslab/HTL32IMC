---------------------------------------------------------------------------------------------------
--                                                                           
--  HTLRV32 Risc-V Processor                                           
--  Copyright (C) 2019-2025 HT-LAB                                           
--                                                                                                           
--  https://github.com/htminuslab                                                                            
---------------------------------------------------------------------------------------------------        
---------------------------------------------------------------------------------------------------
--
--	Instruction Processor
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision        Author  
--  25/05/2025      1.1 			HABT, Checked with Questa Base 2025.1, uploaded to github    
--
-- ***************************************************************
-- Device Utilization for 7S100FGGA676
-- ***************************************************************
-- Resource                          Used    Avail   Utilization
-- ---------------------------------------------------------------
-- IOs                               107     400      26.75%
-- Global Buffers                    1       32        3.13%
-- LUTs                              2202    64000     3.44%
-- CLB Slices                        431     16000     2.69%
-- Dffs or Latches                   756     128000    0.59%
-- Block RAMs                        1       120       0.83%
--    RAMB18E1                       2                     
-- Distributed RAMs
-- - RAM32M                          11                    
-- DSP48E1s                          12      160       7.50%
---------------------------------------------------------------
--	clk_PS                  clk     9.457 (105.742 MHz)           10.000 (100.000 MHz)
--
-- IOs                               107     400      26.75%
-- Global Buffers                    1       32        3.13%
-- LUTs                              2141    64000     3.35%
-- CLB Slices                        422     16000     2.64%
-- Dffs or Latches                   682     128000    0.53%
-- Block RAMs                        1       120       0.83%
--    RAMB18E1                       2                     
-- Distributed RAMs
-- - RAM32M                          11                    
-- DSP48E1s                          12      160       7.50%
-- ---------------------------------------------------------------
-- clk_PS                  clk       9.223 (108.425 MHz)           10.000 (100.000 MHz)
--
-- LUTs                              1993    64000     3.11%
-- CLB Slices                        317     16000     1.98%
-- Dffs or Latches                   683     128000    0.53%
-- Block RAMs                        1       120       0.83%
--    RAMB18E1                       2                     
-- Distributed RAMs
-- - RAM32M                          11                    
-- DSP48E1s                          12      160       7.50%
-- clk_PS                  clk                                   10.083 (99.177 MHz)    
------------------------------------------------------------------
-- LUTs                              2227    64000     3.48%
-- CLB Slices                        430     16000     2.69%
-- Dffs or Latches                   728     128000    0.57%
-- Block RAMs                        1       120       0.83%
--   RAMB18E1                        2                     
-- Distributed RAMs
-- - RAM32M                          16                    
-- - RAM64M                          1                     
-- DSP48E1s                          12      160       7.50%
-- clk_PS                  clk                                   9.463 (105.675 MHz)       
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

ENTITY rv32proc IS
   GENERIC( 
      HW_MD_G  : boolean := true;      -- Enable Mul/Div
      HW_CNT_G : boolean := false      -- Enable Counters
   );
   PORT( 
      clk       : IN     std_logic;
      rs1       : IN     signed (31 DOWNTO 0);
      rs2       : IN     signed (31 DOWNTO 0);
      sreset    : IN     std_logic;
      rds       : OUT    rds_type;
      proco     : OUT    iproc_out_type;
      deco      : IN     idec_type;
      stall     : OUT    std_logic;
      proci     : IN     iproc_in_type;
      dividend  : OUT    unsigned (31 DOWNTO 0);
      divisor   : OUT    unsigned (31 DOWNTO 0);
      divsigned : OUT    boolean;
      divdone   : IN     std_logic;
      divstart  : OUT    boolean;
      remainder : IN     unsigned (31 DOWNTO 0);
      quotient  : IN     unsigned (31 DOWNTO 0);
      irq       : IN     std_logic_vector (3 DOWNTO 0)
   );

-- Declarations

END rv32proc ;

--
ARCHITECTURE rtl OF rv32proc IS

	signal rs1_s       : signed(31 downto 0);
    signal rs2_s       : signed(31 downto 0);	
  
	signal mtvec       : signed(31 downto 0); 						-- 0x305 If used then move to regfile?
	signal mtvec_s     : signed(31 downto 0); 						-- 0x305 If used then move to regfile?
	signal mepc        : signed(31 downto 0); 						-- 0x341 If used then move to regfile?
	signal mepc_s      : signed(31 downto 0); 						-- 0x341 If used then move to regfile?		
	signal mcause	   : signed(MAXIRQ-1+3+1 downto 0); 			-- MSB is interrupt(1) or exception(0)					
	signal mcause_s    : signed(MAXIRQ-1+3+1 downto 0); 						 	
	signal mie         : signed(MAXIRQ-1+3 downto 0); 				-- Used for Interrupts
	signal mie_s       : signed(MAXIRQ-1+3 downto 0); 				-- MAXIRQ + MTIP + MBREAK/MCALL + align(not implemented)
	signal mstatus     : std_logic_vector(1 downto 0); 
	signal mstatus_s   : std_logic_vector(1 downto 0);				-- Only MPIE/MEI bits are supported 	
	
	alias  csr         : signed(11 downto 0) is deco.imm(11 downto 0);
	
	signal cycle 	   : unsigned(63 downto 0);						-- Only used if HW_CNT_G is true
	signal mtimecmp    : unsigned(63 downto 0);	
	signal mtimecmp_s  : unsigned(63 downto 0);
	signal instret     : unsigned(63 downto 0);
	
	signal wfi_s       : std_logic;									-- Halt status
	
	
	type   procstates is (sProcIdle,sProcDiv,sProcHalt,sProcJump,sProcAck,sProcLoad,sProcStore);	-- Proc FSM sProcDivWR
    signal current_procstate : procstates;
	
	signal rds_selo_s  : std_logic_vector(4 downto 0);
	signal rds_data_s  : signed(31 downto 0);
	signal rds_wr_s    : std_logic;
	signal be_s        : std_logic_vector(3 downto 0);				-- Byte Enable, b4=SEXT passed on to regfile
	
	signal load_data_s : std_logic_vector(31 downto 0);
	
	signal memaddr_s   : signed(31 downto 0);
	signal memdata_s   : signed(31 downto 0);
	signal jump_s      : std_logic;
	signal load_s      : std_logic;
	signal store_s     : std_logic;
	signal exception_s : boolean;
	
	signal mul_s       : unsigned(63 downto 0);
	signal muls_s      : signed(63 downto 0);
	signal mulx_s      : signed(65 downto 0);						-- Note 66 bits
			
			
	signal irq_req 	   : boolean;
	signal irq_mcause  : signed(3 downto 0);						-- MSB indicates IRQ	
			
			
	--pragma synthesis_off	
	signal mhartid     : signed(31 downto 0):=(others=> '0');		-- 0xF14 If used then move to regfile	**not for synth **
	--pragma synthesis_on
	
begin

	--pragma synthesis_off			
	process(all)
	begin						
		if (deco.opcode/=OP_uNOP AND current_procstate=sProcIdle AND load_s='0' AND store_s='0') OR  
		   (current_procstate=sProcLoad  AND proci.lsack='1') OR 
		   (current_procstate=sProcStore AND proci.lsack='1') then
		else
		end if;
	end process;
	--pragma synthesis_on
	
	
	-----------------------------------------------------------------------------------------------
	-- Interrupt controller
	-- IRQ0 has the highest priority 
	-- mie : Machine Interrupt Enable Register
	--     : 0 IRQ0	Timer Interrupt
	--     : 1 	EBREAK/ECALL or Illegal Instruction
	--     : 2 	*** not implemented *** BUS Error Unaligned Memory Access
	--     : 3 IRQ3  
	--     : 4 IRQ4  
	--     : 5 IRQ5  MAXIRQ=3
	-----------------------------------------------------------------------------------------------
	process(clk)  
    begin   
		if rising_edge(clk) then	
			if sreset='1' then  
				irq_req <= false;
				irq_mcause <= (others => '0');						
			else	
				irq_mcause <= (others => '0');	
				if cycle >= mtimecmp AND mie(0)='1' then		-- IRQ0 Timer IRQ
					irq_mcause(0)<='1'; 
				elsif irq(1)='1' AND mie(3)='1' then			-- IRQ3
					irq_mcause(1)<='1';
				elsif irq(2)='1' AND mie(4)='1' then			-- IRQ4
					irq_mcause(2)<='1';			
				elsif irq(3)='1' AND mie(5)='1' then			-- IRQ5
					irq_mcause(3)<='1';			
				end if;

				if mstatus(0)='1' AND (OR irq_mcause(3 downto 0))='1' then -- TODO change to (MAXIRQ-1 downto 0)
					irq_req <= true;
				else
					irq_req <= false;
				end if;
								
			end if;
		end if;  
    end process; 
	


	process(all)
	begin
	
		load_s     <= '0';											-- Default values
		store_s    <= '0';
		
		rds_data_s <= (others => '-');
		rds_selo_s <= deco.rds_sel;
		rds_wr_s   <= deco.rds_wr;									-- Decoder assign zero for opcodes that don't write to rds
		
		exception_s<= false;
		
		divsigned  <= false;										-- Unsigned Divider
		
		memaddr_s  <= (others => '-');		
		
		memdata_s  <= (others => '-');-- change back later screws up comparison?? (others => '-');		
	
		muls_s 	   <= (others => '-');
		mul_s  	   <= (others => '-');
		mulx_s 	   <= (others => '-');		

		jump_s     <= '0';
		be_s       <= "1111";										-- Byte Select, lsb=b0
				
		mtvec_s    <= mtvec;										-- CSR register defaults
		mepc_s     <= mepc;
		mcause_s   <= mcause;										-- ????(31) & mcause(3 downto 0);
		mtimecmp_s <= mtimecmp;
		mie_s      <= mie;
		mstatus_s  <= mstatus;
		
		wfi_s      <= '0';
		
		-------------------------------------------------------------------------------------------
		-- Register WAR PROC write to rds_selo, DEC latches address RS1_ADDR and RS2_ADDR
		-- Required as we latch the rd write, select and data signals so the next instruction does
		-- not get the correct data unless we add the bypass muxes, check if generated regfile with
		-- bypass fixes this problems as 32bits wide muxes consume a lot of luts!
		-------------------------------------------------------------------------------------------
		if deco.rs1_sel=rds.selo AND rds.wr='1' then				-- TODO we can perform this comparison during decoding?
			rs1_s <= signed(rds.data);								-- Feedback path
		else
			rs1_s <= rs1;											-- From regfile
		end if;

		if deco.rs2_sel=rds.selo AND rds.wr='1' then
			rs2_s <= signed(rds.data);								-- Feedback path
		else
			rs2_s <= rs2;											-- From regfile
		end if;	
	
		-------------------------------------------------------------------------------------------
		-- Serial Divider
		-------------------------------------------------------------------------------------------
		if deco.divrem='1' AND proco.jump='0' AND stall='0' AND HW_MD_G then
			divstart <= true; 										-- simply comb assignment?
		else
			divstart <= false;
		end if;
		
		if HW_MD_G then
			dividend  <= unsigned(rs1_s);
			divisor   <= unsigned(rs2_s);
		else
			dividend  <= (others => '-');
			divisor   <= (others => '-');
		end if;
		
		case deco.opcode is
			when OP_LUI   => rds_data_s <= deco.imm;                 
			when OP_AUIPC => rds_data_s <= deco.pc+deco.imm; 
			when OP_JAL   => 
				if deco.compressed then
					rds_data_s <= deco.pc+2;
				else
					rds_data_s <= deco.pc+4; 
				end if;
				memaddr_s <= deco.pc+deco.imm; jump_s <= '1';
				
			when OP_JALR => 
				if deco.compressed then
					rds_data_s <= deco.pc+2; 
				else
					rds_data_s <= deco.pc+4; 
				end if;
				memaddr_s <= rs1_s+deco.imm; memaddr_s(0) <= '0'; jump_s <= '1';
				
			when OP_BEQ  => memaddr_s <= deco.pc+deco.imm; if rs1_s=rs2_s  then jump_s <= '1'; end if;
			when OP_BNE  => memaddr_s <= deco.pc+deco.imm; if rs1_s/=rs2_s then jump_s <= '1'; end if;
			when OP_BLT  => memaddr_s <= deco.pc+deco.imm; if rs1_s<rs2_s  then jump_s <= '1'; end if;
			when OP_BGE  => memaddr_s <= deco.pc+deco.imm; if rs1_s>=rs2_s then jump_s <= '1'; end if;
			when OP_BLTU => memaddr_s <= deco.pc+deco.imm; if unsigned(rs1_s)<unsigned(rs2_s)  then jump_s <= '1'; end if;
			when OP_BGEU => memaddr_s <= deco.pc+deco.imm; if unsigned(rs1_s)>=unsigned(rs2_s) then jump_s <= '1'; end if;
			
			when OP_LB =>  
				load_s    <= '1';				
				memaddr_s <= rs1_s+deco.imm; 
				case memaddr_s(1 downto 0) is
					when "00"   => be_s <= "0001";
					when "01"   => be_s <= "0010";
					when "10"   => be_s <= "0100";
					when others => be_s <= "1000";
				end case;  
		
			when OP_LH => 
				load_s    <= '1';	
				memaddr_s <= rs1_s+deco.imm;
				if proco.memaddr(1) then
					be_s <= "1100";
				else
					be_s <= "0011";
				end if;
			
			when OP_LW => 
				load_s    <= '1';	
				memaddr_s <= rs1_s+deco.imm; 
								
			when OP_LBU =>
				load_s    <= '1';	
				memaddr_s <= rs1_s+deco.imm; 
				case proco.memaddr(1 downto 0) is
					when "00"   => be_s <= "0001";
					when "01"   => be_s <= "0010";
					when "10"   => be_s <= "0100";
					when others => be_s <= "1000";
				end case;
				
			when OP_LHU =>
				load_s    <= '1';
				memaddr_s <= rs1_s+deco.imm; 
				if proco.memaddr(1) then
					be_s <= "1100";
				else
					be_s <= "0011";
				end if;
				
			when OP_SB =>
				store_s   <= '1';
				memaddr_s <= rs1_s+deco.imm;  
				case memaddr_s(1 downto 0) is
					when "00"   => memdata_s(7  downto 0)  <= rs2_s(7 downto 0); be_s <= "0001";
					when "01"   => memdata_s(15 downto 8)  <= rs2_s(7 downto 0); be_s <= "0010";
					when "10"   => memdata_s(23 downto 16) <= rs2_s(7 downto 0); be_s <= "0100";
					when others => memdata_s(31 downto 24) <= rs2_s(7 downto 0); be_s <= "1000";
				end case;	
				
			when OP_SH =>
				store_s   <= '1';
				memaddr_s <= rs1_s+deco.imm; 
				if memaddr_s(1)='1' then
					memdata_s(31 downto 16) <= rs2_s(15 downto 0); be_s <= "1100";
				else
					memdata_s(15 downto 0)  <= rs2_s(15 downto 0); be_s <= "0011";
				end if;
				
			when OP_SW =>
				store_s   <= '1';
				memaddr_s <= rs1_s+deco.imm; 
				memdata_s <= rs2_s;
			
			when OP_ADDI   => rds_data_s <= rs1_s + deco.imm; 
			when OP_SLTI   => rds_data_s <= X"00000001" when rs1_s<deco.imm else X"00000000"; 
			when OP_SLTIU  => rds_data_s <= X"00000001" when unsigned(rs1_s)<unsigned(deco.imm) else X"00000000"; 
			when OP_XORI   => rds_data_s <= rs1_s XOR deco.imm; 
			when OP_ORI    => rds_data_s <= rs1_s OR  deco.imm; 
			when OP_ANDI   => rds_data_s <= rs1_s AND deco.imm; 
			when OP_SLLI   => rds_data_s <= signed(shift_left(unsigned(rs1_s),to_integer(unsigned(deco.imm(4 downto 0)))));  -- TODO Note Barrel shifter
			when OP_SRLI   => rds_data_s <= signed(shift_right(unsigned(rs1_s),to_integer(unsigned(deco.imm(4 downto 0))))); 
			when OP_SRAI   => rds_data_s <= shift_right(rs1_s,to_integer(unsigned(deco.imm(4 downto 0)))); 
			when OP_ADD    => rds_data_s <= rs1_s + rs2_s; 
			when OP_SUB    => rds_data_s <= rs1_s - rs2_s; 
			when OP_SLL    => rds_data_s <= signed(shift_left(unsigned(rs1_s),to_integer(unsigned(rs2_s(4 downto 0))))); 
			when OP_SLT    => rds_data_s <= X"00000001" when rs1_s<rs2_s else X"00000000"; 
			when OP_SLTU   => rds_data_s <= X"00000001" when unsigned(rs1_s)<unsigned(rs2_s) else X"00000000"; 
			when OP_XOR    => rds_data_s <= rs1_s XOR rs2_s; 
			when OP_OR     => rds_data_s <= rs1_s OR  rs2_s; 
			when OP_AND    => rds_data_s <= rs1_s AND rs2_s; 			
			when OP_SRL    => rds_data_s <= signed(shift_right(unsigned(rs1_s),to_integer(unsigned(rs2_s(4 downto 0))))); 
			when OP_SRA    => rds_data_s <= shift_right(rs1_s,to_integer(unsigned(rs2_s(4 downto 0)))); 
			
			when OP_MUL    => 
				if HW_MD_G then
					mul_s  <= unsigned(rs1_s)*unsigned(rs2_s); 
					rds_data_s <= signed(mul_s(31 downto 0)); 
				else
					assert FALSE report "Unsupported MUL instruction" severity error;
				end if;
			when OP_MULH   => 
				if HW_MD_G then
					muls_s <= rs1_s*rs2_s;                     rds_data_s <= muls_s(63 downto 32);       
				else
					assert FALSE report "Unsupported MULH instruction" severity error;

				end if;
			when OP_MULHU  => 
				if HW_MD_G then
					mul_s  <= unsigned(rs1_s)*unsigned(rs2_s); rds_data_s <= signed(mul_s(63 downto 32));
				else
					assert FALSE report "Unsupported MULHU instruction" severity error;
				end if;			
			when OP_MULHSU => 
				if HW_MD_G then
					mulx_s <= (rs1_s(31)&rs1_s)*('0'&rs2_s);   rds_data_s <= mulx_s(63 downto 32);     
				else
					assert FALSE report "Unsupported MULHSU instruction" severity error;
				end if;			
			when OP_DIV  | OP_REM  => 
				if HW_MD_G then
					rds_wr_s <= divdone; divsigned <= true; -- Signed Divider
				else
					assert FALSE report "Unsupported DIV/REM instruction" severity error;
				end if;	
			when OP_DIVU | OP_REMU => 
				if HW_MD_G then
					rds_wr_s <= divdone;
				else
					assert FALSE report "Unsupported DIVU/REMU instruction" severity error;
				end if;	
				
			-- Write CSRW csr,rs1_s is encoded as CSRRW x0,csr,rs1_s			
			when OP_CSRRW  =>										-- Read/Write, Swap CSR with Reg values
				rds_data_s <= (others => '0');
				case csr is 
					-------------------------------------------------------------------------------
					-- mie : Machine Interrupt Enable Register      Software
					--     : 0 	Timer Interrupt						bit7 MTIE
					--     : 1 	EBREAK/ECALL or Illegal Instr		
					--     : 2 	*** not imp *** BUS Error
					--     : 3 IRQ3  								bit16
					--     : 4 IRQ4  								bit17
					-------------------------------------------------------------------------------
					when MIE_ADDR_C =>								-- Machine Interrupt Enable Register
						rds_data_s(7)    <= mie(0); 				-- MTIP
						
						for i in 0 to MAXIRQ-1 loop  				
							rds_data_s(16+i) <= mie(3+i);			-- IRQ3,4,5,6
						end loop;
						
						mie_s <= rs1_s(16+MAXIRQ-1 downto 16)&"00"&rs1_s(7);--  IRQ & MTIP(7)
					
                 -- when MIP_ADDR_C =>								-- Machine Interrupt Pending Register
				
					when MCAUSE_ADDR_C => 							-- mcause
						rds_data_s(31) <= mcause(MAXIRQ-1+3+1);		-- bit7 indicated IRQ mapped to bit31
						rds_data_s(7)  <= mcause(0);
						for i in 0 to MAXIRQ-1 loop  				
							rds_data_s(16+i) <= mcause(3+i);		-- IRQ3,4,5,6
						end loop;					
						mcause_s(MAXIRQ-1+3+1) <= rs1_s(31);		-- Interrupt bit
						for i in 0 to MAXIRQ-1 loop
							mcause_s(3+i)   <= rs1_s(16+i);			-- Cause
						end loop;	
						
					when MSTATUS_ADDR_C => 							-- Required for test
						rds_data_s(3) <= mstatus(0);				-- MIE bit 
						rds_data_s(7) <= mstatus(1);				-- MPIE bit 					
						mstatus_s  <= rs1_s(7)&rs1_s(3);											
					when MTVEC_ADDR_C =>
						rds_data_s <= mtvec;
						mtvec_s    <= rs1_s;
					when MEPC_ADDR_C =>
						rds_data_s <= mepc;
						mepc_s     <= rs1_s;
					when others =>
						if HW_CNT_G then
							case csr is
								when MTIMECMP_CNT_C =>							-- Using custom CSR reg as mtimecmp register!
									mtimecmp_s(31 downto 0) <= unsigned(rs1_s);
								when MTIMECMPH_CNT_C =>							-- Using custom CSR reg as mtimecmph register!
									mtimecmp_s(63 downto 32)<= unsigned(rs1_s);															
								when others => 
								  --pragma synthesis_off
									assert FALSE report "Unsupported CSRRW operation to csr=0x"&to_hstring(deco.imm(11 downto 0))  severity error;
									--pragma synthesis_on
									
							end case;
						else
						  --pragma synthesis_off
							assert FALSE report "Unsupported CSRRW operation to csr=0x"&to_hstring(deco.imm(11 downto 0))  severity error;
							--pragma synthesis_on
						end if;
				end case;	
				
			-- Read  CSRR rd,csr is encoded as CSRRS rd,csr,x0
			when OP_CSRRS  =>										-- Read and Set csr bits, rs1_s=bitmask
				rds_data_s <= (others => '0');
				case csr is 
					when MIE_ADDR_C =>								-- Machine Interrupt Enable Register
						rds_data_s(7)    <= mie(0); 				-- MTIP										
						for i in 0 to MAXIRQ-1 loop  				
							rds_data_s(16+i) <= mie(3+i);			-- IRQ3,4,5,6 mapped to bits 16,17,..
						end loop;
		
					when MCAUSE_ADDR_C => 							-- mcause
						rds_data_s(31) <= mcause(MAXIRQ-1+3+1);		-- bit7 is IRQ
						for i in 0 to MAXIRQ-1 loop  				
							rds_data_s(16+i) <= mcause(3+i);		-- IRQ3,4,5,6 mapped to bits 16,17,..
						end loop;
						
				 -- when MIP_ADDR_C =>								-- Machine Interrupt Pending Register
				 	 -- rds_data_s <= mip;	
					when MSTATUS_ADDR_C => 							-- Required for test
						rds_data_s(3) <= mstatus(0);				-- MIE 
						rds_data_s(7) <= mstatus(1);				-- MPIE
					-- pragma synthesis_off
					when MHARTID_ADDR_C => 
						rds_data_s <= mhartid;
					-- pragma synthesis_on
					when MEPC_ADDR_C =>								-- TODO map CSR registers to X33..X34..X35 etc as we have the spare capacity
						rds_data_s <= mepc;							-- Read mepc reg
					when others => 
						if HW_CNT_G then
							case csr is
								when CYCLE_CNT_C|MCYCLE_CNT_C|TIME_CNT_C => 	-- Note time counter is same as cycle counter
									rds_data_s <= signed(cycle(31 downto 0));   -- UnPrivileged/Machine	
								when INSTRET_CNT_C|MINSTRET_CNT_C =>
									rds_data_s <= signed(instret(31 downto 0));	-- UnPrivileged/Machine	

								when CYCLEH_CNT_C|MCYCLEH_CNT_C|TIMEH_CNT_C	=> 	-- Note time counter is same as cycle counter
									rds_data_s <= signed(cycle(63 downto 32)); 	-- UnPrivileged/Machine	
								when INSTRETH_CNT_C|MINSTRETH_CNT_C => 
									rds_data_s <= signed(instret(63 downto 32));-- UnPrivileged/Machine	

								when MTIMECMP_CNT_C =>							-- Using hpmcounter3 as mtimecmp register!
									rds_data_s <= signed(mtimecmp(31 downto 0));
								when MTIMECMPH_CNT_C =>							-- Using hpmcounter3h as mtimecmph register!
									rds_data_s <= signed(mtimecmp(63 downto 32));								
								
								when others => 
									assert FALSE report "Unsupported CSRRS operation" severity error;
							end case;
						else
							assert FALSE report "Unsupported CSRRS operation" severity error;
						end if;
					end case;
			
			-- NOP (some test requires these, NOP behavior seems OK)
			when OP_CSRRC  =>										
				assert FALSE report "Unsupported CSRRC operation"  severity error;
			when OP_CSRRWI =>
				assert FALSE report "Unsupported CSRRWI operation" severity error;
			when OP_CSRRSI =>
				assert FALSE report "Unsupported CSRRSI operation" severity error;
			when OP_CSRRCI =>		
				assert FALSE report "Unsupported CSRRCI operation" severity error;
		
			when OP_MRET   => 
				memaddr_s <= mepc; 
				mstatus_s(0) <= mstatus(1);							-- MIE  <= MPIE
				jump_s <= '1';	
						
			when OP_FENCE  =>										-- NOP
			when OP_FENCEI =>										-- NOP
			when OP_uNOP   =>

				
			when OP_WFI =>
				if mstatus(0)='1' AND (OR mie)='1' then -- only if any IRQ is enable do we allow wfi
					wfi_s <= '1';									-- Enable Halt
				end if;
			
			when OP_ECALL  => 
				mcause_s <= CAUSE_MACHINE_ECALL_C; 			
				exception_s <= true;
				
			when OP_EBREAK => 
				mcause_s <= CAUSE_BREAKPOINT_C;					
				exception_s <= true;
				
			when others    => 										-- Exception handler
				mcause_s <= CAUSE_ILLEGAL_INST_C;			
				exception_s <= true;				
				
		end case;
		
		-------------------------------------------------------------------------------------------
		-- Overwrite address if exception/irq is requested
		-------------------------------------------------------------------------------------------
		if exception_s then 
			memaddr_s   <= mtvec; 									-- mtvec contains exception handler start address
			mepc_s      <= deco.pc;									-- Store address that caused the exception
			jump_s      <= '1';										-- Jump to handler
		elsif irq_req then
			memaddr_s   <= mtvec; 									-- mtvec contains exception handler start address
			mepc_s      <= deco.pc;									-- Store address that caused the exception
			jump_s      <= '1';										-- Jump to handler		
			
			mcause_s    <= "1000"&irq_mcause;						-- MSB indicated IRQ based exception
			mstatus_s(0)<= '0';										-- MIE  <= '0' 
			mstatus_s(1)<= mstatus(0);								-- MPIE <= MIE		
		end if;			
					
	end process;
	
	-----------------------------------------------------------------------------------------------
	-- Using latched rds.opcode
	-----------------------------------------------------------------------------------------------
	process(all)
		function sext(datain:unsigned(31 downto 0); msb:integer; lsb:integer) return std_logic_vector is
			constant one_vector_c : unsigned(23 downto 0):=X"FFFFFF";
			constant zero_vector_c: unsigned(23 downto 0):=X"000000";
			variable retval_v     : unsigned(31 downto 0);
		begin
			if datain(msb)='1' then 
				retval_v := one_vector_c(31-(msb-lsb+1) downto 0)&datain(msb downto lsb); 
			else 
			    retval_v := zero_vector_c(31-(msb-lsb+1) downto 0)&datain(msb downto lsb); 
			end if;
			return std_logic_vector(retval_v);
		end sext;	
	begin
	
		case rds.opcode is
			when OP_LB =>  
				case rds.memaddr(1 downto 0) is
					when "00"   => load_data_s <= sext(proci.memdata_s,7,0);  
					when "01"   => load_data_s <= sext(proci.memdata_s,15,8); 
					when "10"   => load_data_s <= sext(proci.memdata_s,23,16);
					when others => load_data_s <= sext(proci.memdata_s,31,24);
				end case;
				
			when OP_LH =>    
				if rds.memaddr(1) then
					load_data_s <= sext(proci.memdata_s,31,16); 
				else
					load_data_s <= sext(proci.memdata_s,15,0);  
				end if;
			
			when OP_LW => 
				load_data_s <= std_logic_vector(proci.memdata_s);
				
			when OP_LBU =>
				case rds.memaddr(1 downto 0) is
					when "00"   => load_data_s <= std_logic_vector(X"000000"&proci.memdata_s(7  downto 0)); 
					when "01"   => load_data_s <= std_logic_vector(X"000000"&proci.memdata_s(15 downto 8)); 
					when "10"   => load_data_s <= std_logic_vector(X"000000"&proci.memdata_s(23 downto 16));
					when others => load_data_s <= std_logic_vector(X"000000"&proci.memdata_s(31 downto 24));
				end case;
				
			when OP_LHU =>
				if rds.memaddr(1) then
					load_data_s <= std_logic_vector(X"0000"&proci.memdata_s(31 downto 16)); 
				else
					load_data_s <= std_logic_vector(X"0000"&proci.memdata_s(15 downto 0)); 
				end if;
				
			when OP_DIV | OP_DIVU => 
				if HW_MD_G then
					load_data_s <= std_logic_vector(quotient); 
				else
					load_data_s <= (others => '-');
				end if;
			when OP_REM | OP_REMU => 
				if HW_MD_G then
					load_data_s <= std_logic_vector(remainder);
				else
					load_data_s <= (others => '-');
				end if;						
				
			when others => 	
				load_data_s <= (others => '-');
				
		end case;			
	end process;
	
	
	-----------------------------------------------------------------------------------------------
    -- Processing opcodes
	-----------------------------------------------------------------------------------------------
    process(clk)
	begin		
		if rising_edge(clk) then
			if sreset='1' then

				rds.selo      <= (others => '0');
				rds.data  	  <= (others => '0');			
				rds.opcode    <= OP_uNOP;
				
				rds.pc        <= (others => '0');					-- debug only
				rds.insn      <= (others => '0');	 				-- debug only
						
				rds.wr        <= '0';			
						
				mepc          <= (others => '0');
				mtvec         <= (others => '0');
				mcause        <= (others => '0');
				mie			  <= (others => '0');
				mstatus       <= (others => '0');
				
				cycle 		  <= (others => '0');					-- Only used if HW_CNT_G is true
			 -- timecnt 	  <= (others => '0');
				mtimecmp 	  <= (others => '1');  					-- Max value otherwise we get an irq immediately after reset 
				instret       <= (others => '0');
				
				proco.jump    <= '0';		
				proco.memaddr <= (others => '0');
				proco.be      <= (others => '1');
				proco.store   <= '0';
				proco.load    <= '0';
				proco.memaddr <= (others => '0');	
				proco.be      <= (others => '0');					-- Byte Select
				
				stall         <= '0';
				
				current_procstate <= sProcIdle;	
				
			else 
									
				stall       <= '0';
							
				
				if HW_CNT_G then
					cycle    <= cycle + 1; 							-- number of clock cycles executed	
					mtimecmp <= mtimecmp_s;					
				end if;	
				
				case current_procstate is
				
					when sProcIdle => 		
						rds.opcode    <= deco.opcode;	
						rds.selo      <= std_logic_vector(rds_selo_s);	-- To Register File	
					  	rds.pc        <= deco.pc;					-- debug only
						rds.insn      <= deco.insn;	 				-- debug only
				
						rds.data   	  <= rds_data_s;
						rds.wr        <= rds_wr_s OR (proci.lsack AND deco.load);
				
						proco.memaddr <= unsigned(memaddr_s);	
						rds.memaddr   <= unsigned(memaddr_s);		-- TODO do we need 2 of these, proco also has it
						proco.be      <= be_s;						-- Byte Select
						proco.memdata <= unsigned(memdata_s); 							
						proco.jump 	  <= jump_s;					-- To Bus Controller
						
						proco.store   <= store_s;  -- change this to deco.store??? combinatorial??
						proco.load    <= load_s;

						mepc          <= mepc_s;
						mtvec         <= mtvec_s;	
						mcause        <= mcause_s;					-- 6 bits
						mie           <= mie_s;						
						mstatus 	  <= mstatus_s;					-- 2 bits				
						
						if HW_CNT_G then
							if deco.opcode/=OP_uNOP then
								instret <= instret + 1;
							end if;
						end if;							


						if jump_s='1' then
							current_procstate <= sProcJump;
						elsif load_s='1' then
							stall <= '1';
							current_procstate <= sProcLoad;
						elsif store_s='1' then
							stall <= '1';
							current_procstate <= sProcStore;
						elsif deco.divrem='1' AND HW_MD_G then
							stall <= '1';
							current_procstate <= sProcDiv;
						elsif wfi_s='1' then
							stall <= '1';
							current_procstate <= sProcHalt;
						end if;
						
					when sProcHalt =>
						stall <= '1';
						if irq_req then
							current_procstate <= sProcIdle;	
							stall <= '0';
						end if;					
					
					when sProcJump =>								-- Add 1 uNOP cycle after jump
						--pragma synthesis_off
						rds.opcode <= OP_uNOP;						-- just for debugging?			
						rds.wr     <= '0';
						--pragma synthesis_on		
						proco.jump <= '0';
						current_procstate <= sProcIdle;	
						
					when sProcLoad =>	-- TODO combine later
						stall    <= '1';
						rds.wr   <= '1';
						proco.load <= '0';
						rds.data <= signed(load_data_s);
						if proci.lsack='1' then						
							stall <= '0';
							current_procstate <= sProcIdle;							
						end if;
						
					when sProcStore =>
						stall <= '1';
						rds.wr      <= '0';
						proco.store <= '0';
						if proci.lsack='1' then
							stall <= '0';
							current_procstate <= sProcIdle;							
						end if;
					
					when sProcDiv =>
						stall <= '1';
						rds.data <= signed(load_data_s);
						if divdone='1' then	
							rds.wr <= '1';						
							stall  <= '0';
							current_procstate <= sProcIdle;							
						end if;			
						
					when others => NULL;-- TODO remove 
					   
				end case;
			
				
			end if; 												-- sreset
		end if;
	end process;	


end architecture rtl;

