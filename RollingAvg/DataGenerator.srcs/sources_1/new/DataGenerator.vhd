library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DataGenerator is
	port( CLK: in std_logic;
	RST: in std_logic;
	Control: in std_logic_vector (2 downto 0);
	DATA1: out std_logic_vector (7 downto 0));
end DataGenerator;

architecture A_DataGenerator of DataGenerator is

component shiftmic is
	port( CLK, RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end component;

component shiftmare is
	port(CLK, RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end component;

component frequency_divider is
	port(
		CLK: in std_logic;
		CLK_OUT: out std_logic
	);
end component;

component SquareWave is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end component;

component memorie2 is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end component;

component memorie1 is
	port( CLK: in std_logic;
	RST: in std_logic;
	OP: out std_logic_vector (7 downto 0));
end component;


signal data_clk: std_logic;
signal OP_shiftmic: std_logic_vector(7 downto 0);
signal OP_shiftmare: std_logic_vector(7 downto 0);
signal DATA: std_logic_vector(7 downto 0);
signal OP_SQ_Wave: std_logic_vector (7 downto 0);
signal OP_memorie1:  std_logic_vector (7 downto 0);
signal OP_memorie2:  std_logic_vector (7 downto 0);
begin
	I_shiftmic: shiftmic port map (CLK => CLK, RST => RST, OP => OP_shiftmic);
	I_shiftmare: shiftmare port map (CLK => CLK, RST => RST, OP => OP_shiftmare);
	FrDiv: frequency_divider port map (CLK, data_clk);
	SW: SquareWave port map(CLK, RST, OP_SQ_Wave);
	S1: memorie1 port map(CLK, RST, OP_memorie1);
	S2: memorie2 port map(CLK, RST, OP_memorie2);
	
CLK_Process: process (CLK, RST)

	
	begin
		
		if (CLK'EVENT and CLK = '1') then
			if RST = '1' then
				
				DATA <= (others => '0');
			end if;
			case Control is
				when "000" => DATA <= (others => '0'); -- reset/test mode
				when "001" =>  -- square wave
				
				
				DATA <= OP_SQ_Wave;
				when "010" => -- Numbers of mem1
				
				
				DATA <= OP_memorie1;
				when "011" => -- Numbers of mem2
				
				DATA <= OP_memorie2;
				when "110" => -- Numbers from shiftmic(0-15)
				DATA <= OP_shiftmic;
				when "111" => -- Numbers from shiftmare(0-255)
				DATA <= OP_shiftmare;
				when others => DATA <= (others => '0'); -- other cases
			end case;
		
	end if;
	
	end process CLK_Process;
Afisaj: process(data_clk)
begin
if data_clk = '1' and data_clk'event then
			DATA1 <= DATA;
end if;
end process Afisaj;
end A_DataGenerator;