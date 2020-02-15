library ieee;
use ieee.std_logic_1164.all;

entity sum1bit is
	port(a, b, c_in: in std_logic;
		s, c_out: out std_logic);
	end sum1bit;
	
architecture strukturalna of sum1bit is
begin
	s <= (a xor b xor c_in) or (a and b and c_in);
	c_out <= (a and b) or (b and c_in) or (a and c_in);

end strukturalna;