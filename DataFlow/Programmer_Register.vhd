library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity Register_File is
	port (A1, A2, A3: in std_logic_vector(2 downto 0);
			D3: in std_logic_vector(15 downto 0);
			D1, D2: out std_logic_vector(15 downto 0);
			clk, w_enable: in std_logic);
end entity Register_File;

architecture Behavioural of Register_File is
	component Register_N is
		generic (size: integer := 16);
		port (
				input         : in std_logic_vector(size - 1 downto 0);
				w_enable, clk : in std_logic;
				output        : out std_logic_vector(size - 1 downto 0)
				);
	end component Register_N;
	
	type enable_t is array (7 downto 0) of std_logic;
	signal w_enable_int: enable_t;
	
	type r_out_t is array (7 downto 0) of std_logic_vector(15 downto 0);
	signal r_out: r_out_t;
begin

	w_enable_int(0) <= w_enable and not(A3(2)) and not(A3(1)) and not(A3(0));
	w_enable_int(1) <= w_enable and not(A3(2)) and not(A3(1)) and (A3(0));
	w_enable_int(2) <= w_enable and not(A3(2)) and (A3(1)) and not(A3(0));
	w_enable_int(3) <= w_enable and not(A3(2)) and (A3(1)) and (A3(0));
	w_enable_int(4) <= w_enable and (A3(2)) and not(A3(1)) and not(A3(0));
	w_enable_int(5) <= w_enable and (A3(2)) and not(A3(1)) and (A3(0));
	w_enable_int(6) <= w_enable and (A3(2)) and (A3(1)) and not(A3(0));
	w_enable_int(7) <= w_enable and (A3(2)) and (A3(1)) and (A3(0));
	
	register_gen : for i in 0 to 7 generate
		reg: Register_N port map (input => D3, w_enable => w_enable_int(i), clk => clk, output => r_out(i));
	end generate;
	
	D1 <= r_out(to_integer(unsigned(A1)));
	
	D2 <= r_out(to_integer(unsigned(A2)));
end Behavioural;
	