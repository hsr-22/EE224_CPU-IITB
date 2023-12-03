library ieee;
use ieee.std_logic_1164.all;

entity CPU is 
	port(clk: in std_logic);
end entity;

architecture iitb_cpu of CPU is
	component datapath is
		port( clk,reset: in std_logic;
				state: in std_logic_vector(3 downto 0);
				z_in: out std_logic);
	end component;
	
	component FSM is 
		port( opcode: in std_logic_vector(3 downto 0);
				z: in std_logic;
				clk: in std_logic;
				output_state: out std_logic_vector(3 downto 0)
				);
	end component;
	
	signal state,opcode,output_state: std_logic_vector(3 downto 0);
	signal reset, z, z_in: std_logic;
	
	begin
		path_of_data: component datapath
			port map(clk, reset, state, z_in);
		
		machine_of_finite_states: component FSM
			port map(opcode, z, clk, output_state);
		
		z <= z_in;
end architecture;