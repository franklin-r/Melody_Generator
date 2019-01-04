-- ********************************************************************************
-- *                            Melody Generator                                  *
-- *                      Component : Frequency Divider                           *
-- *                                                                              *
-- * Ins : Clock, global signal reset, local signal clear                         *
-- * Outs : S4 Different time Ticks sending 1 after 125, 250, 500 or 1000ms       *
-- * Use : Creates a 1kHz frequency clock and uses it to count miliseconds        *
-- *       and send ticks accordingly to the MUX_4v1_1bit                         *
-- * comments :                                                                   *
-- ********************************************************************************


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------
 
entity FDIV is
   generic (	Fclock  : positive := 60E6);													--System clock frequency in Hertz
	port (  		Clock  : in std_logic;
              	Reset : in std_logic; 															--Global signal, switch on the card
				  	Clear : in std_logic; 															--Signal sent by the MUX_4v1_1bit to reset all counters
             	Tick_1000ms, Tick_500ms, Tick_250ms, Tick_125ms : out std_logic);	--Time ticks
end entity;

-------------------------------------

architecture DATAFLOW of FDIV is

	constant divisor_ms : positive := Fclock / 1000; 			--Number of clock ticks needed to atteign 1ms
	signal count : integer range 0 to Divisor_ms+1; 			--Count the system clock ticks until 1ms is past
	signal ms_past : std_logic; 										--Tick to signify that 1ms has past
	signal rst : std_logic;
	signal count_125ms : integer range 0 to 125; 				--Counts of how many ms have passed, one for each of the 4 Time-Ticks
	signal count_250ms : integer range 0 to 250;
	signal count_500ms : integer range 0 to 500;
	signal count_1000ms : integer range 0 to 1000;


begin

	rst <= Reset or Clear; 		--Simplify the process, resets the counters if either the Reset or the Clear is on

	process(Clock, rst)
	begin

 		if (rst = '1') then 							--Resets every counters
    		count <= 0;
    		count_500ms <= 0;
    		count_125ms <= 0;
    		count_250ms <= 0;
    		count_1000ms <= 0;

 		elsif (rising_edge(Clock)) then 			--Else, synchronous actions
  			count <= count + 1; 						--Counts system clock ticks
  			Tick_125ms <= '0'; 						--Resets every Time-Tick at 0
  			Tick_250ms <= '0';
  			Tick_500ms <= '0';
  			Tick_1000ms <= '0';

  			if (count = divisor_ms) then 			--If the system clock count hits Divisor_ms
    			count <= 0; 							--Reset the counter
    			ms_past <= '1'; 						--Signifies that one ms has passed
  			end if;
  
  
  			if (ms_past = '1') then 				--If one ms has been passed
    			count_125ms <= count_125ms + 1; 	--Increments all time-tick ms counters
    			count_250ms <= count_250ms + 1;
    			count_500ms <= count_500ms + 1;
    			count_1000ms <= count_1000ms + 1;
    			ms_past <= '0'; 						--Resets the ms_past tick
  			end if;
  
    
  			if (count_125ms = 125) then 			--If a limit has been reached on a ms counter
    			Tick_125ms <= '1'; 					--Sets the according time-tick to 1
    			count_125ms <= 0; 					--Resets the according counter
  			end if;
  
  			if (count_250ms = 250) then
    			Tick_250ms <= '1';
    			count_250ms <= 0;
  			end if;
  
  			if (count_500ms = 500) then
    			Tick_500ms <= '1';
    			count_500ms <= 0;
  			end if;
  
  			if (count_1000ms = 1000) then
    			Tick_1000ms <= '1';
    			count_1000ms <= 0;
  			end if;
		end if;
  
	end process;
end architecture;
