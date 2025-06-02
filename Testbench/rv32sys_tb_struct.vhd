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
--	Testbench top level
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author         
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

LIBRARY std;
use std.env.all;
USE std.TEXTIO.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

LIBRARY modelsim_lib;
USE modelsim_lib.util.all;

LIBRARY RISCV;
USE RISCV.rv32pack.ALL;

ENTITY rv32sys_tb IS
   GENERIC( 
      RAM_AWIDTH : integer := 12;
      ROM_AWIDTH : integer := 12
   );
-- Declarations

END rv32sys_tb ;

ARCHITECTURE struct OF rv32sys_tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL PIO_IN  : std_logic_vector(3 DOWNTO 0);
   SIGNAL PIO_OUT : std_logic_vector(3 DOWNTO 0);
   SIGNAL RX0     : std_logic;
   SIGNAL RX1     : std_logic;
   SIGNAL TX0     : std_logic;
   SIGNAL TX1     : std_logic;
   SIGNAL busack  : std_logic;
   SIGNAL busreq  : std_logic;
   SIGNAL clk     : std_logic;
   SIGNAL clkuart : std_logic;
   SIGNAL resetn  : std_logic;
   SIGNAL sreset  : std_logic;


   -- Component Declarations
   COMPONENT rv32sys
   GENERIC (
      RAM_AWIDTH : integer := 12;
      ROM_AWIDTH : integer := 13;
      ENA_UART1  : boolean := FALSE
   );
   PORT (
      PIO_IN  : IN     std_logic_vector (3 DOWNTO 0);
      RX0     : IN     std_logic ;
      RX1     : IN     std_logic ;
      busreq  : IN     std_logic ;
      clk     : IN     std_logic ;
      sreset  : IN     std_logic ;
      PIO_OUT : OUT    std_logic_vector (3 DOWNTO 0);
      TX0     : OUT    std_logic ;
      TX1     : OUT    std_logic ;
      busack  : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT rv32sys_tester
   PORT (
      PIO_OUT : IN     std_logic_vector (3 DOWNTO 0);
      PIO_IN  : OUT    std_logic_vector (3 DOWNTO 0);
      RX0     : OUT    std_logic ;
      RX1     : OUT    std_logic ;
      busreq  : OUT    std_logic ;
      clk     : OUT    std_logic ;
      clkuart : OUT    std_logic ;
      resetn  : OUT    std_logic ;
      sreset  : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT uartmon
   GENERIC (
      CLK16UART : integer   := 2;      -- (CLK/(16*9600))
      MAXCHAR_C : integer   := 40;
      COMPORT_C : character := '0'
   );
   PORT (
      RX     : IN     std_logic;
      clk    : IN     std_logic;
      resetn : IN     std_logic
   );
   END COMPONENT;

BEGIN

   -- Instance port mappings.
   U_DUT : rv32sys
      GENERIC MAP (
         RAM_AWIDTH => 12,
         ROM_AWIDTH => 13,
         ENA_UART1  => FALSE
      )
      PORT MAP (
         PIO_IN  => PIO_IN,
         RX0     => RX0,
         RX1     => RX1,
         busreq  => busreq,
         clk     => clk,
         sreset  => sreset,
         PIO_OUT => PIO_OUT,
         TX0     => TX0,
         TX1     => TX1,
         busack  => busack
      );
   U_TEST : rv32sys_tester
      PORT MAP (
         PIO_OUT => PIO_OUT,
         PIO_IN  => PIO_IN,
         RX0     => RX0,
         RX1     => RX1,
         busreq  => busreq,
         clk     => clk,
         clkuart => clkuart,
         resetn  => resetn,
         sreset  => sreset
      );
   U_MON : uartmon
      GENERIC MAP (
         CLK16UART => 2,         -- (CLK/(16*9600))
         MAXCHAR_C => 40,
         COMPORT_C => '0'
      )
      PORT MAP (
         RX     => TX0,
         clk    => clkuart,
         resetn => resetn
      );

END struct;
