-- ********************************************************************************
-- *                          Melogy_Generator                                	  *
-- *                         Component : Memory                                   *
-- *                                                                              *
-- * Ins : Adress_Note, on 10 bits, CLK                                           *
-- * Outs : Vectors for the Note, Octave and Duration of the note                 *
-- * Use : Receive an adress from the ADDRESS_COUNTER, gives the corresponding    *
-- *       Note, Octave and Duration.                                             *
-- * comments : - Sends the Note and Octave to the Decoder, the Duration to the   *
-- *              MUX_4v1                                                         *
-- ********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity MEMORY is 
	port(	CLK : in std_logic;                           			--For the ROM containing the partition
			Address_Note : in std_logic_vector (9 downto 0);    	--Coming from the ADDRESS_COUNTER, ranging from 0 to 1023 in binary
			Note: out std_logic_vector (3 downto 0);                --Which of the 12 possible note.
			Octave, Duration : out std_logic_vector (1 downto 0));  --Which of the 4 possible octaves, and which duration. Note and Octave go to the wave generator, Duration go to a Frequency Divider.
end entity;

Architecture BEHAVIOUR of MEMORY is 

  signal Temp_sig : std_logic_vector (7 downto 0); 						--Signal to carry the whole note information
  begin
        C0 : entity work.ROM port map (Address_Note, Temp_sig); 	--Read the correct adress from a ROM created with a .mif on Quartus, put the data on Temp_Sig
        Note <= Temp_Sig (7 downto 4);								 	--Separate the data,  XXXX   XX   XX
        Octave <= Temp_Sig (3 downto 2);                   				--Note  Oct.  Dur.
        Duration <= Temp_Sig (1 downto 0);
		
end architecture; 