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
		type mem_vec is array(65535 downto 0) of std_logic_vector(15 downto 0);
		signal mem_vals : mem_vec := (
												 0  => op_J(op_LLI, 0, "000000010"), 		-- Load 2 into Reg0
												 1  => op_J(op_LLI, 1, "000000101"),				-- Load 5 into Reg1
												 2  => op_R(op_ADD, 0, 1, 2),	-- Load r0+r1 into Reg2 = 7
												 3  => op_R(op_SUB, 0, 1, 3),	-- Load r0-r1 into Reg3 = -3
												 4  => op_R(op_MUL, 0, 1, 4),	-- Load r0*r1 into Reg4 = 10
												 5  => op_I(op_ADI, 2, 2 , "000011"),	   -- Load r2+(3) into Reg2 = 10
												 6  => op_I(op_JLR, 6, 4 , "000000"),		-- Jump to addr in Reg4 (10), Store in Reg6
												 8  => op_I(op_BEQ, 2, 4 , "000010"),		-- IF Reg4 = Reg2: Jump to PC(8)+(2)*2 
												 10 => op_J(op_JAL, 6, "111111111"),				-- Jump to PC(10)+(-1)*2 = 8, Store in Reg6
												 12 => op_R(op_ORA, 1, 2, 2),	-- Load (r1 or r2) into Reg2 = 15
												 13 => op_R(op_AND, 1, 2, 2),	-- Load (r1 and r2) into Reg2 = 5
												 14 => op_J(op_LHI, 5, "001010101"),           -- Load 0101010100000000 (21760) into Reg5
												 15 => op_I(op_LW, 6, 1 , "011001"),		-- Load data at Reg1(5)+25 = memo30 (13621) into Reg6
												 16 => op_R(op_IMP, 5, 6, 0), -- Load r5->r6 (-16385) into Reg0
												 17 => op_I(op_SW, 0, 1 , "011000"),	 	-- Store r0 at Reg1(5)+24 = memo29
												 30 => "0011010100110101",
												others => "0111000000000000"
												);  
begin
	mem_process : process (clk, m_rd, mem_addr) is
	begin
		if m_rd = '1' then
			mem_out <= mem_vals(to_integer(unsigned(mem_addr)));
		else
			mem_out <= (others => '0');
		end if;
		
		if rising_edge(clk) and m_wr = '1' then
			mem_vals(to_integer(unsigned(mem_addr))) <= mem_in;
		end if;
	end process;
end Behavioural;