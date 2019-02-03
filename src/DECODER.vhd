-- ********************************************************************************
-- *                           Melody_Generator                                   *
-- *                         Component : DECODER                                  *
-- *                                                                              *
-- * Ins : Note on 4bits and its octave on 2bits                                  *
-- * Outs : Value of the count necessary to have half the period necessary to     *
-- *        create the note, on 18bits                                            *
-- * Use : Gives the value that the counter in the Wave_Generator needs to attain *
-- *       to toggle its Out signal, creating a square signal at the correct      *
-- *       frequency depending on the note and its octave.                        *
-- * comments : - The values are based on the Pythagorean frequencies, times 2 to *
-- *              get the octaves.                                                *
-- ********************************************************************************


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DECODER is 
	port(	Note_Height : in std_logic_vector(3 downto 0);
			Octave : in std_logic_vector(1 downto 0);
			count_val : out std_logic_vector(17 downto 0));
end entity;

Architecture BEHAVIOUR of DECODER is

	begin
		process(Note_Height, Octave) 								--count_val is re-evaluated when the note has changed
		begin
			case Note_Height is 									--Simple, long mix of a case..when and ifs to enumarate all the possible cases
				When "0000" => 										--When the note is an A
					if (Octave = "00") then 						--if the A is at the first octave
						count_val <= B"01_0000_1010_0101_0110";		--68182, or 1.135ms for a Tornado card running at 60Mhz. This is the half-period of a 440Hz A note.
					elsif (Octave = "01") then
						count_val <= B"00_1000_0101_0010_1011"; 
					elsif (Octave = "10") then
						count_val <= B"00_0100_0010_1001_0101";
					else
						count_val <= B"00_0010_0001_0100_1010";
					end if;
				when "0001" =>
					if (Octave = "00") then
						count_val <= B"00_1111_1011_0111_1001";
					elsif (Octave = "01") then
						count_val <= B"00_0111_1101_1011_1100";
					elsif (Octave = "10") then
						count_val <= B"00_0011_1110_1101_1110";
					else
						count_val <= B"00_0001_1111_0110_1111";
					end if;
				when "0010" =>
					if (Octave = "00") then
						count_val <= B"00_1110_1101_0011_1000";
					elsif (Octave = "01") then
						count_val <= B"00_0111_0110_1001_1100";
					elsif (Octave = "10") then
						count_val <= B"00_0011_1011_0100_1110";
					else
						count_val <= B"00_0001_1101_1010_0111";
					end if;
				when "0011" =>	
					if (Octave = "00") then
						count_val <= B"01_1011_1111_0100_0111";
					elsif (Octave = "01") then
						count_val <= B"00_1101_1111_1010_0011";
					elsif (Octave = "10") then
						count_val <= B"00_0110_1111_1101_0001";
					else
						count_val <= B"00_0011_0111_1110_1000";
					end if; 
				when "0100" =>
					if (Octave = "00") then
						count_val <= B"01_1010_0111_0000_1111";
					elsif (Octave = "01") then
						count_val <= B"00_1101_0011_1000_0111";
					elsif (Octave = "10") then
						count_val <= B"00_0110_1001_1100_0011";
					else
						count_val <= B"00_0011_0100_1110_0001";
					end if;
				when "0101" =>
					if (Octave = "00") then
						count_val <= B"01_1000_1110_1001_1001";
					elsif (Octave = "01") then
						count_val <= B"00_1100_0111_0100_1100";
					elsif (Octave = "10") then
						count_val <= B"00_0110_0011_1010_0110";
					else
						count_val <= B"00_0011_0001_1101_0011";
					end if;
				when "0110" =>
					if (Octave = "00") then
						count_val <= B"01_0111_1000_1100_1111";
					elsif (Octave = "01") then
						count_val <= B"00_1011_1100_0110_0111";
					elsif (Octave = "10") then
						count_val <= B"00_0101_1110_0011_0011";
					else
						count_val <= B"00_0010_1111_0001_1001";
					end if; 
				when "0111" =>
					if (Octave = "00") then
						count_val <= B"01_0110_0011_0001_1101";
					elsif (Octave = "01") then
						count_val <= B"00_1011_0001_1000_1110";
					elsif (Octave = "10") then
						count_val <= B"00_0101_1000_1100_0111";
					else
						count_val <= B"00_0010_1100_0110_0011";
					end if; 
				when "1000" =>
					if (Octave = "00") then
						count_val <= B"01_0100_1111_1100_1000";
					elsif (Octave = "01") then
						count_val <= B"00_1010_0111_1110_0100";
					elsif (Octave = "10") then
						count_val <= B"00_0101_0011_1111_0010";
					else
						count_val <= B"00_0010_1001_1111_1001";
					end if;
				when "1001" =>
					if (Octave = "00") then
						count_val <= B"01_0011_1100_1011_1001";
					elsif (Octave = "01") then
						count_val <= B"00_1001_1110_0101_1100";
					elsif (Octave = "10") then
						count_val <= B"00_0100_1111_0010_1110";
					else
						count_val <= B"00_0010_0111_1001_0111";
					end if; 
				when "1010" =>
					if (Octave = "00") then
						count_val <= B"01_0010_1010_1111_0011";
					elsif (Octave = "01") then
						count_val <= B"00_1001_0101_0111_1001";
					elsif (Octave = "10") then
						count_val <= B"00_0100_1010_1011_1100";
					else
						count_val <= B"00_0010_0101_0101_1110";
					end if;
				when "1011" =>
					if (Octave = "00") then
						count_val <= B"01_0001_1010_0110_0010";
					elsif (Octave = "01") then
						count_val <= B"00_1000_1101_0011_0001";
					elsif (Octave = "10") then
						count_val <= B"00_0100_0110_1001_1000";
					else
						count_val <= B"00_0010_0011_0100_1100";
					end if;
				when others =>
					count_val <= B"11_1111_1111_1111_1111";
						
			end case;
	end process;
end architecture;
	
				

			

