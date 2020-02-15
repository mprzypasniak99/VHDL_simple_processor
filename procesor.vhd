library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity procesor is
port(	KEY: in std_logic_vector(1 downto 0);
		SW: in std_logic_vector(17 downto 0);
		LEDR: out std_logic_vector(17 downto 0));
end procesor;


architecture behavior of procesor is

component reg16bit is
port(	clk, enable, reset: in std_logic;
		d_in: in std_logic_vector(15 downto 0);
		d_out: out std_logic_vector(15 downto 0));
end component;

component mux is
port(	choice: in std_logic_vector(3 downto 0);
		input0, input1, input2, input3, input4, input5, input6, input7, input8: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end component;

component sum16bit is
port(	a16, b16: in std_logic_vector(15 downto 0);
		sub: in std_logic;
		s16: out std_logic_vector(15 downto 0));
end component;

component counter is
port(	clk, clear: in std_logic;
		count: out std_logic_vector(1 downto 0));
end component;

component reg8bit is
port(	clk, enable: in std_logic;
		d_in: in std_logic_vector(7 downto 0);
		d_out: out std_logic_vector(7 downto 0));
end component;

component dec3to8 is
port(	enable: in std_logic;
		d_in: in std_logic_vector(2 downto 0);
		d_out: out std_logic_vector(7 downto 0));
end component;

constant h : std_logic := '1';

signal reg_enable, x_reg, y_reg, reg_tmp : std_logic_vector(8 downto 0) := (others => '0');
signal mux_out: std_logic_vector(15 downto 0);
signal mux_choice, mux_tmp: std_logic_vector(3 downto 0);
signal mux0, mux1, mux2, mux3, sum, mux4, mux5, mux6, mux7, summand: std_logic_vector(15 downto 0);
signal sub: std_logic;
signal clear_count, load_cmd: std_logic := '0';
signal instr_num: std_logic_vector(1 downto 0);
signal cmd: std_logic_vector(7 downto 0);
signal led_reg: std_logic_vector(17 downto 0) := (others => '0');

begin
reg0: reg16bit port map(KEY(1), reg_enable(0), KEY(0), mux_out, mux0);
reg1: reg16bit port map(KEY(1), reg_enable(1), KEY(0), mux_out, mux1);
reg2: reg16bit port map(KEY(1), reg_enable(2), KEY(0), mux_out, mux2);
reg3: reg16bit port map(KEY(1), reg_enable(3), KEY(0), sum, mux3);
reg4: reg16bit port map(KEY(1), reg_enable(4), KEY(0), mux_out, mux4);
reg5: reg16bit port map(KEY(1), reg_enable(5), KEY(0), mux_out, mux5);
reg6: reg16bit port map(KEY(1), reg_enable(6), KEY(0), mux_out, mux6);
reg7: reg16bit port map(KEY(1), reg_enable(7), KEY(0), mux_out, mux7);
reg_a: reg16bit port map(KEY(1), reg_enable(8), KEY(0), mux_out, summand);

multiplexer: mux port map(mux_choice, mux0, mux1, mux2, mux3, mux4, mux5, mux6, mux7, SW(15 downto 0), mux_out);

addsubtr: sum16bit port map(summand, mux_out, sub, sum);

instr_count: counter port map(KEY(1) and SW(17), clear_count or KEY(0), instr_num);

command: reg8bit port map(KEY(1), load_cmd, SW(7 downto 0), cmd);
X_r: dec3to8 port map(h, cmd(5 downto 3), x_reg(7 downto 0));
Y_r: dec3to8 port map(h, cmd(2 downto 0), y_reg(7 downto 0));

process(instr_num, cmd)
begin
	case instr_num is
		when "00" =>
			load_cmd <= '1';
			clear_count <= '0';
			led_reg <= (others => '0');
			reg_tmp <= (others => '0');
			mux_tmp <= (others => '0');
		when "01" =>
			case cmd(7 downto 6) is
				when "00" =>
					load_cmd <= '0';
					reg_tmp <= x_reg;
					mux_tmp <= "0000" or cmd(2 downto 0);
					led_reg(15 downto 0) <= mux_out;
					led_reg(17) <= '1';
					clear_count <= '1';
				when "01" =>
					load_cmd <= '0';
					reg_tmp <= x_reg;
					mux_tmp <= "1000";
					led_reg(15 downto 0) <= mux_out;
					led_reg(17) <= '1';
					clear_count <= '1';
				when "10" =>
					load_cmd <= '0';
					reg_tmp <= "100000000";
					mux_tmp <= "0011";
					led_reg(15 downto 0) <= mux_out;
					clear_count <= '0';
				when others =>
					load_cmd <= '0';
					reg_tmp <= (others => '0');
					mux_tmp <= (others => '0');
					led_reg <= (others => '1');
					clear_count <= '1';
			end case;
		when "10" =>
			case cmd(7 downto 6) is
				when "10" =>
					load_cmd <= '0';
					reg_tmp <= "000000100";
					mux_tmp <= "0000" or cmd(2 downto 0);
					sub <= cmd(3);
					led_reg(15 downto 0) <= mux_out;
					clear_count <= '0';
				when others =>
					load_cmd <= '0';
					reg_tmp <= (others => '0');
					mux_tmp <= (others => '0');
					led_reg <= (others => '1');
					clear_count <= '1';
			end case;
		when "11" =>
			case cmd(7 downto 6) is
				when "10" =>
					load_cmd <= '0';
					reg_tmp <= "000000000";
					mux_tmp <= "0011";
					led_reg(15 downto 0) <= mux_out;
					led_reg(17) <= '1';
					clear_count <= '1';
				when others =>
					load_cmd <= '0';
					reg_tmp <= (others => '0');
					mux_tmp <= (others => '0');
					led_reg <= (others => '1');
					clear_count <= '1';
			end case;
	end case;
	
end process;
reg_enable <= reg_tmp;
mux_choice <= mux_tmp;
LEDR <= led_reg;

end behavior;