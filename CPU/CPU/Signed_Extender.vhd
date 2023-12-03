library ieee;
use ieee.std_logic_1164.all;

entity Signed_Extender is
	generic (input_size: integer := 6);
	port (input: in std_logic_vector(input_size - 1 downto 0);
			output: out std_logic_vector(15 downto 0));
end entity Signed_Extender;

architecture Struct of Signed_Extender is
	constant pad_zeroes : std_logic_vector(15-input_size downto 0) := (others => '0');
	constant pad_ones   : std_logic_vector(15-input_size downto 0) := (others => '1');
begin
	proc: process(input)
	begin
		if (input(input_size-1) = '0') then 
			output <= pad_zeroes & input;  -- Removing sign bit unneccessary
		else 
			output <= pad_ones & input;
		end if;
	end process;
end Struct;