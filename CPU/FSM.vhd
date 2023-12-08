library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity FSM is 
	port( 		opcode: in std_logic_vector(3 downto 0);
			z: in std_logic;
			clk: in std_logic;
			output_state: out std_logic_vector(3 downto 0)
		 	);
end entity;

architecture control of FSM is

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

--Signals which represent present and next state id
signal y_present: std_logic_vector(3 downto 0) :=s0;
signal y_next: std_logic_vector(3 downto 0) :=s0;

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
					when "1000" =>		--lhi
						y_next<=s12;
					when "1001" =>          --lli
						y_next<=s13;
					when "1101" =>		--jal
						y_next<=s9;    	    
					when "1111" =>   	--jlr
						y_next<=s10;   
					when others =>
						y_next<=s1;
				end case;
				
			when s1=>
				case opcode is
					when "0000" | "0010" | "0011" | "0100" | "0101" | "0110" =>  	--add/sub/mul/and/ora/imp	
						y_next<=s2;
					when "0001" => --adi
						y_next<=s4;
					when "1100" => --beq
						y_next<=s8;
					when "1010" | "1011" => --lw/sw
						y_next<=s5;
					when others =>
						y_next<=s0;
				end case;			
				
			when s2=>
				case opcode is
					when "0000" | "0010" | "0011" | "0100" | "0101" | "0110" =>       --add/sub/mul/and/ora/imp
						y_next<=s3;
					when others =>
						y_next <= s0;
				end case;
				
			when s3=> --last
				y_next<=s0;
				
			when s4=> --adi
				y_next<=s3;
				
			when s5=>
				case opcode is
					when "1010" =>  --lw
						y_next<=s6;
					when "1011" =>  --sw
						y_next<=s7;
					when others =>
						y_next<=s0;
				end case;
				
			when s6=> --lw
				y_next<=s3;
				
			when s7=> --last
				y_next<=s0;
				
			when s8=> 
				case opcode is 
					when "1100" => --beq
						if (z = '1') then
							y_next<=s9;
						else
							y_next<=s0;
						end if;
					when others =>
						y_next<=s0;
				end case;

			when s9=> 
				if (opcode="1101") then --jal
					y_next<=s10;
				else 
					y_next<=s0;
				end if;
				
			when s10=>
				if (opcode="1111") then --jlr
					y_next<=s11;
				else 
					y_next<=s0;
				end if;
				
			when s11=> --last
				y_next<=s0;
				
			when s12=> --lhi
				y_next<=s3;
				
			when s13=> 
				y_next<=s3;
				
			when others=>
				y_next<=s0;
				
end case;
end process;
end architecture;