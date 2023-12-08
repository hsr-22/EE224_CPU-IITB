library ieee;
use ieee.std_logic_1164.all;

entity Decoder_1_To_2 is
    port (
        I : in std_logic;
        O : out std_logic_vector(1 downto 0));
end entity;

architecture dec of Decoder_1_To_2 is
begin
    dec_process : process (I)
    begin
        O(0) <= not I;
        O(1) <= I;
        --case input is
        --			when "0" => output <= "01";
        --			when "1" => output <= "10";
        --			when others => output <= "00";
        --		end case;
    end process;
end dec;