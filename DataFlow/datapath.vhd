library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port( clk,reset: in std_logic;
			state: in std_logic_vector(3 downto 0);
			z_in: out std_logic);
end entity;

architecture path of datapath is

	component Signed_Extender is
		generic (input_size: integer := 6);
		port (input: in std_logic_vector(input_size - 1 downto 0);
				output: out std_logic_vector(15 downto 0));
	end component Signed_Extender;
	
	component Register_N is
		generic (size: integer := 16);
		port (
				input         : in std_logic_vector(size - 1 downto 0);
				w_enable, clk : in std_logic;
				output        : out std_logic_vector(size - 1 downto 0)
				);
	end component Register_N;
	
	component Register_File is
		port (A1, A2, A3: in std_logic_vector(2 downto 0);
				D3: in std_logic_vector(15 downto 0);
				D1, D2: out std_logic_vector(15 downto 0);
				clk, w_enable: in std_logic);
	end component Register_File;

	component Left_Shifter is
		port (input : in std_logic_vector (15 downto 0);
				output : out std_logic_vector (15 downto 0));
	end component Left_Shifter;

	component Decoder_3_To_8 is
		 port (
			  I : in std_logic_vector(2 downto 0);
			  O : out std_logic_vector(7 downto 0));
	end component;

	component Decoder_2_To_4 is
		 port (
			  I : in std_logic_vector(1 downto 0);
			  O : out std_logic_vector(3 downto 0));
	end component;

	component Decoder_1_To_2 is
		 port (
			  I : in std_logic;
			  O : out std_logic_vector(1 downto 0));
	end component;

	component ALU is 
		port (A, B: in std_logic_vector(15 downto 0);
				opcode: in std_logic_vector(2 downto 0);
				C: out std_logic_vector(15 downto 0);
				z_flag: out std_logic);
	end component ALU;
	
	component Memory is 
		port(
				clk, m_wr, m_rd: in std_logic; 
				mem_addr, mem_in: in std_logic_vector(15 downto 0);
				mem_out: out std_logic_vector(15 downto 0)
			 ); 
	end component; 
	
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
	
	signal i_se6: std_logic_vector(5 downto 0);
	signal i_se9: std_logic_vector(8 downto 0);
	signal o_de38: std_logic_vector(7 downto 0);
	signal o_se9,i_ls,o_se6, i_reg16,i_reg16_2,i_reg16_3,i_reg16_4, o_reg16,o_reg16_2,o_reg16_3,o_reg16_4,o_ls,i_rfd3,o_rfd1,o_rfd2,alu_a,alu_b,alu_c,mem_addr,mem_in,mem_out: std_logic_vector(15 downto 0);
	signal i_reg3,o_reg3,i_de38,i_rfa3,i_rfa2,i_rfa1,alu_op: std_logic_vector(2 downto 0);
	signal o_de24: std_logic_vector(3 downto 0);
	signal o_de12,i_de24: std_logic_vector(1 downto 0);
	signal wenable_reg16,wenable_reg16_2,wenable_reg16_3,wenable_reg16_4, wenable_reg3, wenable_rf, i_de12,alu_z,m_rd,m_wr: std_logic;
	
	begin
		
		se6: component Signed_Extender
			port map(i_se6,o_se6);
		
		se9: component Signed_Extender
			generic map(input_size => 9)
			port map(i_se9,o_se9);
		
		reg16_t1: component Register_N
			port map(i_reg16, wenable_reg16, clk, o_reg16);
			
		reg16_t2: component Register_N
			port map(i_reg16_2, wenable_reg16_2, clk, o_reg16_2);
		
		reg16_t3: component Register_N
			port map(i_reg16_3, wenable_reg16_3, clk, o_reg16_3);
			
		reg16_t4: component Register_N
			port map(i_reg16_4, wenable_reg16_4, clk, o_reg16_4);
		
		reg3: component Register_N
			generic map(size=>3)
			port map(i_reg3, wenable_reg3, clk, o_reg3);
		
		dec3to8: component Decoder_3_To_8
			port map(i_de38,o_de38);
			
		dec2to4: component Decoder_2_To_4
			port map(i_de24,o_de24);
		
		dec1to2: component Decoder_1_To_2
			port map(i_de12,o_de12);
			
		leftshift: component Left_Shifter
			port map(i_ls,o_ls);
			
		rf: component Register_File
			port map(i_rfa1,i_rfa2,i_rfa3, i_rfd3, o_rfd1,o_rfd2,clk,wenable_rf);
			
		alucomp: component ALU
			port map(alu_a,alu_b,alu_op,alu_c,alu_z);
		
		mem: component Memory
			port map(clk, m_wr, m_rd, mem_addr, mem_in, mem_out);
		
		datapath_process: process(state)
		begin
			i_se6 <= (others => '0');
			i_ls <= (others => '0');
			i_rfd3 <= (others => '0');
			i_reg16 <= (others => '0');
			alu_a <= (others => '0');
			alu_b <= (others => '0');
			i_reg3 <= (others => '0');
			i_de38 <= (others => '0');
			i_rfa3 <= (others => '0');
			i_rfa2 <= (others => '0');
			i_rfa1 <= (others => '0');
			i_de24 <= (others => '0');
			i_de12 <= '0';
			i_se9 <= (others => '0');
			
			case state is
				when s0 =>
					i_rfa1 <= "111";
					mem_addr <= o_rfd1;
					i_reg16 <= mem_out;
					alu_a <= o_rfd1;
					alu_b <= "0000000000000010";
					i_rfd3 <= alu_c;
					i_rfa3 <= "111";
					
					wenable_rf <= '1';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '0';
					m_rd <= '1';
					m_wr <= '0';
					alu_op <= "000";
				
				when s1 =>
					i_rfa1 <= o_reg16(11 downto 9);
					i_rfa2 <= o_reg16(8 downto 6);
					i_reg16_2 <= o_rfd1;
					i_reg16_3 <= o_rfd2;
					
					wenable_rf <= '0';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '1';
					wenable_reg16_3 <= '1';
					wenable_reg16_4 <= '0';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
				
				when s2 =>
					alu_a <= o_reg16_2;
					alu_b <= o_reg16_3;
					i_reg16_4 <= alu_c;
					i_reg3 <= o_reg16(5 downto 3);
					
					wenable_rf <= '0';
					wenable_reg3 <= '1';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '1';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= o_reg16(14 downto 12);
				
				when s3 =>
					i_rfa3 <= o_reg16(5 downto 3);
					i_rfd3 <= o_reg16_4;
			
					wenable_rf <= '1';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '0';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
				
				when s4 =>
					i_se6 <= o_reg16(5 downto 0);
					alu_b <= o_se6;
					alu_a <= o_reg16_2;
					i_reg16_4 <= alu_c;
					i_reg3 <= o_reg16(8 downto 6);
					
					wenable_rf <= '0';
					wenable_reg3 <= '1';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '1';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
				
				when s5 =>
					alu_b <= o_reg16_3;
					i_se6 <= o_reg16(5 downto 0);
					alu_a <= o_se6;
					i_reg16_4 <= alu_c;
					
					wenable_rf <= '0';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '1';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
					
				when s6 =>
					mem_addr <= o_reg16_4;
					i_reg16_4 <= mem_out;
					i_reg3 <= o_reg16(11 downto 9);
					
					wenable_rf <= '0';
					wenable_reg3 <= '1';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '1';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
					
				when s7 =>
					mem_addr <= o_reg16_4;
					mem_in <= o_reg16_2;
					
					wenable_rf <= '0';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '0';
					m_rd <= '0';
					m_wr <= '1';
					alu_op <= "000";
				
				when s8 =>
					alu_a <= o_reg16_2;
					alu_b <= o_reg16_3;
					i_reg16_4 <= alu_c;
					z_in <= alu_z;
					i_reg3 <= o_reg16(5 downto 3);
					
					wenable_rf <= '0';
					wenable_reg3 <= '1';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '1';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "001";
				
				when s9 =>
					i_rfa1 <= "111";
					alu_a <= o_rfd1;
					i_se6 <= o_reg16(5 downto 0);
					i_ls <= o_se6;
					alu_b <= o_ls;
					i_rfd3 <= alu_c;
					i_rfa3 <= "111";
					
					wenable_rf <= '1';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '0';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
				
				when s10 =>
					i_rfa1 <= "111";
					i_rfa3 <= o_reg16(11 downto 9);
					i_rfd3 <= o_rfd1;
					
					wenable_rf <= '1';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '0';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
				
				when s11 =>
					i_rfa2 <= o_reg16(8 downto 6);
					i_rfd3 <= o_rfd2;
					i_rfa1 <= "111";
					i_rfa3 <= "111";
					
					wenable_rf <= '1';
					wenable_reg3 <= '0';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '0';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
					
				when s12 =>
					i_se9 <= o_reg16(8 downto 0);
					i_ls <= o_se9;
					i_reg16_4 <= o_ls;
					i_reg3 <= o_reg16(11 downto 9);
					
					wenable_rf <= '0';
					wenable_reg3 <= '1';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '1';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
					
				when s13 =>
					i_se9 <= o_reg16(8 downto 0);
					i_reg16_4 <= o_se9;
					i_reg3 <= o_reg16(11 downto 9);
					
					wenable_rf <= '0';
					wenable_reg3 <= '1';
					wenable_reg16 <= '0';
					wenable_reg16_2 <= '0';
					wenable_reg16_3 <= '0';
					wenable_reg16_4 <= '1';
					m_rd <= '0';
					m_wr <= '0';
					alu_op <= "000";
					
				when others =>
					alu_op <= "000";
			end case;
		end process;
end architecture path;
		
		
		
		
		