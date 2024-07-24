library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity memorie1 is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end memorie1;

architecture A_memorie1 of memorie1 is

begin
	
	process(CLK, RST)
	type Memorie is array (5 downto 0) of std_logic_vector (7 downto 0);
	variable memorie1: Memorie := (X"01",X"02",X"03",X"04",X"05",X"06"); 
	variable temp: std_logic_vector (7 downto 0);
	begin
		
			
		if (rising_edge(CLK)) then
			if (RST = '1') then
			  OP <= "00000000";
			end if;
			
			temp := memorie1(5);--al 5 lea nr 
			memorie1(5 downto 1) := memorie1(4 downto 0);
			memorie1(0) := temp;
			
		end if;
		OP <= temp;
	end process;
end A_memorie1;