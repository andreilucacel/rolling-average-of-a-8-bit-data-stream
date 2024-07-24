library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity average is
	port (
	CLK: in std_logic;
	RST: in std_logic;
	Length: in std_logic_vector (2 downto 0);
	Control: in std_logic_vector (2 downto 0);
	ANOD: out std_logic_vector (7 downto 0);
	CATOD: out std_logic_vector (7 downto 0)
	);
end average;

architecture average_architecture of average is
component DataGenerator is
	port (
	CLK, RST: in std_logic;
	Control: in std_logic_vector (2 downto 0);
	Data1: out std_logic_vector (7 downto 0)
	);
end component;

component frequency_divider is
	port( 
	CLK: in std_logic;
	CLK_OUT: out std_logic
	);
end component ;



component average_computer is 
	port (
		number: IN std_logic_vector (7 downto 0);
		reset: IN std_logic;
		data_clk: IN std_logic;
		length: IN std_logic_vector (2 downto 0);
		average: OUT std_logic_vector (7 downto 0)
	);
end component ;

component DISPLAY is
	port(CLK: in std_logic;
	number: in std_logic_vector (7 downto 0);
	average: in std_logic_vector (7 downto 0);
	ANOD: out std_logic_vector(3 downto 0);
	CATOD: out std_logic_vector(7 downto 0));
end component;

signal Data_internal: std_logic_vector (7 downto 0);
signal DATA_CLK: std_logic;
signal display_internal: std_logic_vector (7 downto 0);
signal average_internal: std_logic_vector (7 downto 0);
begin
	DG: DataGenerator port map(CLK=>CLK, RST=>RST,Control=> Control,Data1=> Data_internal);
	FDiv: frequency_divider port map(CLK=>CLK,CLK_OUT=> DATA_CLK);	
	Filter: average_computer port map(number=>Data_internal, reset=>RST,data_clk=> DATA_CLK, length=>length, average=> average_internal);
	Displayer: DISPLAY port map(CLK=>CLK,number=> Data_internal,average=> average_internal,ANOD=> ANOD(3 downto 0), CATOD=>CATOD);
	ANOD(7 downto 4) <= "1111";
	
end average_architecture;