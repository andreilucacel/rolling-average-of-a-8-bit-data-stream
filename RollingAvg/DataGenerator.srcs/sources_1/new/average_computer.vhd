library IEEE;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity average_computer is
port (
		number: IN std_logic_vector (7 downto 0);
		reset: IN std_logic;
		data_clk: IN std_logic;
		length: IN std_logic_vector (2 downto 0);
		average: OUT std_logic_vector (7 downto 0)
	);
end average_computer;

architecture average_computer_architecture of average_computer is

	-- numerele vor fi stocate intr-un array de numere care va tine 16 elemente
	type number_array_t is array (15 downto 0) of std_logic_vector (11 downto 0);
	signal number_array: number_array_t := (others=>(others=>'0'));
	signal clk_enable: std_logic := '1';
begin
	
process_average: process(reset, data_clk)
	
	-- vom stoca suma a doua cate doua elemente, respectiv a 4 cate 4, 8 cate 8 si a tuturor celor 16 numere prezente in sirul nostru de 16 numere stocate
	
	type average_display_type is array (3 downto 0) of std_logic_vector (7 downto 0);
	type sum2_type is array (7 downto 0) of std_logic_vector (11 downto 0);
	type sum4_type is array (3 downto 0) of std_logic_vector (11 downto 0);
	type sum8_type is array (1 downto 0) of std_logic_vector (11 downto 0);
	
	variable average_display: average_display_type;
	variable sum2: sum2_type;
	variable sum4: sum4_type;
	variable sum8: sum8_type;
	variable sum16: std_logic_vector (11 downto 0);
	
begin
	if data_clk'event and data_clk = '1' and length /= "000" then
		clk_enable <= '1';
		if reset = '1' then
			average <= (others => '0');
			number_array <= (others =>(others => '0'));
		else		
			number_array (15 downto 1) <= number_array (14 downto 0);
			number_array(0)(7 downto 0) <= number;
			
		end if;
	end if;	  
	
	
	
sum_2: 
	for index in 0 to 7 loop
		sum2(index) := number_array(index*2) + number_array(index*2 + 1);
	end loop;
	 
sum_4: 	
	for index in 0 to 3 loop
		sum4(index) := sum2(index*2) + sum2(index*2+1);
	end loop;

sum_8:
	sum8(0) := sum4(0) + sum4(1);
	sum8(1) := sum4(2) + sum4(3);

sum_16:	
	sum16:= sum8(0) + sum8(1);
	
	-- facem impartirea numerelor prin deplasare la stanga
	
	sum2(0)(7 downto 0) := sum2(0)(8 downto 1);
	average_display(0) := sum2(0)(7 downto 0); --media a 2 numere
	
	sum4(0)(7 downto 0) := sum4(0)(9 downto 2);
	average_display(1) := sum4(0)(7 downto 0); --media a 4 numere	
	
	sum8(0)(7 downto 0) := sum8(0)(10 downto 3);
	average_display(2) := sum8(0)(7 downto 0); --media a 8 numere	
	
	sum16(7 downto 0) := sum16(11 downto 4);
	average_display(3) := sum16(7 downto 0); --media a 16 numere
	
	case length is
		when "100" => average <= average_display(0);
		when "101" => average <= average_display(1);
		when "110" => average <= average_display(2);
		when "111" => average <= average_display(3);
		when "000" => clk_enable <='0';
		when others => average <= "00000000";
	end case;


	
		

end process process_average;

end	average_computer_architecture;

	
	