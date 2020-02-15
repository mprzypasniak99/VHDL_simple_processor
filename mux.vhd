library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux is
port(	choice: in std_logic_vector(3 downto 0);
		input0, input1, input2, input3, input4, input5, input6, input7, input8: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end mux;

architecture behavior of mux is
signal tmp : std_logic_vector(15 downto 0);
begin
process(choice)
begin
	case choice is
		when "0000" => tmp <= input0;
		when "0001" => tmp <= input1;
		when "0010" => tmp <= input2;
		when "0011" => tmp <= input3;
		when "0100" => tmp <= input4;
		when "0101" => tmp <= input5;
		when "0110" => tmp <= input6;
		when "0111" => tmp <= input7;
		when "1000" => tmp <= input8;
		when others => tmp <= (others => '0');
	end case;
end process;
output <= tmp;
end behavior;