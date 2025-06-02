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
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

ENTITY biu IS
   GENERIC( 
      FIFO_AWIDTH : integer := 2;
      HW_RVC_G    : boolean := TRUE
   );
   PORT( 
      busreq     : IN     std_logic;
      clk        : IN     std_logic;
      dbusi      : IN     std_logic_vector (31 DOWNTO 0);
      fifo_rd    : IN     std_logic;
      proco      : IN     iproc_out_type;
      sreset     : IN     std_logic;
      abus       : OUT    std_logic_vector (31 DOWNTO 0);
      ads        : OUT    std_logic;
      be         : OUT    std_logic_vector (3 DOWNTO 0);
      busack     : OUT    std_logic;
      dbuso      : OUT    std_logic_vector (31 DOWNTO 0);
      fifo_empty : OUT    boolean;
      fifo_in    : OUT    std_logic_vector (63 DOWNTO 0);
      fifo_out   : OUT    std_logic_vector (63 DOWNTO 0);
      fifo_wr    : OUT    std_logic;
      nextempty  : OUT    boolean;
      proci      : OUT    iproc_in_type;
      rd         : OUT    std_logic;
      wr         : OUT    std_logic
   );

-- Declarations

END biu ;

ARCHITECTURE struct2 OF biu IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL fifo_clr  : std_logic;
   SIGNAL fifo_full : boolean;

   -- Implicit buffer signal declarations
   SIGNAL fifo_in_internal : std_logic_vector (63 DOWNTO 0);
   SIGNAL fifo_wr_internal : std_logic;


   -- Component Declarations
   COMPONENT biu_ctrl
   GENERIC (
      HW_RVC_G : boolean := true
   );
   PORT (
      busreq    : IN     std_logic;
      clk       : IN     std_logic;
      dbusi     : IN     std_logic_vector (31 DOWNTO 0);
      fifo_full : IN     boolean;
      proco     : IN     iproc_out_type;
      sreset    : IN     std_logic;
      abus      : OUT    std_logic_vector (31 DOWNTO 0);
      ads       : OUT    std_logic;
      be        : OUT    std_logic_vector (3 DOWNTO 0);
      busack    : OUT    std_logic;
      dbuso     : OUT    std_logic_vector (31 DOWNTO 0);
      fifo_clr  : OUT    std_logic;
      fifo_in   : OUT    std_logic_vector (63 DOWNTO 0);
      fifo_wr   : OUT    std_logic;
      proci     : OUT    iproc_in_type;
      rd        : OUT    std_logic;
      wr        : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT syncfifo
   GENERIC (
      DATA_WIDTH : integer := 32;
      ADDR_WIDTH : integer := 2;
      RW_PROTECT : boolean := true
   );
   PORT (
      clear     : IN     std_logic;
      clk       : IN     std_logic;
      datain    : IN     std_logic_vector (DATA_WIDTH-1 DOWNTO 0);
      rd        : IN     std_logic;
      sreset    : IN     std_logic;
      wr        : IN     std_logic;
      dataout   : OUT    std_logic_vector (DATA_WIDTH-1 DOWNTO 0);
      empty     : OUT    boolean;
      full      : OUT    boolean;
      nextempty : OUT    boolean;
      nextfull  : OUT    boolean;
      wcounter  : OUT    std_logic_vector (ADDR_WIDTH-1 DOWNTO 0)
   );
   END COMPONENT;


BEGIN

   -- Instance port mappings.
   U_CTRL : biu_ctrl
      GENERIC MAP (
         HW_RVC_G => HW_RVC_G
      )
      PORT MAP (
         busreq    => busreq,
         clk       => clk,
         dbusi     => dbusi,
         fifo_full => fifo_full,
         proco     => proco,
         sreset    => sreset,
         abus      => abus,
         ads       => ads,
         be        => be,
         busack    => busack,
         dbuso     => dbuso,
         fifo_clr  => fifo_clr,
         fifo_in   => fifo_in_internal,
         fifo_wr   => fifo_wr_internal,
         rd        => rd,
         wr        => wr,
         proci     => proci
      );
   U_FIFO : syncfifo
      GENERIC MAP (
         DATA_WIDTH => 64,
         ADDR_WIDTH => FIFO_AWIDTH,
         RW_PROTECT => true
      )
      PORT MAP (
         clk       => clk,
         sreset    => sreset,
         datain    => fifo_in_internal,
         dataout   => fifo_out,
         wr        => fifo_wr_internal,
         rd        => fifo_rd,
         clear     => fifo_clr,
         full      => fifo_full,
         nextempty => nextempty,
         nextfull  => OPEN,
         empty     => fifo_empty,
         wcounter  => OPEN
      );

   -- Implicit buffered output assignments
   fifo_in <= fifo_in_internal;
   fifo_wr <= fifo_wr_internal;

END struct2;
