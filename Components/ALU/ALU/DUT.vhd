library ieee;
use ieee.std_logic_1164.all;

entity DUT is
   port(input_vector: in std_logic_vector(34 downto 0);
       	output_vector: out std_logic_vector(16 downto 0));
end entity;

architecture DutWrap of DUT is
	component ALU is 
		port (A, B: in std_logic_vector(15 downto 0);
				opcode: in std_logic_vector(2 downto 0);
				C: out std_logic_vector(15 downto 0);
				z_flag: out std_logic);
	end component ALU;
begin
   add_instance: ALU port map (
						opcode => input_vector(34 downto 32),
						A => input_vector(31 downto 16), 
						B => input_vector(15 downto 0),
						z_flag => output_vector(16),
						C => output_vector(15 downto 0));
end DutWrap;

