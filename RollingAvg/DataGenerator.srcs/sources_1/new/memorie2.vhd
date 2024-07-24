----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2024 05:37:37 PM
-- Design Name: 
-- Module Name: memorie2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity memorie2 is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end memorie2;

architecture A_memorie2 of memorie2 is

begin
	
	process(CLK, RST)
	type StudentMem is array (5 downto 0) of std_logic_vector (7 downto 0);--6 numere a cate 8 biti
	variable memorie2: StudentMem := (X"07",X"08",X"09",X"0A",X"0B",X"0C"); 
	variable temp: std_logic_vector (7 downto 0);
	begin
		
			
		if (rising_edge(CLK)) then
			if (RST = '1') then
			  OP <= "00000000";
			end if;
			
			temp := memorie2(5);
			memorie2(5 downto 1) := memorie2(4 downto 0); --shift dreapta
			memorie2(0) := temp; -- al 5 lea nr inainte de shiftare
			
		end if;
		OP <= temp;
	end process;
end A_memorie2;