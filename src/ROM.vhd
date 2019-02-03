-- ********************************************************************************
-- *                         Melody_Generator                                     *
-- *                         Component : ROM                                      *
-- *                                                                              *
-- * Ins : The note adress on 10 bits (from 0 to 1023), clk                       *
-- * Outs : The corresponding coded note, on 8 bits                               *
-- * Use : Read-Only-Memory, gives the data corresponding to the given adress     *
-- * comments : - The note format is as follow: XXXX   XX      XX                 *
-- *                                             Note Octave Duration             *
-- *            - See the documentation for the note-coding details               *
-- *            - The given melody is the intro riff of Plug in Baby by Muse      *
-- *              (2001, written by M. Bellamy)                                   *
-- ********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ROM is
	port(	address : in std_logic_vector (9 downto 0);	 	--Address fron 0 to 1023, in binary
			Q : out std_logic_vector (7 downto 0) 			--Coded note corresponding to the adress
	);
end entity;


architecture BEHAVIOUR of ROM is

	type mem is array (0 to 1023) of std_logic_vector(7 downto 0); 	--Array of 1024 8 bits vectors
	constant my_rom : mem := (										--Contains the notes
		0 => "00010110",
		1 => "00100110",
		2 => "01000110",
		3 => "00010110",
		4 => "00100110",
		5 => "01000110",
		6 => "01010110",
		7 => "00100110",
		8 => "01000110",
		9 => "01010110",
		10 => "01110110",
		11 => "10000101",
		12 => "10010101",
		13 => "10000110",
		14 => "01110110",
		15 => "01010110",
		16 => "01000110",
		17 => "00100110",
		18 => "01000110",
		19 => "01010110",
		20 => "00100110",
		21 => "01000110",
		22 => "01010110",
		23 => "01110110",
		24 => "01000110",
		25 => "01010110",
		26 => "01110110",
		27 => "10010110",
		28 => "10010101",
		29 => "10100101",
		30 => "10000110",
		31 => "10010110",
		32 => "10000110",
		33 => "10010110",
		34 => "01010110",
		35 => "00000110",
		36 => "10010010",
		37 => "00000110",
		38 => "01010110",
		39 => "10010110",
		40 => "10110101",
		41 => "00001000",
		42 => "10110100",
		43 => "10010110",
		44 => "10000110",
		45 => "10010110",
		46 => "01010110",
		47 => "01000110",
		48 => "01010110",
		49 => "00010110",
		50 => "00100110",
		51 => "01000110",
		52 => "00010110",
		53 => "00100110",
		54 => "01000110",
		55 => "01010110",
		56 => "00100110",
		57 => "01000110",
		58 => "01010110",
		59 => "01110110",
		60 => "10000101",
		61 => "10010101",
		62 => "10000110",
		63 => "01110110",
		64 => "01010110",
		65 => "01000110",
		66 => "00100110",
		67 => "01000110",
		68 => "01010110",
		69 => "00100110",
		70 => "01000110",
		71 => "01010110",
		72 => "01110110",
		73 => "01000110",
		74 => "01010110",
		75 => "01110110",
		76 => "10010110",
		77 => "10010101",
		78 => "10100101",
		79 => "10000110",
		80 => "10010110",
		81 => "10000110",
		82 => "10010110",
		83 => "01010110",
		84 => "00000110",
		85 => "10010010",
		86 => "00000110",
		87 => "01010110",
		88 => "10010110",
		89 => "10110101",
		90 => "00001000",
		91 => "10110100",
		92 => "10010110",
		93 => "10000110",
		94 => "10010110",
		95 => "01010110",
		96 => "01000110",
		97 => "01010110",
		98 => "00010110",
		99 => "00100110",
		100 => "01000110",
		101 => "01010110",
		102 => "00100110",
		103 => "01000110",
		104 => "01010110",
		105 => "01110110",
		106 => "01000110",
		107 => "01010110",
		108 => "01110110",
		109 => "10010101",
		110 => "10100101",
		111 => "10010110",
		112 => "01110110",
		113 => "01010110",
		114 => "01000110",
		others => "11111111");
		
	begin
	Q <= my_rom(to_integer(unsigned(address)));
	
end architecture;
	
