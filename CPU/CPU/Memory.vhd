library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity Memory is 
		port(
				clk, m_wr, m_rd: in std_logic; 
				mem_addr, mem_in: in std_logic_vector(15 downto 0);
				mem_out: out std_logic_vector(15 downto 0)
			 ); 
end entity; 

architecture Behavioural of Memory is 

		constant op_ADD : std_logic_vector(3 downto 0):= "0000";
		constant op_SUB : std_logic_vector(3 downto 0):= "0010";  
		constant op_MUL : std_logic_vector(3 downto 0):= "0011";
		constant op_ADI : std_logic_vector(3 downto 0):= "0001";
		constant op_AND : std_logic_vector(3 downto 0):= "0100";
		constant op_ORA : std_logic_vector(3 downto 0):= "0101";
		constant op_IMP : std_logic_vector(3 downto 0):= "0110";
		constant op_LHI : std_logic_vector(3 downto 0):= "1000";
		constant op_LLI : std_logic_vector(3 downto 0):= "1001";
		constant op_LW  : std_logic_vector(3 downto 0):= "1010";  
		constant op_SW  : std_logic_vector(3 downto 0):= "1011";
		constant op_BEQ : std_logic_vector(3 downto 0):= "1100";
		constant op_JAL : std_logic_vector(3 downto 0):= "1101";
		constant op_JLR : std_logic_vector(3 downto 0):= "1111";
		constant op_NOP : std_logic_vector(3 downto 0):= "1110"; 

		function op_R(opcode_str : std_logic_vector(3 downto 0); value1, value2, value3 : integer) return std_logic_vector is
			 variable result : std_logic_vector(15 downto 0);
		begin	 
			 result :=  opcode_str & std_logic_vector(to_unsigned(value1, 3)) & std_logic_vector(to_unsigned(value2, 3)) & std_logic_vector(to_unsigned(value3, 3)) & "000";
			 return result;
		end function;
		
				function op_I(opcode_str : std_logic_vector(3 downto 0); value1, value3 : integer; imm : std_logic_vector(5 downto 0)) return std_logic_vector is
			 variable result : std_logic_vector(15 downto 0);
		begin 
			 result := opcode_str & std_logic_vector(to_unsigned(value1, 3)) & std_logic_vector(to_unsigned(value3, 3)) & imm;
			 return result;
		end function;
		
				function op_J(opcode_str : std_logic_vector(3 downto 0); value1 : integer; imm : std_logic_vector(8 downto 0)) return std_logic_vector is
			 variable result : std_logic_vector(15 downto 0);
		begin 
			 result := opcode_str & std_logic_vector(to_unsigned(value1, 3)) & imm;
			 return result;
		end function;
		
		-- START --
		type mem_vec is array(32767 downto 0) of std_logic_vector(15 downto 0);
		signal mem_vals : mem_vec := (
												0 => op_J(op_LLI, 0, "000000010"),
												1 => op_J(op_LLI, 1, "000000101"),
												2 => op_R(op_MUL, 0, 1, 2),
												others => "1110000000000000"
												);  
begin
	mem_process : process (clk, m_rd, mem_addr) is
	begin
		if m_rd = '1' then
			if unsigned(mem_addr) mod 2 = 0 then
				mem_out <= mem_vals(to_integer(unsigned(mem_addr))/2);
			else
				mem_out(15 downto 8) <= mem_vals((to_integer(unsigned(mem_addr))-1)/2)(7 downto 0);
				mem_out(7 downto 0)  <= mem_vals((to_integer(unsigned(mem_addr))+1)/2)(15 downto 8);
			end if;
		else
			mem_out <= (others => '0');
		end if;
		
		if rising_edge(clk) and m_wr = '1' then
			mem_vals(to_integer(unsigned(mem_addr))) <= mem_in;
			if unsigned(mem_addr) mod 2 = 0 then
				mem_vals(to_integer(unsigned(mem_addr))/2) <= mem_in;
			else
				mem_vals((to_integer(unsigned(mem_addr))-1)/2)(7 downto 0) <= mem_in(15 downto 8);
				mem_vals((to_integer(unsigned(mem_addr))+1)/2)(15 downto 8) <= mem_in(7 downto 0);
			end if;
		end if;
	end process;
end Behavioural;