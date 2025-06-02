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
--	Top level CPU + memory + ROM + UART
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          	Revision    Author         
--  25/05/2025      1.1 		HABT, Checked with Questa Base 2025.1, uploaded to github
---------------------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY std;
USE std.textio.all;

LIBRARY RISCV;


ENTITY rv32sys IS
   GENERIC( 
      RAM_AWIDTH : integer := 12;
      ROM_AWIDTH : integer := 13;
      ENA_UART1  : boolean := FALSE
   );
   PORT( 
      PIO_IN  : IN     std_logic_vector (3 DOWNTO 0);
      RX0     : IN     std_logic;
      RX1     : IN     std_logic;
      busreq  : IN     std_logic;
      clk     : IN     std_logic;
      sreset  : IN     std_logic;
      PIO_OUT : OUT    std_logic_vector (3 DOWNTO 0);
      TX0     : OUT    std_logic;
      TX1     : OUT    std_logic;
      busack  : OUT    std_logic
   );

-- Declarations

END rv32sys ;


ARCHITECTURE struct OF rv32sys IS

   -- Architecture declarations
   signal cs_rom : std_logic;
   signal cs_ram : std_logic;
   signal cs_pio : std_logic;
   signal dbusimux : std_logic_vector(31 downto 0);

   -- Internal signal declarations
   SIGNAL abus        : std_logic_vector(31 DOWNTO 0);
   SIGNAL abus_ram    : std_logic_vector(RAM_AWIDTH-1 DOWNTO 0);
   SIGNAL abus_rom    : std_logic_vector(ROM_AWIDTH-1 DOWNTO 0);
   SIGNAL ads         : std_logic;
   SIGNAL be          : std_logic_vector(3 DOWNTO 0);
   SIGNAL cs_uart0    : std_logic;
   SIGNAL cs_uart1    : std_logic;
   SIGNAL dbusi_cpu   : std_logic_vector(31 DOWNTO 0);
   SIGNAL dbuso_cpu   : std_logic_vector(31 DOWNTO 0);
   SIGNAL dbuso_ram   : std_logic_vector(31 DOWNTO 0);
   SIGNAL dbuso_rom   : std_logic_vector(31 DOWNTO 0);
   SIGNAL dbuso_uart0 : std_logic_vector(7 DOWNTO 0);
   SIGNAL dbuso_uart1 : std_logic_vector(7 DOWNTO 0);
   SIGNAL en_rom      : std_logic;
   SIGNAL irq3        : std_logic;
   SIGNAL irq4        : std_logic;
   SIGNAL irq_cpu     : std_logic_vector(3 DOWNTO 0);
   SIGNAL rd          : std_logic;
   SIGNAL rd_ram      : std_logic;
   SIGNAL wr          : std_logic;
   SIGNAL wr_ram      : std_logic;


   -- Component Declarations
   COMPONENT bootloader
   PORT (
      abus : IN     std_logic_vector (12 DOWNTO 0);
      clk  : IN     std_logic;
      ena  : IN     std_logic;
      dbus : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT htl32rv
   GENERIC (
      HW_RVC_G : boolean := FALSE;
      HW_MD_G  : boolean := FALSE;
      HW_CNT_G : boolean := FALSE
   );
   PORT (
      busreq : IN     std_logic ;
      clk    : IN     std_logic ;
      dbusi  : IN     std_logic_vector (31 DOWNTO 0);
      irq    : IN     std_logic_vector (3 DOWNTO 0);
      sreset : IN     std_logic ;
      abus   : OUT    std_logic_vector (31 DOWNTO 0);
      ads    : OUT    std_logic ;
      be     : OUT    std_logic_vector (3 DOWNTO 0);
      busack : OUT    std_logic ;
      dbuso  : OUT    std_logic_vector (31 DOWNTO 0);
      rd     : OUT    std_logic ;
      wr     : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT sram32
   GENERIC (
      ADDR_WIDTH   : integer := 13;
      MEM_INIT     : boolean := false;
      RAM_FILENAME : string  := "init_sram.mem"
   );
   PORT (
      addr : IN     std_logic_vector (ADDR_WIDTH-1 DOWNTO 0);
      be   : IN     std_logic_vector (3 DOWNTO 0);
      clk  : IN     std_logic;
      din  : IN     std_logic_vector (31 DOWNTO 0);
      re   : IN     std_logic;
      we   : IN     std_logic;
      dout : OUT    std_logic_vector (31 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT uart
   GENERIC (
      CLK16UART : integer := 313
   );
   PORT (
      ABUS   : IN     std_logic_vector (1 DOWNTO 0);
      CLK    : IN     std_logic;
      CS     : IN     std_logic;
      DBUSI  : IN     std_logic_vector (7 DOWNTO 0);
      RX     : IN     std_logic;
      SRESET : IN     std_logic;
      WR     : IN     std_logic;
      DBUSO  : OUT    std_logic_vector (7 DOWNTO 0);
      IRQ    : OUT    std_logic;
      TX     : OUT    std_logic
   );
   END COMPONENT;

BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 eb1
   -- eb1 1                                        
   	-----------------------------------------------------------------------------------------------
   	-- Bootloader 0x40000000
   	-----------------------------------------------------------------------------------------------
   	cs_rom   <= '1' when abus(31 downto 30)="01" else '0';		
   	en_rom   <= '1';
   	abus_rom <= abus(ROM_AWIDTH+1 downto 2);
   	
   	
   	-----------------------------------------------------------------------------------------------
   	-- SRAM starts at 0x00000000
   	-----------------------------------------------------------------------------------------------                            
   	abus_ram <= abus(RAM_AWIDTH+1 downto 2);
   	cs_ram   <= '1' when abus(31 downto 30)="00" else '0';     				
   	wr_ram   <= wr AND cs_ram;
   	rd_ram   <= rd AND cs_ram;
   	
   		
   	-----------------------------------------------------------------------------------------------
   	-- databus input multiplexer, only 0 waitstates dbuso_ram is in front of this mux
   	-----------------------------------------------------------------------------------------------	   	
   	dbusi_cpu <= dbuso_rom when cs_rom='1' else
   				 dbuso_ram when cs_ram='1' else dbusimux;
   		
   	process(clk)
   		variable whyneeded_v: std_logic_vector(2 downto 0);
   	begin
   		if rising_edge(clk) then
   			whyneeded_v := cs_uart1&cs_uart0&cs_pio;--&cs_ram&cs_rom;
   			case whyneeded_v is
   				when "001"  => dbusimux <= "----------------------------"&PIO_IN;  -- 4bits PIO 
   				when "010"  => dbusimux <= "------------------------"&dbuso_uart0; -- UART0 io port	
   				when "100"  => dbusimux <= "------------------------"&dbuso_uart1; -- UART1 io port	
   				when others => dbusimux <= (others => '-');
   			end case;
   		end if;
   	end process;	
   
   
   	-----------------------------------------------------------------------------------------------
   	-- IO Memory Map 0x80000000 all 32bits r/w
   	--
   	-- ABUS(7:4) ABUS(3:2)		Function
   	-----------------------------------------------------------------------------------------------
   	--  0000			00			UART0 RXHOLD0_C 	0x80000000
   	--  0000			01			UART0 TXHOLD0_C 	0x80000004	
   	--  0000			10			UART0 IRQENA0_C 	0x80000008	
   	--  0000			11			UART0 STATUS0_C 	0x8000000C	
   	--	
   	--  0001			00			UART1 RXHOLD1_C 	0x80000010
   	--  0001			01			UART1 TXHOLD1_C 	0x80000014	
   	--  0001			10			UART1 IRQENA1_C 	0x80000018	
   	--  0001			11			UART1 STATUS1_C 	0x8000001C	
   	-----------------------------------------------------------------------------------------------
   	cs_uart0 <= '1' when abus(31)='1' AND abus(7 downto 4)="0000" else '0';
   	cs_uart1 <= '1' when abus(31)='1' AND abus(7 downto 4)="0001" else '0';
   	
   	
   	-----------------------------------------------------------------------------------------------
   	-- PIO Register 0x80000070 
   	-----------------------------------------------------------------------------------------------
   	cs_pio <= '1' when abus(31)='1' AND abus(7 downto 4)="0111" else '0'; 
   	process(clk)
   	begin		
   		if rising_edge(clk) then			
   			if sreset='1' then	
   				PIO_OUT <= "0111";									-- 0x07 all 3 LED's off
   			else
   				if cs_pio='1' AND wr='1' then	-- add be?				
   					PIO_OUT <= dbuso_cpu(3 downto 0);				-- LED's
   				end if;	
   			end if;			
   		end if;
   	end process;
   	
   		
   	-----------------------------------------------------------------------------------------------
   	-- 0 	Timer Interrupt
   	-- 1 	EBREAK/ECALL or Illegal Instruction
   	-- 2 	*** not implemented *** BUS Error Unaligned Memory Access
   	-- 3    UART0
   	-- 4    UART1
   	-----------------------------------------------------------------------------------------------
   	g2: IF ENA_UART1 GENERATE
   		irq_cpu <= "00"&irq4&irq3;	
   	else generate
   		irq_cpu <= "000"&irq3;	
   	end generate g2;


   -- Instance port mappings.
   U_ROM : bootloader
      PORT MAP (
         clk  => clk,
         abus => abus_rom,
         ena  => en_rom,
         dbus => dbuso_rom
      );
   U_CPU : htl32rv
      GENERIC MAP (
         HW_RVC_G => TRUE,
         HW_MD_G  => TRUE,
         HW_CNT_G => TRUE
      )
      PORT MAP (
         busreq => busreq,
         clk    => clk,
         dbusi  => dbusi_cpu,
         irq    => irq_cpu,
         sreset => sreset,
         abus   => abus,
         ads    => ads,
         be     => be,
         busack => busack,
         dbuso  => dbuso_cpu,
         rd     => rd,
         wr     => wr
      );
   U_RAM : sram32
      GENERIC MAP (
         ADDR_WIDTH   => RAM_AWIDTH,
         MEM_INIT     => false,
         RAM_FILENAME => "init_sram.mem"
      )
      PORT MAP (
         clk  => clk,
         we   => wr_ram,
         re   => rd_ram,
         be   => be,
         addr => abus_ram,
         din  => dbuso_cpu,
         dout => dbuso_ram
      );
   U_UART0 : uart
      GENERIC MAP (
         CLK16UART => 26
      )
      PORT MAP (
         CLK    => clk,
         SRESET => sreset,
         ABUS   => abus(3 downto 2),
         WR     => wr,
         CS     => cs_uart0,
         DBUSO  => dbuso_uart0,
         DBUSI  => dbuso_cpu(7 downto 0),
         IRQ    => irq3,
         TX     => TX0,
         RX     => RX0
      );

   g1: IF ENA_UART1 GENERATE
   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR U_UART1 : uart USE ENTITY RISCV.uart;
   -- pragma synthesis_on

   BEGIN
      U_UART1 : uart
         GENERIC MAP (
            CLK16UART => 26
         )
         PORT MAP (
            CLK    => clk,
            SRESET => sreset,
            ABUS   => abus(3 downto 2),
            WR     => wr,
            CS     => cs_uart1,
            DBUSO  => dbuso_uart1,
            DBUSI  => dbuso_cpu(7 downto 0),
            IRQ    => irq4,
            TX     => TX1,
            RX     => RX1
         );
   END;
   END GENERATE g1;

END struct;
