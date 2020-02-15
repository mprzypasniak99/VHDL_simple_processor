library ieee;
use ieee.std_logic_1164.all;

entity sum16bit is
	port(	a16, b16: in std_logic_vector(15 downto 0);
			sub: in std_logic;
			s16: out std_logic_vector(15 downto 0));
			
	end sum16bit;
	
architecture strukturalna of sum16bit is

component sum1bit
	port(a, b, c_in: in std_logic;
			s, c_out: out std_logic);
	end component;
	
	constant zero : std_logic:= '0';
	
	signal c1: std_logic;
	signal c2: std_logic;
	signal c3: std_logic;
	signal c4: std_logic;
	signal c5: std_logic;
	signal c6: std_logic;
	signal c7: std_logic;
	signal c8: std_logic;
	signal c9: std_logic;
	signal c10: std_logic;
	signal c11: std_logic;
	signal c12: std_logic;
	signal c13: std_logic;
	signal c14: std_logic;
	signal c15: std_logic;
	signal c16: std_logic;
	
	signal tmp: std_logic_vector(15 downto 0);
	
begin

	process(sub)
	begin
		if(sub = '1') then
			tmp <= not b16;
		else
			tmp <= b16;
		end if;
	end process;
			
	
	sum0: sum1bit port map(a16(0), tmp(0), sub, s16(0), c1);
	sum1: sum1bit port map(a16(1), tmp(1), c1, s16(1), c2);
	sum2: sum1bit port map(a16(2), tmp(2), c2, s16(2), c3);
	sum3: sum1bit port map(a16(3), tmp(3), c3, s16(3), c4);
	sum4: sum1bit port map(a16(4), tmp(4), c4, s16(4), c5);
	sum5: sum1bit port map(a16(5), tmp(5), c5, s16(5), c6);
	sum6: sum1bit port map(a16(6), tmp(6), c6, s16(6), c7);
	sum7: sum1bit port map(a16(7), tmp(7), c7, s16(7), c8);
	sum8: sum1bit port map(a16(8), tmp(8), c8, s16(8), c9);
	sum9: sum1bit port map(a16(9), tmp(9), c9, s16(9), c10);
	sum10: sum1bit port map(a16(10), tmp(10), c10, s16(10), c11);
	sum11: sum1bit port map(a16(11), tmp(11), c11, s16(11), c12);
	sum12: sum1bit port map(a16(12), tmp(12), c12, s16(12), c13);
	sum13: sum1bit port map(a16(13), tmp(13), c13, s16(13), c14);
	sum14: sum1bit port map(a16(14), tmp(14), c14, s16(14), c15);
	sum15: sum1bit port map(a16(15), tmp(15), c15, s16(15), c16);
	
end strukturalna;