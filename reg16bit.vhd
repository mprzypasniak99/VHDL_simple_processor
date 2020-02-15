library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg16bit is
port(	clk, enable, reset: in std_logic;
		d_in: in std_logic_vector(15 downto 0);
		d_out: out std_logic_vector(15 downto 0));
end reg16bit;

architecture behavior of reg16bit is
signal tmp: std_logic_vector(15 downto 0) := (others => '0');

begin
process(clk, enable, reset)
begin
	if(reset = '1') then
		tmp <= (others => '0');
	elsif(clk'event and clk = '1') then
		if(enable = '1') then
			tmp <= d_in;
		else
			tmp <= tmp;
		end if;
	end if;
end process;

d_out <= tmp;

end behavior;