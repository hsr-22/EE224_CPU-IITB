library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
	port (A, B: in std_logic_vector(15 downto 0);
			opcode: in std_logic_vector(2 downto 0);
			C: out std_logic_vector(15 downto 0);
			z_flag: out std_logic);
end entity ALU;

	-------------------------------------------------------
	-- 000: ADD
	-- 001: SUB
	-- 011: MUL
	-- 010: ? (ADI)
	-- 100: AND
	-- 101: ORA
	-- 110: IMP
	-- 111: ? 
	-------------------------------------------------------


architecture Struct of ALU is
	signal result: std_logic_vector(15 downto 0);
begin
    process(A, B, opcode)
        variable temp_result : signed(15 downto 0);
    begin
		if(opcode(2) = '0') then
			case opcode(1 downto 0) is
				when "00" => temp_result := signed(A) + signed(B);
				when "01" => temp_result := signed(A) - signed(B);
			-- when "10" => temp_result := signed(A) + signed(B);
				when "11" => temp_result := resize(signed(A(3 downto 0)) * signed(B(3 downto 0)),16);
				when others => temp_result := signed(A); 
			end case;
       
        result <= std_logic_vector(temp_result);
		else
			case opcode(1 downto 0) is
				when "00" => result <= A and B; 
				when "01" => result <= A or B; 
				when "10" => result <= (not A) or B; 
			-- when "11" => temp_result := signed(A) * signed(B);
				when others => result <= A;
			end case;
		end if;
    end process;
	 
	 C <= result;
	 z_flag <= '1' when result = "0000000000000000" else '0';
end architecture Struct;

