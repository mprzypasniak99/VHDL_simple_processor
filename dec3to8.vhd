library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity dec3to8 is
port(	enable: in std_logic;
		d_in: in std_logic_vector(2 downto 0);
		d_out: out std_logic_vector(7 downto 0));
end dec3to8;

architecture behavior of dec3to8 is
begin

process(enable)
begin
	if(enable = '1') then
		case d_in is
			when "000" => d_out <= "00000001";
			when "001" => d_out <= "00000010";
			when "010" => d_out <= "00000100";
			when "011" => d_out <= "00001000";
			when "100" => d_out <= "00010000";
			when "101" => d_out <= "00100000";
			when "110" => d_out <= "01000000";
			when "111" => d_out <= "10000000";
		end case;
	else
		d_out <= "00000000";
	end if;
end process;

end behavior;