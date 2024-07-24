library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity DISPLAY is
	port(CLK: in std_logic;
	number: in std_logic_vector (7 downto 0);
	average: in std_logic_vector (7 downto 0);
	ANOD: out std_logic_vector(3 downto 0);
	CATOD: out std_logic_vector(7 downto 0));
end DISPLAY;

architecture A_DISPLAY of DISPLAY is
signal LED: std_logic_vector(3 downto 0) := "1110";
signal CLK200Hz: std_logic;
type LED_out_type is array (3 downto 0) of std_logic_vector (7 downto 0);
signal LED_out: LED_out_type := (others =>(others=>'0'));

component FreqDivider7Seg is
	port(CLK: in std_logic;
	CLK_OUT_2: out std_logic);
end component;

component Convertor is 
port (
number: in std_logic_vector (3 downto 0);
Converted: out std_logic_vector (7 downto 0)
);
end component;
	
begin
	
	C0: Convertor port map(number=>number (7 downto 4),Converted=> LED_out(0));
	C1: Convertor port map(number=>number (3 downto 0),Converted=> LED_out(1));
	C2: Convertor port map(number=>average (7 downto 4),Converted=> LED_out(2));
	C3: Convertor port map(number=>average (3 downto 0),Converted=>LED_out(3));
	
	
	
CLKDiv: FreqDivider7Seg port map(CLK=>CLK,CLK_OUT_2=> CLK200Hz);
	process(CLK200HZ, LED)
	begin
		if (rising_edge(CLK200Hz)) then
			LED(3) <= LED(0);
			LED(0) <= LED(1);
			LED(1) <= LED(2);
			LED(2) <= LED(3); 
		end if;

	end process;
	
	
afisare: process (LED)
begin
    case LED is
		when "1110" => CATOD <= LED_out(0);
		when "1101" => CATOD <= LED_out(1);
		when "1011" => CATOD <= LED_out(2);
		when "0111" => CATOD <= LED_out(3);	 
		when others => CATOD <= "00000000";
	end case;
end process afisare;
ANOD <= LED;	

end A_DISPLAY;
	