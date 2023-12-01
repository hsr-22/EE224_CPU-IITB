library ieee;
use ieee.std_logic_1164.all;

entity Decoder_2_To_4 is
    port (
        I : in std_logic_vector(1 downto 0);
        O : out std_logic_vector(3 downto 0));
end entity;

architecture dec of Decoder_2_To_4 is
begin
    decode_process : process (I)
    begin
        O(0) <= not I(1) and not I(0);
        O(1) <= I(0) and not I(1);
        O(2) <= I(1) and not I(0);
        O(3) <= I(1) and I(0);
        --        case input is
        --			when "00" => output <= "0001";
        --			when "01" => output <= "0010";
        --			when "10" => output <= "0100";
        --			when "11" => output <= "1000";
        --			when others => output <= "0000";
        --		end case;
    end process;
end dec;