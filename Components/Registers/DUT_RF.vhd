library ieee;
use ieee.std_logic_1164.all;

entity DUT_RF is
    port(input_vector: in std_logic_vector(26 downto 0);
       	output_vector: out std_logic_vector(31 downto 0));
end entity;

architecture DutWrap of DUT_RF is
	component Register_File is
		port (A1, A2, A3: in std_logic_vector(2 downto 0);
				D3: in std_logic_vector(15 downto 0);
				D1, D2: out std_logic_vector(15 downto 0);
				clk, w_enable: in std_logic);
	end component Register_File;
begin
   add_instance: Register_File 
			port map (
					clk => input_vector(26),
					w_enable => input_vector(25),
					A1 => input_vector(24 downto 22),
					A2 => input_vector(21 downto 19),
					A3 => input_vector(18 downto 16),
					D3 => input_vector(15 downto 0),
					D1 => output_vector(31 downto 16),
					D2 => output_vector(15 downto 0)
					);
end DutWrap;