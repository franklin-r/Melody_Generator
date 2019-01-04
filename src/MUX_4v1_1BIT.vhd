-- *******************************************************************************
-- *                        Melody Generator                                     *
-- *                       Component : MUX_4v1_1bit                              *
-- *                                                                             *
-- * Ins : 4 Time-Ticks from the FDIV, clock, 2-bits Duration from the Memory 	*
-- * Outs : Tick_Next_Note to the Adress_Counter, Clear to FDIV         		  	*
-- * Use : Assign the correct Time-Tick signal to the Adress_Counter,            *
-- *       depending on the duration of the note.                                *
-- * comments : - When the Time_Tick assigned to Tick_Next_Note hits one,        *
-- *           triggers the switch to the next note and clears the counters of   *
-- *           the frequency divider                                             *
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity MUX_4v1_1BIT is 

	port(	Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms, Clock : in std_logic;    	--Inputs
  			Duration : in std_logic_vector(1 downto 0);                         			--Selector
  			Tick_Next_Note : out std_logic;                                     			--Outputs, going to the Adress_Counter
  			Clear : out std_logic);                                             			--Signal used to clear the Frequency Divider
end entity;


architecture BEHAVE of MUX_4v1_1bit is

	signal tick_note : std_logic;

begin 
  process(Clock) is 
  begin
    if (rising_edge(Clock)) then 
    	case Duration is 											--Assign the correct Time-Tick to Tick_Note
        when "00" => tick_note <= Tick_125ms;        	--Sixteenth note
        when "01" => tick_note <= Tick_250ms;        	--Eighth note
        when "10" => tick_note <= Tick_500ms;        	--Quarter note
        when "11" => tick_note <= Tick_1000ms;       	--Half note
        when others => tick_note <= '0'; 
      end case;
      
      if (Tick_Note = '1') then 				--If the Tick assigned hits one, sends a one to the AC and clears the FD
        Tick_Next_Note <= '1';
        Clear <= '1';
      elsif (Tick_Note = '0') then  		--Else, sends 0
        Tick_Next_Note <= '0';
        Clear <= '0';
      end if;
    end if;
  end process;
end architecture;