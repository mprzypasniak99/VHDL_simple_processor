library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
port(	clk, clear: in std_logic;
		count: out std_logic_vector(1 downto 0));
end counter;

architecture behavior of counter is
signal tmp: std_logic_vector(1 downto 0) := "00";
begin

process(clk, clear)
begin
	if(clk'event and clk = '1') then
		if(clear = '1') then
			tmp <= "00";
		else
			tmp <= tmp + 1;
		end if;
	end if;
end process;

count <= tmp;
end behavior;
