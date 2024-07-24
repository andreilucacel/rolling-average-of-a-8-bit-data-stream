library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity SqWaveDivider is
	port(
		CLK: in std_logic;
		CLK_OUT: out std_logic
	);
end SqWaveDivider;

architecture A_SqWaveDivider of SqWaveDivider is

begin
	DIV: process (CLK)
		variable counter: INTEGER := 1;
		begin
		if CLK'EVENT and CLK = '1' then
			counter := counter + 1;
			if counter >= 4 then
				CLK_OUT <= '1';
			else
				CLK_OUT <= '0';		
			end if;
		end if;
			
		if counter = 4 then
			counter := 0;
		end if;
	end process DIV;
end A_SqWaveDivider;