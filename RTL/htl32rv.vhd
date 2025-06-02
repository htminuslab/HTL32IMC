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
USE ieee.numeric_std.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

ENTITY htl32rv IS
   GENERIC( 
      HW_RVC_G : boolean := FALSE;						-- Enables Compressed Instructions
      HW_MD_G  : boolean := FALSE;						-- Enables multiply/divide opcodes
      HW_CNT_G : boolean := FALSE						-- Enables CSR counters
   );
   PORT( 
      busreq : IN     std_logic;
      clk    : IN     std_logic;
      dbusi  : IN     std_logic_vector (31 DOWNTO 0);
      irq    : IN     std_logic_vector (3 DOWNTO 0);
      sreset : IN     std_logic;
      abus   : OUT    std_logic_vector (31 DOWNTO 0);
      ads    : OUT    std_logic;
      be     : OUT    std_logic_vector (3 DOWNTO 0);
      busack : OUT    std_logic;
      dbuso  : OUT    std_logic_vector (31 DOWNTO 0);
      rd     : OUT    std_logic;
      wr     : OUT    std_logic
   );
END htl32rv ;


ARCHITECTURE struct OF htl32rv IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL dec_in     : std_logic_vector(63 DOWNTO 0);
   SIGNAL deco       : idec_type;
   SIGNAL divdone    : std_logic;
   SIGNAL dividend   : unsigned(31 DOWNTO 0);
   SIGNAL divisor    : unsigned(31 DOWNTO 0);
   SIGNAL divsigned  : boolean;
   SIGNAL divstart   : boolean;
   SIGNAL fifo_empty : boolean;
   SIGNAL fifo_rd    : std_logic;
   SIGNAL proci      : iproc_in_type;
   SIGNAL proco      : iproc_out_type;
   SIGNAL quotient   : unsigned(31 DOWNTO 0);
   SIGNAL rds        : rds_type;
   SIGNAL remainder  : unsigned(31 DOWNTO 0);
   SIGNAL rs1        : signed(31 DOWNTO 0);
   SIGNAL rs1_sel    : std_logic_vector(4 DOWNTO 0);
   SIGNAL rs2        : signed(31 DOWNTO 0);
   SIGNAL rs2_sel    : std_logic_vector(4 DOWNTO 0);
   SIGNAL stall      : std_logic;


   -- Component Declarations
   COMPONENT biu
   GENERIC (
      FIFO_AWIDTH : integer := 2;
      HW_RVC_G    : boolean := TRUE
   );
   PORT (
      busreq     : IN     std_logic ;
      clk        : IN     std_logic ;
      dbusi      : IN     std_logic_vector (31 DOWNTO 0);
      fifo_rd    : IN     std_logic ;
      proco      : IN     iproc_out_type ;
      sreset     : IN     std_logic ;
      abus       : OUT    std_logic_vector (31 DOWNTO 0);
      ads        : OUT    std_logic ;
      be         : OUT    std_logic_vector (3 DOWNTO 0);
      busack     : OUT    std_logic ;
      dbuso      : OUT    std_logic_vector (31 DOWNTO 0);
      fifo_empty : OUT    boolean ;
      fifo_in    : OUT    std_logic_vector (63 DOWNTO 0);
      fifo_out   : OUT    std_logic_vector (63 DOWNTO 0);
      fifo_wr    : OUT    std_logic ;
      nextempty  : OUT    boolean ;
      proci      : OUT    iproc_in_type ;
      rd         : OUT    std_logic ;
      wr         : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT rv32dec
   GENERIC (
      HW_RVC_G : boolean := false
   );
   PORT (
      clk        : IN     std_logic;
      deci       : IN     std_logic_vector (63 DOWNTO 0);
      fifo_empty : IN     boolean;
      proco      : IN     iproc_out_type;
      sreset     : IN     std_logic;
      stall      : IN     std_logic;
      deco       : OUT    idec_type;
      fifo_rd    : OUT    std_logic;
      rs1_sel    : OUT    std_logic_vector (4 DOWNTO 0);
      rs2_sel    : OUT    std_logic_vector (4 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT rv32proc
   GENERIC (
      HW_MD_G  : boolean := true;      -- Enable Mul/Div
      HW_CNT_G : boolean := false      -- Enable Counters
   );
   PORT (
      clk       : IN     std_logic ;
      rs1       : IN     signed (31 DOWNTO 0);
      rs2       : IN     signed (31 DOWNTO 0);
      sreset    : IN     std_logic ;
      rds       : OUT    rds_type ;
      proco     : OUT    iproc_out_type ;
      deco      : IN     idec_type ;
      stall     : OUT    std_logic ;
      proci     : IN     iproc_in_type ;
      dividend  : OUT    unsigned (31 DOWNTO 0);
      divisor   : OUT    unsigned (31 DOWNTO 0);
      divsigned : OUT    boolean ;
      divdone   : IN     std_logic ;
      divstart  : OUT    boolean ;
      remainder : IN     unsigned (31 DOWNTO 0);
      quotient  : IN     unsigned (31 DOWNTO 0);
      irq       : IN     std_logic_vector (3 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT rv32reg
   PORT (
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
   END COMPONENT;
   COMPONENT rv32sdiv
   PORT (
      clk       : IN     std_logic;
      dividend  : IN     unsigned (31 DOWNTO 0);
      divisor   : IN     unsigned (31 DOWNTO 0);
      divsigned : IN     boolean;
      sreset    : IN     std_logic;
      start     : IN     boolean;
      done      : OUT    std_logic;
      quotient  : OUT    unsigned (31 DOWNTO 0);
      remainder : OUT    unsigned (31 DOWNTO 0)
   );
   END COMPONENT;

BEGIN

   -- Instance port mappings.
   U_BIU : biu
      GENERIC MAP (
         FIFO_AWIDTH => 2,
         HW_RVC_G    => HW_RVC_G
      )
      PORT MAP (
         busreq     => busreq,
         clk        => clk,
         dbusi      => dbusi,
         fifo_rd    => fifo_rd,
         proco      => proco,
         sreset     => sreset,
         abus       => abus,
         ads        => ads,
         be         => be,
         busack     => busack,
         dbuso      => dbuso,
         fifo_empty => fifo_empty,
         fifo_in    => OPEN,
         fifo_out   => dec_in,
         fifo_wr    => OPEN,
         nextempty  => OPEN,
         proci      => proci,
         rd         => rd,
         wr         => wr
      );
   U_DEC : rv32dec
      GENERIC MAP (
         HW_RVC_G => HW_RVC_G
      )
      PORT MAP (
         clk        => clk,
         sreset     => sreset,
         deci       => dec_in,
         stall      => stall,
         fifo_empty => fifo_empty,
         proco      => proco,
         fifo_rd    => fifo_rd,
         deco       => deco,
         rs1_sel    => rs1_sel,
         rs2_sel    => rs2_sel
      );
   U_PROC : rv32proc
      GENERIC MAP (
         HW_MD_G  => HW_MD_G,         -- Enable Mul/Div
         HW_CNT_G => HW_CNT_G         -- Enable Counters
      )
      PORT MAP (
         clk       => clk,
         rs1       => rs1,
         rs2       => rs2,
         sreset    => sreset,
         rds       => rds,
         proco     => proco,
         deco      => deco,
         stall     => stall,
         proci     => proci,
         dividend  => dividend,
         divisor   => divisor,
         divsigned => divsigned,
         divdone   => divdone,
         divstart  => divstart,
         remainder => remainder,
         quotient  => quotient,
         irq       => irq
      );
   U_REG : rv32reg
      PORT MAP (
         clk     => clk,
         proci   => proci,
         rds     => rds,
         rs1_sel => rs1_sel,
         rs2_sel => rs2_sel,
         sreset  => sreset,
         stall   => stall,
         rs1     => rs1,
         rs2     => rs2
      );
   U_DIV : rv32sdiv
      PORT MAP (
         clk       => clk,
         sreset    => sreset,
         dividend  => dividend,
         divisor   => divisor,
         divsigned => divsigned,
         quotient  => quotient,
         remainder => remainder,
         start     => divstart,
         done      => divdone
      );

END struct;
