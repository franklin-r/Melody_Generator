-- ********************************************************************************
-- *                           Melody_Generator                                   *
-- *                      Component : MELODY_GENERATOR                            *
-- *                                                                              *
-- * Ins : Clock, Reset and Override Signals                                      *
-- * Outs : SoundWave, clock at the correct frequency giving us the correct note  *
-- * Use : Instantiate every component of the system as one global component      *
-- * comments :                                                                   *
-- ********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MELODY_GENERATOR is 
	port(	CLK : in std_logic;
			RST : in std_logic;
			Override : in std_logic;
			SoundWave : out std_logic);
end entity;

architecture STRUCTURAL of MELODY_GENERATOR is

	Signal Address_Note : std_logic_vector(9 downto 0); 		--Every signals used in the different components
	Signal Octave : std_logic_vector(1 downto 0);
	Signal Note_Height : std_logic_vector(3 downto 0);
	Signal Duration : std_logic_vector(1 downto 0);
	Signal Tick_1000ms : std_logic;
	Signal Tick_500ms : std_logic;
	Signal Tick_250ms : std_logic;
	Signal Tick_125ms : std_logic;
	Signal Clear_Tick : std_logic;
	Signal Tick_Next_Note : std_logic;
	Signal Tick_Counter : std_logic_vector(17 downto 0);


	begin
		A0 : entity work.ADDRESS_COUNTER port map (	CLK => CLK,
													RST => RST,
													Tick_next_note => Tick_Next_Note,
													Address_Note =>Address_Note);
													
		A1 : entity work.MEMORY port map (	CLK => CLK,
											Address_Note => Address_Note,
											Note => Note_Height,
											Octave => Octave,
											Duration => Duration);
											
		A2 : entity work.DECODER port map (	Note_Height => Note_Height,
											Octave => Octave,
											count_val => Tick_Counter);
											
		A3 : entity work.WAVE_GENERATOR port map (	CLK => CLK,
													RST => RST,
													Tick_Counter => Tick_Counter,
													Override =>Override,
													SoundWave => SoundWave);
													
		A4 : entity work.FDIV port map (CLK => CLK,
										RST => RST,
										CLR => Clear_Tick, 
										Tick_1000ms => Tick_1000ms,
										Tick_500ms => Tick_500ms,
										Tick_250ms => Tick_250ms,
										Tick_125ms => Tick_125ms);
										
		A5 : entity work.MUX_4v1_1BIT port map (Tick_1000ms => Tick_1000ms,
												Tick_500ms => Tick_500ms,
												Tick_250ms => Tick_250ms,
												Tick_125ms => Tick_125ms,
												CLK => CLK,
												Duration => Duration,
												Tick_Next_Note => Tick_Next_Note,
												CLR => Clear_Tick);
  
end architecture;
