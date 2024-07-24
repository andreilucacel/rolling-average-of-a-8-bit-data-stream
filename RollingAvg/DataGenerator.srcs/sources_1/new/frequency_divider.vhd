library IEEE;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity frequency_divider is
	port(
		CLK: in std_logic;
		CLK_OUT: out std_logic
	);
end frequency_divider;

architecture frequency_divider_architecture of frequency_divider is

begin
	DIV: process (CLK)
	
	variable counter: INTEGER range 0 to 99_000_000;
	begin
	if CLK'EVENT and CLK = '1' then
		counter := counter + 1;
		if counter >= 49_500_000 then
			CLK_OUT <= '1';
		else
			CLK_OUT <= '0';
				
		end if;
	end if;
		
	if counter = 99_000_000 then
		counter := 0;
	end if;
	
end process DIV;
end frequency_divider_architecture;