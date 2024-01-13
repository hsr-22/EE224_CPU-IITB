library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity FSM is 
	port( opcode: in std_logic_vector(3 downto 0);
			z: in std_logic;
			clk: in std_logic;
			output_state: out std_logic_vector(3 downto 0)
		 	);
end entity;

architecture control of FSM is
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
	
	--Represents id for each state we we using
	constant s0  : std_logic_vector(3 downto 0):= "0000";
	constant s1  : std_logic_vector(3 downto 0):= "0001";  
	constant s2  : std_logic_vector(3 downto 0):= "0010";
	constant s3  : std_logic_vector(3 downto 0):= "0011";
	constant s4  : std_logic_vector(3 downto 0):= "0100";
	constant s5  : std_logic_vector(3 downto 0):= "0101";
	constant s6  : std_logic_vector(3 downto 0):= "0110";
	constant s7  : std_logic_vector(3 downto 0):= "0111";
	constant s8  : std_logic_vector(3 downto 0):= "1000";
	constant s9  : std_logic_vector(3 downto 0):= "1001";  
	constant s10 : std_logic_vector(3 downto 0):= "1010";
	constant s11 : std_logic_vector(3 downto 0):= "1011";
	constant s12 : std_logic_vector(3 downto 0):= "1100";
	constant s13 : std_logic_vector(3 downto 0):= "1101";
	constant s14 : std_logic_vector(3 downto 0):= "1110";
	constant s15 : std_logic_vector(3 downto 0):= "1111";

	--Signals which represent present and next state id
	signal y_present: std_logic_vector(3 downto 0) := s0;
	signal y_next: std_logic_vector(3 downto 0) := s0;

begin
	output_state <= y_present;
		
	on_clk: process(clk)
	begin
		if(rising_edge(clk)) then
			y_present <= y_next;
		end if;	
	end process;
 
	next_state: process(y_present,opcode)
   begin
		case y_present is
			when s0=>
				case opcode is
					when op_LHI =>
						y_next <= s9;    	    
					when op_LLI =>
						y_next<= s10;
					when op_JAL =>
						y_next <= s11;
					when op_JLR =>
						y_next <= s13;
					when others =>
						y_next <= s1;
				end case;
				
			when s1=>
				case opcode is
					when op_ADD|op_SUB|op_MUL|op_AND|op_ORA|op_IMP =>	
						y_next<=s2;
					when op_ADI =>
						y_next<=s5;
					when op_BEQ =>
						y_next<=s14;
					when op_LW | op_SW =>
						y_next<=s6;
					when others =>
						y_next<=s0;
				end case;			
				
			when s2=>
				y_next<=s3;

				
			when s3=>
				case opcode is
					when op_JAL | op_JLR | op_BEQ | op_SW =>
						y_next<=s0;
					when op_LW =>
						y_next <= s7;
					when others =>
						y_next<=s4;
				end case;	
				
			when s4=>
				case opcode is
					when op_JAL | op_JLR | op_BEQ =>
						y_next<=s3;
					when others =>
						y_next<=s0;
				end case;	
				
			when s5=>
				y_next<=s3;
				
			when s6=>
				case opcode is
					when op_LW =>
						y_next<=s3;
					when others =>
						y_next<=s8;
				end case;	
				
			when s7=>
				y_next<=s0;
				
			when s8=>
				y_next<=s3;
			
			when s9=>
				y_next<=s3;
				
			when s10=>
				y_next<=s3;
				
			when s11=>
				y_next<=s12;
				
			when s12=>
				case opcode is
					when op_BEQ =>
						y_next<=s3;
					when others =>
						y_next<=s4;
				end case;	
				
			when s13=> 
				y_next<=s4;
				
			when s14=> 
				case opcode is 
					when op_BEQ =>
						if (z = '1') then
							y_next<=s15;
						else
							y_next<=s0;
						end if;
					when others =>
						y_next<=s0;
				end case;
				
			when s15=> 
				y_next<=s12;
				
			when others=>
				y_next<=s0;
				
		end case;
	end process;
end architecture;