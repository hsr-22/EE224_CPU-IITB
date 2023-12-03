library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library Work;
entity Register_N is
	generic (size: integer := 16);
	port (
			input         : in std_logic_vector(size - 1 downto 0);
			w_enable, clk : in std_logic;
			output        : out std_logic_vector(size - 1 downto 0)
			);
end entity Register_N;

architecture Behavioural of Register_N is
	signal data_int: std_logic_vector(size - 1 downto 0) := (others => '0');
	begin
		output <= data_int;
		edit_process: process(clk)
		begin
			if(clk='1' and clk'event and w_enable='1') then
				data_int <= input;
			else
				data_int <= data_int;
			end if;
		end process;
end architecture Behavioural;