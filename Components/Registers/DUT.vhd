library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(17 downto 0);
       	output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DutWrap of DUT is
	component Register_N is
		generic (size: integer := 16);
		port (
				input         : in std_logic_vector(size - 1 downto 0);
				w_enable, clk : in std_logic;
				output        : out std_logic_vector(size - 1 downto 0)
				);
	end component Register_N;
begin
   add_instance: Register_N 
			port map (
					input => input_vector(17 downto 2),
					w_enable => input_vector(1),
					clk => input_vector(0),
					output => output_vector
					);
end DutWrap;