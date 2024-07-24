library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SquareWave is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end SquareWave;

architecture A_SquareWave of SquareWave is

component frequency_divider is	-- 1Hz clock
	port(
		CLK: in std_logic;
		CLK_OUT: out std_logic
	);
end component;

component SqWaveDivider is	-- o.25 x DataClock of 1Hz
	port(
		CLK: in std_logic;
		CLK_OUT: out std_logic
	);
end component;

signal OP_INT: std_logic_vector (7 downto 0):= "00010000"; -- 16 , 32 , 64
signal CLK1Hz: std_logic;
signal CLKSqWave: std_logic;
begin
	DatCLK: frequency_divider port map (CLK, CLK1Hz);
	SqWave: SqWaveDivider port map (CLK1Hz, CLKSqWave);
	
	process(CLKSqWave, RST)
	begin
		if (RST = '1') then
			OP_INT <= "00000000";
		elsif (rising_edge(CLK)) then
			OP_INT(6 downto 0) <= OP_INT(7 downto 1);
			OP_INT(7) <= OP_INT(0);
		end if;
		OP <= OP_INT;
	end process;
end A_SquareWave;