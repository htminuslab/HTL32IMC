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
--	Instruction Decoder, note enum type might increase synthesis results!
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author         
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

entity rv32dec is
	generic(HW_RVC_G : boolean := false);	  					    -- Support Compressed Instruction set
	port( 
		clk        : in  std_logic;
		sreset     : in  std_logic;
		deci       : in  std_logic_vector (63 downto 0);
		stall      : in  std_logic;
		fifo_empty : in  boolean;
		proco      : in  iproc_out_type;
		fifo_rd    : out std_logic;
		deco       : out idec_type;	
		--csr_sel    : out std_logic_vector(3 downto 0);				-- Currently only 16 CSR registers are used		
		rs1_sel    : out std_logic_vector(4 downto 0);
		rs2_sel    : out std_logic_vector(4 downto 0)
	);
	  

-- Declarations

END rv32dec ;

--
ARCHITECTURE rtl OF rv32dec IS

	signal opcode_s     : RV32_ENUM;
					    
	signal immlui_s     : std_logic_vector(31 downto 0);
	signal immjal_s     : std_logic_vector(31 downto 0);
	signal imm11_s      : std_logic_vector(31 downto 0);
	signal immbr_s      : std_logic_vector(31 downto 0);
	signal immst_s      : std_logic_vector(31 downto 0);
	constant immx_s     : std_logic_vector(31 downto 0):=(others => '-');
					    
	signal imm_s        : std_logic_vector(31 downto 0);
	signal rd_sel_s     : std_logic_vector(4 downto 0);
	signal rds_wr_s     : std_logic;
					    
	signal opcode_ld_s  : std_logic;
	signal opcode_st_s  : std_logic;
	signal opcode_div_s : std_logic;
	signal compressed_s : boolean;

	signal insn_s       : std_logic_vector(31 downto 0);
	signal pc_s         : std_logic_vector(31 downto 0);
	
BEGIN

	insn_s <= deci(63 downto 32);
	pc_s   <= deci(31 downto 0);
	
	fifo_rd <= '1' when stall='0' else '0';
	
	process(all)	
	begin
	
		immlui_s <= insn_s(31 downto 12)&X"000";					-- LUI/AUIPC		
		if insn_s(31)='1' then										-- SEXT
			immjal_s <= "111111111111" & insn_s(19 downto 12) & insn_s(20) & insn_s(30 downto 21) & '0';
			imm11_s <= X"FFFFF" & insn_s(31 downto 20);
			immbr_s <= X"FFFFF" & insn_s(7) & insn_s(30 downto 25) & insn_s(11 downto 8) & '0';
			immst_s <= X"FFFFF" & insn_s(31 downto 25) & insn_s(11 downto 7);
		else
			immjal_s <= "000000000000" & insn_s(19 downto 12) & insn_s(20) & insn_s(30 downto 21) & '0';
			imm11_s <= X"00000" & insn_s(31 downto 20);
			immbr_s <= X"00000" & insn_s(7) & insn_s(30 downto 25) & insn_s(11 downto 8) & '0';
			immst_s <= X"00000" & insn_s(31 downto 25) & insn_s(11 downto 7);
        end if;
								
		imm_s    <= immx_s;											-- default value all don't care		
		opcode_s <= OP_EXCEP;
		
		case? insn_s(31 downto 25)&insn_s(14 downto 12)&insn_s(6 downto 0) is
			when "----------0110111" => imm_s <= immlui_s; opcode_s <= OP_LUI;
			when "----------0010111" => imm_s <= immlui_s; opcode_s <= OP_AUIPC;
			when "----------1101111" => imm_s <= immjal_s; opcode_s <= OP_JAL;
			when "-------0001100111" => imm_s <= imm11_s;  opcode_s <= OP_JALR;
			when "-------0001100011" => imm_s <= immbr_s;  opcode_s <= OP_BEQ;
			when "-------0011100011" => imm_s <= immbr_s;  opcode_s <= OP_BNE;
			when "-------1001100011" => imm_s <= immbr_s;  opcode_s <= OP_BLT;
			when "-------1011100011" => imm_s <= immbr_s;  opcode_s <= OP_BGE;
			when "-------1101100011" => imm_s <= immbr_s;  opcode_s <= OP_BLTU;
			when "-------1111100011" => imm_s <= immbr_s;  opcode_s <= OP_BGEU;
			when "-------0000000011" => imm_s <= imm11_s;  opcode_s <= OP_LB;
			when "-------0010000011" => imm_s <= imm11_s;  opcode_s <= OP_LH;
			when "-------0100000011" => imm_s <= imm11_s;  opcode_s <= OP_LW;
			when "-------1000000011" => imm_s <= imm11_s;  opcode_s <= OP_LBU;
			when "-------1010000011" => imm_s <= imm11_s;  opcode_s <= OP_LHU;
			when "-------0000100011" => imm_s <= immst_s;  opcode_s <= OP_SB;
			when "-------0010100011" => imm_s <= immst_s;  opcode_s <= OP_SH;
			when "-------0100100011" => imm_s <= immst_s;  opcode_s <= OP_SW;			
			when "-------0000010011" => imm_s <= imm11_s;  opcode_s <= OP_ADDI;
			when "-------0100010011" => imm_s <= imm11_s;  opcode_s <= OP_SLTI;
			when "-------0110010011" => imm_s <= imm11_s;  opcode_s <= OP_SLTIU;
			when "-------1000010011" => imm_s <= imm11_s;  opcode_s <= OP_XORI;
			when "-------1100010011" => imm_s <= imm11_s;  opcode_s <= OP_ORI;
			when "-------1110010011" => imm_s <= imm11_s;  opcode_s <= OP_ANDI;			
			when "-------0000001111" => imm_s <= X"00000"&insn_s(11 downto 0); opcode_s <= OP_FENCE;
			when "-------0010001111" => imm_s <= X"00000"&insn_s(11 downto 0); opcode_s <= OP_FENCEI;		
			                         			                         
			when "-------0011110011" => imm_s <= imm11_s;  opcode_s <= OP_CSRRW;-- Zicsr instructions added for regression testing only?
			when "-------0101110011" => imm_s <= imm11_s;  opcode_s <= OP_CSRRS;-- imm field contains CSR (only 11:0 are valid)
			when "-------0111110011" => imm_s <= imm11_s;  opcode_s <= OP_CSRRC;
			when "-------1011110011" => imm_s <= imm11_s;  opcode_s <= OP_CSRRWI;
			when "-------1101110011" => imm_s <= imm11_s;  opcode_s <= OP_CSRRSI;
			when "-------1111110011" => imm_s <= imm11_s;  opcode_s <= OP_CSRRCI;		
									 
			when "00000000010010011" => imm_s <= imm11_s;  opcode_s <= OP_SLLI;
			when "00000001010010011" => imm_s <= imm11_s;  opcode_s <= OP_SRLI;
			when "01000001010010011" => imm_s <= imm11_s;  opcode_s <= OP_SRAI;
			when "00000000000110011" =>                    opcode_s <= OP_ADD;  -- remaining imm_s=don't care???
			when "01000000000110011" =>                    opcode_s <= OP_SUB;
			when "00000000010110011" =>                    opcode_s <= OP_SLL;
			when "00000000100110011" =>                    opcode_s <= OP_SLT;
			when "00000000110110011" =>                    opcode_s <= OP_SLTU;
			when "00000001000110011" =>                    opcode_s <= OP_XOR;
			when "00000001010110011" =>                    opcode_s <= OP_SRL;
			when "01000001010110011" =>                    opcode_s <= OP_SRA;
			when "00000001100110011" =>                    opcode_s <= OP_OR;
			when "00000001110110011" =>                    opcode_s <= OP_AND;			
			when "00000010000110011" =>                    opcode_s <= OP_MUL;
			when "00000010010110011" =>                    opcode_s <= OP_MULH;
			when "00000010100110011" =>                    opcode_s <= OP_MULHSU;
			when "00000010110110011" =>                    opcode_s <= OP_MULHU;
			when "00000011000110011" =>                    opcode_s <= OP_DIV;
			when "00000011010110011" =>                    opcode_s <= OP_DIVU;
			when "00000011100110011" =>                    opcode_s <= OP_REM;
			when "00000011110110011" =>                    opcode_s <= OP_REMU;
			-- coverage off
			when others => NULL;-- can use vcom flag for coverage
			-- coverage on    
		end case?;
		
		case insn_s is
			when X"00000073"         => opcode_s <= OP_ECALL;
			when X"00100073"         => opcode_s <= OP_EBREAK;	
			--when X"00300073"         => opcode_s <= OP_IRQ;				
			when X"30200073"         => opcode_s <= OP_MRET; -- Zicsr
			when X"10500073"		 => opcode_s <= OP_WFI;
			-- coverage off
			when others => NULL;
			-- coverage on    
		end case;
		
		case? insn_s(6 downto 0) is								-- User Custom opcode, used for uNOP
			when "---1011" => opcode_s <= OP_uNOP;
			-- coverage off
			when others => NULL;
			-- coverage on    
		end case?;
								
		rd_sel_s  <= insn_s(11 downto 7);						-- Default values, compressed opcodes can changed them
		rs1_sel   <= insn_s(19 downto 15);						-- Note Comb output as regfile latches input
		rs2_sel   <= insn_s(24 downto 20);						-- Note Comb output as regfile latches input		
		
		-- -------------------------------------------------------------------------------------------
		-- -- Remap CSR register addresses to register 0 to 15
		-- -------------------------------------------------------------------------------------------
		-- case insn_s(31 downto 20) is
			-- when RISC_V_MSTATUS_ADDR_C  => csr_sel <= MSTATUS_ADDR_C; 	--  0x300 
			-- when RISC_V_MTVEC_ADDR_C    => csr_sel <= MTVEC_ADDR_C; 	--  0x305 
			-- when RISC_V_MEPC_ADDR_C     => csr_sel <= MEPC_ADDR_C; 		--  0x341 
			-- when RISC_V_MDEL_ADDR_C     => csr_sel <= MEPC_ADDR_C; 		--  0x302 used for MRET 
			-- when RISC_V_MCAUSE_ADDR_C   => csr_sel <= MCAUSE_ADDR_C; 	--  0x342 
			-- when RISC_V_MHARTID_ADDR_C  => csr_sel <= MHARTID_ADDR_C; 	--  0xF14 		 
			-- when RISC_V_MIE_ADDR_C      => csr_sel <= MIE_ADDR_C; 		--  0x304 Machine Interrupt Enable Register
			-- when RISC_V_MIP_ADDR_C      => csr_sel <= MIP_ADDR_C; 		--  0x344 Machine Interrupt Pending Register				 			
			-- when RISC_V_CYCLE_CNT_C     => csr_sel <= CYCLE_CNT_C; 		--  0xC00 UnPrivileged	
			-- when RISC_V_MCYCLE_CNT_C    => csr_sel <= MCYCLE_CNT_C; 	--  0xB00 Machine				
			-- when RISC_V_TIME_CNT_C      => csr_sel <= TIME_CNT_C; 		--  0xC01 UnPrivileged	
			-- when RISC_V_INSTRET_CNT_C   => csr_sel <= INSTRET_CNT_C; 	--  0xC02 UnPrivileged
			-- when RISC_V_MINSTRET_CNT_C  => csr_sel <= MINSTRET_CNT_C;  	--  0xB02 machine	
			-- when RISC_V_CYCLEH_CNT_C    => csr_sel <= CYCLEH_CNT_C; 	--  0xC80 UnPrivileged
			-- when RISC_V_MCYCLEH_CNT_C   => csr_sel <= MCYCLEH_CNT_C; 	--  0xB80 Machine				
			-- when RISC_V_TIMEH_CNT_C     => csr_sel <= TIMEH_CNT_C; 		--  0xC81 UnPrivileged				
			-- when RISC_V_INSTRETH_CNT_C  => csr_sel <= INSTRETH_CNT_C;  	--  0xC82 UnPrivileged
			-- when RISC_V_MINSTRETH_CNT_C => csr_sel <= MINSTRETH_CNT_C; 	--  0xB82 Machine
			-- when RISC_V_MTIMECMP_CNT_C  => csr_sel <= MTIMECMP_CNT_C; 	--  0x803 Using custom CSR as mtimecmp register!			
			-- when RISC_V_MTIMECMPH_CNT_C => csr_sel <= MTIMECMPH_CNT_C; 	--  0x883 Using custom CSR as mtimecmph register! 					 
			-- when others => csr_sel <= (others => '-');
		-- end case;
		
		
		compressed_s <= false;		
		if HW_RVC_G then
			case? insn_s(15 downto 0) is
				when "000-----------00" => compressed_s <= true;
					opcode_s <= OP_ADDI;  							-- C.ADDI4SPN addi rd′, x2, nzuimm[9:2].
					rs1_sel   <= "00010";							-- x2=sp							
					rd_sel_s  <= "01"&insn_s(4 downto 2);			-- rd'	
					imm_s(5 downto 4) <= insn_s(12 downto 11);
					imm_s(9 downto 6) <= insn_s(10 downto 7);
					imm_s(2) <= insn_s(6);
					imm_s(3) <= insn_s(5);
					imm_s(1 downto 0) <= "00";
					imm_s(31 downto 10) <= (others => '0');
					-- pragma synthesis_off
					if imm_s=X"00000000" then						-- Extra hardware unlikely to occur
						opcode_s <= OP_EXCEP; 
					end if;
					-- pragma synthesis_on
				
				when "010-----------00" => compressed_s <= true; 	-- C.LW expands to lw rd′, offset[6:2](rs1').
					opcode_s <= OP_LW;
					rs1_sel   <= "01"&insn_s(9 downto 7);		-- rs1'
					rd_sel_s  <= "01"&insn_s(4 downto 2);		-- rd'	
					imm_s(2) <= insn_s(6);						-- Offset
					imm_s(6) <= insn_s(5);
					imm_s(5 downto 3) <= insn_s(12 downto 10);
					imm_s(1 downto 0) <= "00";
					imm_s(31 downto 7) <= (others => '0');
									
				when "110-----------00" => compressed_s <= true; 	-- C.SW expands to  sw rs2',offset[6:2](rs1′)
					opcode_s <= OP_SW;
					rs1_sel <= "01"&insn_s(9 downto 7);			-- rs1'
					rs2_sel <= "01"&insn_s(4 downto 2);			-- rs2'
					imm_s(2) <= insn_s(6);						-- Offset
					imm_s(6) <= insn_s(5);
					imm_s(5 downto 3) <= insn_s(12 downto 10);
					imm_s(1 downto 0) <= "00";
					imm_s(31 downto 7) <= (others => '0');
					
	
				when "000-----------01" => compressed_s <= true; 	--  C.ADDI expands to addi rd, rd, nzimm[5:0]
					opcode_s <= OP_ADDI;
					rd_sel_s <= insn_s(11 downto 7);				-- rd	
					rs1_sel  <= insn_s(11 downto 7);				-- rs1
					imm_s(5) <= insn_s(12);
					imm_s(4 downto 0) <= insn_s(6 downto 2);				
					if imm_s(5)='1' then
						imm_s(31 downto 6) <= (others => '1');
					else
						imm_s(31 downto 6) <= (others => '0');
					end if;		
				
				when "001-----------01" => compressed_s <= true; 	-- C.JAL expands jal x1,offset[11:1]
					opcode_s  <= OP_JAL;
					rd_sel_s  <= "00001";							-- write to x1
					imm_s(11) <= insn_s(12);
					imm_s(4)  <= insn_s(11);
					imm_s(9 downto 8) <= insn_s(10 downto 9);
					imm_s(10) <= insn_s(8);
					imm_s(6)  <= insn_s(7);
					imm_s(7)  <= insn_s(6);
					imm_s(3 downto 1) <= insn_s(5 downto 3);
					imm_s(5) <= insn_s(2);
					if imm_s(11)='1' then
						imm_s(31 downto 12) <= (others => '1');
					else
						imm_s(31 downto 12) <= (others => '0');
					end if;
					imm_s(0) <= '0';
					
				when "010-----------01" => compressed_s <= true; 	-- C.LI expands to addi rd, x0, imm[5:0]
					opcode_s <= OP_ADDI;  							
					rd_sel_s  <= insn_s(11 downto 7);			-- rd	
					rs1_sel   <= "00000";							-- x0							
					imm_s(4 downto 0) <= insn_s(6 downto 2);
					imm_s(5) <= insn_s(12);
					if imm_s(5)='1' then
						imm_s(31 downto 6) <= (others => '1');
					else
						imm_s(31 downto 6) <= (others => '0');
					end if;
						
								
				when "011-----------01" => compressed_s <= true; 
					if insn_s(11 downto 7)="00010" then			-- rd=2, C.ADDI16SP expands to addi x2,x2,nzimm[9:4]
						opcode_s <= OP_ADDI;
						rd_sel_s  <= "00010";						-- rd=sp	
						rs1_sel   <= "00010";						-- rs1=sp						
						imm_s(9) <= insn_s(12);
						imm_s(4) <= insn_s(6);
						imm_s(6) <= insn_s(5);
						imm_s(8 downto 7) <= insn_s(4 downto 3);
						imm_s(5) <= insn_s(2);
						imm_s(3 downto 0)  <= "0000";
						if imm_s(9)='1' then
							imm_s(31 downto 10) <= (others => '1');
						else
							imm_s(31 downto 10) <= (others => '0');
						end if;					
						
					-- elsif insn_s(11 downto 7)="00010" then		-- rd=0
						-- opcode_s <= OP_EXCEP;
					else											-- C.LUI expands to lui rd, nzimm[17:12] , not fully decoded
						opcode_s <= OP_LUI;
						rd_sel_s  <= insn_s(11 downto 7);
						imm_s(17) <= insn_s(12);
						imm_s(16 downto 12) <= insn_s(6 downto 2);
						imm_s(11 downto 0)  <= (others => '0');
						--imm_s(31 downto 18) <= (others => '0');	
						if imm_s(17)='1' then
							imm_s(31 downto 18) <= (others => '1');
						else
							imm_s(31 downto 18) <= (others => '0');
						end if;	
						
					end if;
					
				when "100-00--------01" => compressed_s <= true; 	-- C.SRLI expands to srli rd',rd',shamt[5:0]
					opcode_s <= OP_SRLI;
					rd_sel_s  <= "01"&insn_s(9 downto 7);		-- rd'	
					rs1_sel   <= "01"&insn_s(9 downto 7);		-- rs1'
					imm_s(4 downto 0) <= insn_s(6 downto 2);
					imm_s(5) <= insn_s(12);
					imm_s(31 downto 6) <= (others => '0');	
					
				when "100-01--------01" => compressed_s <= true; 	-- C.SRAI expands to srli rd',rd',shamt[5:0]
					opcode_s <= OP_SRAI;
					rd_sel_s  <= "01"&insn_s(9 downto 7);		-- rd'	
					rs1_sel   <= "01"&insn_s(9 downto 7);		-- rs1'
					imm_s(4 downto 0) <= insn_s(6 downto 2);
					imm_s(5) <= insn_s(12);
					imm_s(31 downto 6) <= (others => '0');	
				
				when "100-10--------01" => compressed_s <= true; 	-- C.ANDI expands to andi rd',rd',imm[5:0]
					opcode_s <= OP_ANDI;
					rd_sel_s  <= "01"&insn_s(9 downto 7);		-- rd'	
					rs1_sel   <= "01"&insn_s(9 downto 7);		-- rs1'
					imm_s(4 downto 0) <= insn_s(6 downto 2);
					imm_s(5) <= insn_s(12);
					if imm_s(5)='1' then
						imm_s(31 downto 6) <= (others => '1');
					else
						imm_s(31 downto 6) <= (others => '0');
					end if;
				 
				when "100011---00---01" => compressed_s <= true; 
					opcode_s <= OP_SUB;  							-- C.SUB expands into and rd′, rd′, rs2′
					rd_sel_s  <= "01"&insn_s(9 downto 7);		
					rs1_sel   <= "01"&insn_s(9 downto 7);		
					rs2_sel   <= "01"&insn_s(4 downto 2);	
				when "100011---01---01" => compressed_s <= true; 
					opcode_s <= OP_XOR;  							-- C.XOR expands into and rd′, rd′, rs2′
					rd_sel_s  <= "01"&insn_s(9 downto 7);		
					rs1_sel   <= "01"&insn_s(9 downto 7);		
					rs2_sel   <= "01"&insn_s(4 downto 2);	
				when "100011---10---01" => compressed_s <= true; 
					opcode_s <= OP_OR;  							-- C.OR expands into and rd′, rd′, rs2′
					rd_sel_s  <= "01"&insn_s(9 downto 7);		
					rs1_sel   <= "01"&insn_s(9 downto 7);		
					rs2_sel   <= "01"&insn_s(4 downto 2);		
				
				when "100011---11---01" => compressed_s <= true; 
					opcode_s <= OP_AND;  							-- C.AND expands into and rd′, rd′, rs2′
					rd_sel_s  <= "01"&insn_s(9 downto 7);		
					rs1_sel   <= "01"&insn_s(9 downto 7);		
					rs2_sel   <= "01"&insn_s(4 downto 2);							
								
				when "101-----------01" => compressed_s <= true;    -- CC.J expands to JAL x0,offset[11:1]
					opcode_s  <= OP_JAL;
					rd_sel_s  <= "00000";							-- write to x0
					imm_s(11) <= insn_s(12);
					imm_s(4)  <= insn_s(11);
					imm_s(9 downto 8) <= insn_s(10 downto 9);
					imm_s(10) <= insn_s(8);
					imm_s(6)  <= insn_s(7);
					imm_s(7)  <= insn_s(6);
					imm_s(3 downto 1) <= insn_s(5 downto 3);
					imm_s(5) <= insn_s(2);
					if imm_s(11)='1' then
						imm_s(31 downto 12) <= (others => '1');
					else
						imm_s(31 downto 12) <= (others => '0');
					end if;
					imm_s(0) <= '0';
				
				when "110-----------01" => compressed_s <= true;  	-- C.BEQZ expands to beq rs1′, x0, offset[8:1]
					opcode_s <= OP_BEQ;
					rs1_sel   <= "01"&insn_s(9 downto 7);
					rs2_sel   <= "00000";
					imm_s(8)  <= insn_s(12);
					imm_s(4 downto 3)  <= insn_s(11 downto 10);
					imm_s(7 downto 6)  <= insn_s(6 downto 5);
					imm_s(2 downto 1)  <= insn_s(4 downto 3);
					imm_s(5)  <= insn_s(2);
					imm_s(0)  <= '0';
					if imm_s(8)='1' then
						imm_s(31 downto 9) <= (others => '1');
					else
						imm_s(31 downto 9) <= (others => '0');
					end if;

	
				when "111-----------01" => compressed_s <= true; 	-- C.BNEZ expands to bne rs1',x0,offset[8:1]	
					opcode_s <= OP_BNE;
					rs1_sel   <= "01"&insn_s(9 downto 7);
					rs2_sel   <= "00000";							-- X0
					imm_s(8)  <= insn_s(12);
					imm_s(4 downto 3)  <= insn_s(11 downto 10);
					imm_s(7 downto 6)  <= insn_s(6 downto 5);
					imm_s(2 downto 1)  <= insn_s(4 downto 3);
					imm_s(5)  <= insn_s(2);
					imm_s(0)  <= '0';
					if imm_s(8)='1' then
						imm_s(31 downto 9) <= (others => '1');
					else
						imm_s(31 downto 9) <= (others => '0');
					end if;
				
			    when "000-----------10" => compressed_s <= true; 	-- C.SLLI expands to  slli rd, rd, shamt[5:0]
					opcode_s <= OP_SLLI;
					rd_sel_s  <= insn_s(11 downto 7);			-- rd	
					rs1_sel   <= insn_s(11 downto 7);			-- rs1
					imm_s(4 downto 0) <= insn_s(6 downto 2);
					imm_s(5) <= insn_s(12);
					imm_s(31 downto 6) <= (others => '0');	
					
			    when "010-----------10" => compressed_s <= true; 	-- C.LWSP expands to lw rd,offset[7:2)(x2)
					opcode_s <= OP_LW;
					rd_sel_s  <= insn_s(11 downto 7);			-- rd	*** Not fully decoded, rd cannot be 0 ***
					rs1_sel   <= "00010";							-- x2=sp							
					imm_s(5)  <= insn_s(12);
					imm_s(4 downto 2)  <= insn_s(6 downto 4);
					imm_s(7 downto 6)  <= insn_s(3 downto 2);
					imm_s(1 downto 0)  <= "00";
					imm_s(31 downto 8) <= (others => '0');	
				
				when "1000----------10" => compressed_s <= true; 
					if insn_s(6 downto 2)="00000" then			-- rs2=0 C.JR expands to jalr x0,0(rs1) 
						opcode_s <= OP_JALR;
						rs1_sel  <= insn_s(11 downto 7);
						rs2_sel  <= insn_s(6 downto 2); 			-- equal to "00000";	
						rd_sel_s <= "00000";
						imm_s(31 downto 0) <= (others => '0');						
					else											-- C.MV expands to add rd,x0,rs2 *** Not fully decoded, rd cannot be 0 ***
						opcode_s <= OP_ADD;
						rd_sel_s <= insn_s(11 downto 7);			-- rd
						rs1_sel  <= "00000";								
						rs2_sel  <= insn_s(6 downto 2);
					end if;

				when "1001----------10" => compressed_s <= true; 
					if  insn_s(6 downto 2)="00000" then 			-- C.EBREAK OR C.JALR
						if insn_s(11 downto 7)="00000" then 		-- C.EBREAK
							opcode_s <= OP_EBREAK;
						else										-- C.JALR expands to jalr x1, 0(rs1)
							opcode_s <= OP_JALR;
							rs1_sel  <= insn_s(11 downto 7);
							rs2_sel  <= insn_s(6 downto 2);		-- equal to "00000"
							rd_sel_s <= "00001";	
							imm_s(31 downto 0) <= (others => '0');	
						end if;
					else											
						opcode_s <= OP_ADD;  						-- C.ADD  expands to add rd, rd, rs2.
						rd_sel_s <= insn_s(11 downto 7);		
						rs1_sel  <= insn_s(11 downto 7);		
						rs2_sel  <= insn_s(6 downto 2);			
					end if;

				when "110-----------10" => compressed_s <= true; 	-- C.SWSP expands to sw rs2,offset[7:2](x2)
					opcode_s <= OP_SW;
					rs1_sel  <= "00010";							-- x2=sp
					rs2_sel  <= insn_s(6 downto 2);	
					imm_s(5 downto 2)  <= insn_s(12 downto 9);
					imm_s(7 downto 6)  <= insn_s(8 downto 7);
					imm_s(1 downto 0)  <= "00";
					imm_s(31 downto 8) <= (others => '0');			-- Zero extended
					
				-- coverage off
				when others => NULL;
				-- coverage on    
				
			end case?;
		end if;						
				
		-- Determine RDs write stobe, if rdsel=0 then no write, also some opcodes do not write to rds
		if rd_sel_s="00000" OR opcode_s=OP_SB OR opcode_s=OP_SH OR opcode_s=OP_SW OR
		--if   opcode_s=OP_SB OR opcode_s=OP_SH OR opcode_s=OP_SW OR   -- rd_sel_s=0 done in reg module
			 opcode_s=OP_CSRRC  OR opcode_s=OP_CSRRWI OR -- opcode_s=OP_CSRRS  OR opcode_s=OP_CSRRW  OR
			 opcode_s=OP_CSRRSI OR --opcode_s=OP_CSRRCI OR
			 opcode_s=OP_BEQ  OR opcode_s=OP_BNE  OR opcode_s=OP_BLT OR opcode_s=OP_BGE OR 
			 opcode_s=OP_BLTU OR opcode_s=OP_BGEU OR opcode_s=OP_MRET OR
			 opcode_s=OP_LW OR opcode_s=OP_LH OR opcode_s=OP_LHU OR opcode_s=OP_LB OR opcode_s=OP_LBU OR
			 opcode_s=OP_uNOP
			 --write strobe so deleted here for easy display (single write) TODO could remove if affect Fmax
			then
			rds_wr_s <= '0';
		else
			rds_wr_s <= '1';
		end if;
		
		-- if (opcode_s=OP_JAL  OR opcode_s=OP_JALR OR opcode_s=OP_EXCEP OR opcode_s=OP_ECALL OR opcode_s=OP_EBREAK OR
			-- opcode_s=OP_BEQ  OR opcode_s=OP_BNE  OR opcode_s=OP_BLT   OR opcode_s=OP_BGE   OR opcode_s=OP_BLTU OR 
			-- opcode_s=OP_BGEU OR opcode_s=OP_MRET) then
			-- jmp_opc_s <= '1';
		-- else
			-- jmp_opc_s <= '0';
		-- end if;
				
		-- Load Opcode, read SRAM
		if (opcode_s=OP_LB OR opcode_s=OP_LH OR	opcode_s=OP_LW OR opcode_s=OP_LBU OR opcode_s=OP_LHU) then
			opcode_ld_s <= '1';
		else
			opcode_ld_s <= '0';
		end if;
		
		-- Store Opcodes, write SRAM
		if (opcode_s=OP_SB OR opcode_s=OP_SH OR	opcode_s=OP_SW) then
			opcode_st_s <= '1';
		else
			opcode_st_s <= '0';
		end if;
		
		-- Load Opcode, read SRAM
		-- add HW_DIV here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! generic
		-- as they should be illegal opcode if not implemented
		-- If rds_wr_s=0 then no need to run div/rem
		if (opcode_s=OP_DIV OR opcode_s=OP_DIVU OR opcode_s=OP_REM OR opcode_s=OP_REMU) AND rds_wr_s='1' then
			opcode_div_s <= '1';
		else
			opcode_div_s <= '0';
		end if;		
			
	end process;
	
	
    process(clk)
	begin
		if rising_edge(clk) then
			if sreset='1' then			
				deco.pc         <= (others => '0');
				deco.insn       <= (others => '0');					-- Debug only		
				deco.opcode     <= OP_uNOP;
				deco.compressed <= false;	
				deco.load       <= '0';								-- Load Instruction
				deco.store      <= '0';								-- Store Instruction			
				deco.divrem     <= '0';								-- Divider/Rem Instructions
				deco.imm        <= (others => '0');
				deco.rds_sel    <= (others => '0');
				deco.rs1_sel    <= (others => '0');		
				deco.rs2_sel    <= (others => '0');	
				--deco.csr_sel    <= (others => '0');					
				deco.rds_wr     <= '0';  	 					
			
			elsif stall='0' then
				if fifo_empty OR proco.jump='1' then
					deco.opcode     <= OP_uNOP;	
					deco.rds_wr     <= '0'; 			
					deco.divrem     <= '0';					
				else		
					deco.opcode     <= opcode_s;		
					deco.load       <= opcode_ld_s;
					deco.store      <= opcode_st_s;
					deco.divrem     <= opcode_div_s; 
					deco.compressed <= compressed_s;					-- "C" instructions
					deco.imm        <= signed(imm_s);
					deco.rds_sel    <= rd_sel_s;
					deco.rs1_sel    <= rs1_sel;   
					deco.rs2_sel    <= rs2_sel; 
					--deco.csr_sel    <= csr_sel;
					deco.pc         <= signed(pc_s);
					deco.insn       <= insn_s;
					deco.rds_wr     <= rds_wr_s;		
				end if;
				
			end if;
		end if;
	end process;
	

END ARCHITECTURE rtl;

