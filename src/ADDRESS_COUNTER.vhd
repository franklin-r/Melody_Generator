-- *********************************************************************************
-- *                            MelodyGenerator                                    *
-- *                       Component : ADDRESS_COUNTER                             *
-- *                                                                               *
-- * Ins : Tick_Next_Note indicating if the current note is over, reset and clock  *
-- * Outs : Address of the note to be played                                       *
-- * Use : effectively acts as a counter of notes, with the count being the address*
-- * comments :                                                                    *
-- *********************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ADDRESS_COUNTER is 
	port (	CLK : in std_logic;
			RST : in std_logic; 								--Asynchronous reset
			Tick_next_note : in std_logic;     					--Gets Tick-Next-Out from a frequency-divider, Start, Rest and Clk are global entries
			Adress_Note : out std_logic_vector (9 downto 0)); 	--Indicates which note needs to be played, gives the info to the memory
end entity;

architecture BEHAVIOUR of ADDRESS_COUNTER is
  signal Count : std_logic_vector (9 downto 0) := "0000000000";
  begin
    process(CLK, RST)
      begin
		if (RST = '1') then  					--If the Reset signal is on, reset the counter, reseting the melody
            Count <= (others => '0');
			
       elsif rising_edge(CLK) then 				--Synchroneous events
        
			  if ( Tick_next_note = '1') then 	--If the current note is over
					Count <= Count + '1'; 		--Increments the counter
			  end if;
			  
			  if (Count = "0001110011") then 	--If the count is equal 115 (number of the last note of the test melody + 1)
					Count <= (others => '0'); 	--Restarts the melody
				end if;
       end if;
       
    end process;
	 Adress_Note <= Count;						--The note adress take the counter as value
  end architecture;