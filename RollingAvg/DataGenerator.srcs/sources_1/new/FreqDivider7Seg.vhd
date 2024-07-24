library IEEE;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity FreqDivider7Seg is
	port(
		CLK: in std_logic;
		CLK_OUT_2: out std_logic
	);
end FreqDivider7Seg;

architecture A_FreqDivider7Seg of FreqDivider7Seg is

begin
	DIV: process (CLK)
	
	variable counter: INTEGER range 0 to 500_000;
	begin
	if CLK'EVENT and CLK = '1' then
		counter := counter + 1;
		if counter >= 250_000 then
			CLK_OUT_2 <= '1';
		else
			CLK_OUT_2 <= '0';
				
		end if;
	end if;
		
	if counter = 500_000 then
		counter := 0;
	end if;
	
end process DIV;
end A_FreqDivider7Seg;