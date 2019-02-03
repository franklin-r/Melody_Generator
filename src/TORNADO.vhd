-- ********************************************************************************
-- *                          Melody_Generator                                	  *
-- *                         Component : TORNADO                                  *
-- *                                                                              *
-- * Ins : Signals corresponding to the Ins of a Tornado Card                     *
-- * Outs : Signals corresponding to the Ins of a Tornado Card                    *
-- * Use : ensures the integration of the IP on a Tornado card                    *
-- * comments : - Here, we only use the RST, SW2 and Clk as Ins, the Spkr or      *
-- *              AnRC for the headphone as Out                                   *
-- *            - To switch the "out" peripheral (on-card speaker or headphone),  *
-- *              change the last part of the port map line 139 (Spkr or AnRC(1)).*
-- *            - The rest of the code is not to be changed.                      *
-- ********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tornado is    -- note : lower case important (for Quartus II 4.2)
  port (   Clk           : in    std_logic;
           Reset_n       : in    std_logic;  -- SW4

           ADC_D         : in    std_logic_vector (7 downto 0);
           ADC_CLK       : out   std_logic;

           SW1           : in    std_logic; -- BP(0)
           SW2           : in    std_logic; -- BP(1)
           SW3           : in    std_logic; -- BP(2)

           DIGIN         : in    std_logic_vector (3 downto 0);
           DIPSW         : in    std_logic_vector (3 downto 0);
           OC_out        : out   std_logic_vector (7 downto 0);
           RCserv        : out   std_logic_vector (3 downto 0);

           Keypad        : in    std_logic_vector (2 downto 0);
           SevSeg        : out   std_logic_vector (0 to 7);     -- a .. g, dp
           Cdisp         : out   std_logic_vector (3 downto 0);

           Sp_Bus        : inout std_logic_vector (7 downto 0); -- Spare bus 8 bits

           LED4          : out   std_logic;

           RS232_RX0     : in    std_logic;
           RS232_RX1     : in    std_logic;
           RS232_TX0     : out   std_logic;
           RS232_TX1     : out   std_logic;

           USB_nRxF      : in    std_logic;
           USB_nTxE      : in    std_logic;
           USB_nRD       : out   std_logic;
           USB_WR        : out   std_logic;
           USB_D         : inout std_logic_vector (7 downto 0);

           FPGA_KClk     : inout std_logic;
           FPGA_KData    : inout std_logic;
           FPGA_MClk     : inout std_logic;
           FPGA_MData    : inout std_logic;

           FPGA_SPI_Dout : inout std_logic;
           FPGA_uW_SIO   : inout std_logic;
           FPGA_SPI_Clk  : out   std_logic;
           FPGA_uW_nCS   : out   std_logic;

           AnRC          : out   std_logic_vector (1 downto 0);
           Spkr          : out   std_logic;

           LCD_E         : out   std_logic;
           LCD_RS        : out   std_logic;

           SCard_IO      : inout std_logic;
           SCard_nPwr    : out   std_logic;
           SCard_Clk     : out   std_logic;
           SCard_Rst     : out   std_logic
           );
end entity;


architecture RTL of tornado is


  signal RST      : std_logic;
  signal Tick1us  : std_logic;
  signal Tick4us  : std_logic;
  signal Tick10us : std_logic;
  signal Tick1ms  : std_logic;
  signal Tick10ms : std_logic;
  signal UNITIES  : std_logic_vector(3 downto 0);
  signal TENS     : std_logic_vector(3 downto 0);
  signal HUNDREDS : std_logic_vector(3 downto 0);
  signal THOUSNDS : std_logic_vector(3 downto 0);
  signal Columns  : std_logic_vector(3 downto 0);
  signal Data     : std_logic_vector(3 downto 0);
  signal DispIdx  : unsigned        (1 downto 0);
  signal R1n      : std_logic;

	begin  

-- --------------------------------
--  USER logic comes here :
-- --------------------------------

-- processes, instanciations, continuous assignements

-- THOUSNDS <= x"E";
-- HUNDREDS <= x"F";
-- TENS     <= x"0";
-- UNITIES  <= DIPSW;

--SevSeg(7) <= '1';  -- DP off on all segments
--Pol <= '0';        -- 7 segment DISPLAY is active LOW
--

-- ==============================
-- Tornado Services, ready to use ---
-- ==============================
-- you do not need to modify anything below


-- --------------------------------
-- External Reset resynchronization
-- --------------------------------
process (CLK)
begin
  if rising_edge (CLK) then
    R1n <= Reset_n;
    RST <= not R1n;
  end if;
end process;

C0 : entity work.MELODY_GENERATOR port map (Clk, RST, SW2, Spkr); 
-- Instantiate the MusicGen on the Tornado
-- RST button for the Reset signal, SW2 for the Override signal, Spkr as the out signal making the sound


-- ---------------------------------
-- Frequency Divider instanciation
---- ---------------------------------
--i_FDIV : entity work.FDIV
--  generic map ( FCLOCK  => 60E6 )   -- 60 MHz
--  port map ( CLK      => CLK,
--             RST      => RST,
--             Tick1us  => Tick1us,
--             Tick4us  => Tick4us,
--             Tick10us => Tick10us,
--             Tick1ms  => Tick1ms,
--             Tick10ms => Tick10ms );

-- --------------------------
-- Multiplexed 7-seg DISPLAY
-- --------------------------
---- 7-seg decoder instanciation
--i_SEVEN_SEG : entity work.SEVEN_SEG
--	port map ( 	Data 	=> Data,
--					Pol 	=> Pol,
--					Segout	=> SevSeg(0 to 6));
--				
---- bcd counter instanciation
--i_bcd_counter: entity work.bcd_counter
--	port map (	CLK      => CLK,
--	            RST      => RST,
--	            TICK1MS  => Tick1ms,
--	            UNITIES  => UNITIES,
--	            TENS     => TENS,
--	            HUNDREDS => HUNDREDS,
--               THOUSNDS => THOUSNDS);
      
-- Time multiplexing (columns scanning)
--process (CLK, RST)
--  variable div2 : std_logic;
--begin
--  if RST = '1' then
--    Columns <= "1110"; -- active low
--    DispIdx <= "00";
--    div2    := '0';
--  elsif rising_edge (Clk) then
--    if Tick1ms='1' then
--      if div2='0' then
--        Columns <= Columns(2 downto 0) & Columns(3); -- shift left
--        DispIdx <= DispIdx + 1;
--      end if;
--      div2 := not div2;
--    end if;
--  end if;
--end process;
--
--process(DispIdx, UNITIES, TENS, HUNDREDS, THOUSNDS)
--begin
--  case to_integer(DispIdx) is
--    when 0 => Data <= UNITIES;
--    when 1 => Data <= TENS;
--    when 2 => Data <= HUNDREDS;
--    when 3 => Data <= THOUSNDS;
--    when others => Data <= (others=>'-');
--  end case;
--end process;

end architecture;
