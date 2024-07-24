library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shiftmare is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end shiftmare;

architecture A_shiftmare of shiftmare is
signal OP_INT: std_logic_vector (7 downto 0):= "00000011";
signal FB1, FB2, FB3: std_logic;	
begin
	FB1 <= OP_INT(0) xor OP_INT(2);
	FB2 <= FB1 xor OP_INT(3);
	FB3 <= FB2 xor OP_INT(4);
	process(CLK, RST)
	begin
		if (RST = '1') then
			OP_INT <= "00000011";
		elsif (rising_edge(CLK)) then
			OP_INT(6 downto 0) <= OP_INT(7 downto 1);
			OP_INT(7) <= FB3;
		end if;
		OP <= OP_INT;
	end process;
end A_shiftmare;