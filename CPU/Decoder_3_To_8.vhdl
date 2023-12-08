library ieee;
use ieee.std_logic_1164.all;

entity Decoder_3_To_8 is
    port (
        I : in std_logic_vector(2 downto 0);
        O : out std_logic_vector(7 downto 0));
end entity;

architecture dec of Decoder_3_To_8 is
begin
    dec_process : process (I)
    begin
        O(0) <= not(I(0)) and not(I(1)) and not(I(2));
        O(1) <= (I(0)) and not(I(1)) and not(I(2));
        O(2) <= not(I(0)) and (I(1)) and not(I(2));
        O(3) <= (I(0)) and (I(1)) and not(I(2));
        O(4) <= not(I(0)) and not(I(1)) and (I(2));
        O(5) <= (I(0)) and not(I(1)) and (I(2));
        O(6) <= not(I(0)) and (I(1)) and (I(2));
        O(7) <= (I(0)) and (I(1)) and (I(2));
        --		case input is
        --			when "000" = output <= "00000001";
        --			when "001" = output <= "00000010";
        --			when "010" = output <= "00000100";
        --			when "011" = output <= "00001000";
        --			when "100" = output <= "00010000";
        --			when "101" = output <= "00100000";
        --			when "110" = output <= "01000000";
        --			when "111" = output <= "10000000";
        --			when others = output <= "00000000";
        --		end case;
    end process;
end dec;