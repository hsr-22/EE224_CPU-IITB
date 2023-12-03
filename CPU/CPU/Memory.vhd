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
		type mem_vec is array(65535 downto 0) of std_logic_vector(15 downto 0);
		signal mem_vals : mem_vec;  
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