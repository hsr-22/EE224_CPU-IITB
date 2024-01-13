library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Left_Shifter_2Mul is
	port (input : in std_logic_vector (15 downto 0);
			output : out std_logic_vector (15 downto 0));
end entity Left_Shifter_2Mul;

architecture Struct of Left_Shifter_2Mul is
begin
	output(15 downto 1) <= input(14 downto 0);
	output(0) <= '0';
end Struct;