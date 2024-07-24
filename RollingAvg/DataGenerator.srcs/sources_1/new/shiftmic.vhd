library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shiftmic is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end shiftmic;

architecture A_shiftmic of shiftmic is
signal OP_INT: std_logic_vector (3 downto 0):= "1101";
begin
	process(CLK, RST)
	begin
		if (RST = '1') then
			OP_INT <= "0001";
		elsif (rising_edge(CLK)) then
			OP_INT(3 downto 1) <= OP_INT(2 downto 0);--shift
			OP_INT(0) <= (OP_INT(2) xor OP_INT(3));
		end if;
		OP <= "0000" & OP_INT;--inversare biti
	end process;
end A_shiftmic;