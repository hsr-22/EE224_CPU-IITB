library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port( clk,reset: in std_logic;
			state: in std_logic_vector(3 downto 0);
			opcode_out: out std_logic_vector(3 downto 0);
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
	
	component Left_Shifter_2Mul is
		port (input : in std_logic_vector (15 downto 0);
				output : out std_logic_vector (15 downto 0));
	end component Left_Shifter_2Mul;

--	component Decoder_3_To_8 is
--		 port (
--			  I : in std_logic_vector(2 downto 0);
--			  O : out std_logic_vector(7 downto 0));
--	end component;
--
--	component Decoder_2_To_4 is
--		 port (
--			  I : in std_logic_vector(1 downto 0);
--			  O : out std_logic_vector(3 downto 0));
--	end component;
--
--	component Decoder_1_To_2 is
--		 port (
--			  I : in std_logic;
--			  O : out std_logic_vector(1 downto 0));
--	end component;

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
	constant s14 : std_logic_vector(3 downto 0):= "1110";
	constant s15 : std_logic_vector(3 downto 0):= "1111";

	-- ALU
	signal alu_a,alu_b,alu_c: std_logic_vector(15 downto 0);
	signal alu_op: std_logic_vector(2 downto 0);
	signal alu_fz: std_logic;

	-- Memory
	signal mem_addr,mem_in,mem_out: std_logic_vector(15 downto 0);
	signal m_rd, m_wr: std_logic;

	-- Register File
	signal i_rfa1,i_rfa2,i_rfa3: std_logic_vector(2 downto 0);
	signal o_rfd1,o_rfd2,i_rfd3: std_logic_vector(15 downto 0);
	signal wenable_rf: std_logic;

	-- Temporary Registers
	signal wenable_ir,wenable_rega,wenable_regb,wenable_regc,wenable_reg_pc,wenable_reg3: std_logic;
	signal i_reg3,o_reg3: std_logic_vector(2 downto 0);
	signal i_ir,i_rega,i_regb,i_regc,i_reg_pc,o_ir,o_rega,o_regb,o_regc,o_reg_pc: std_logic_vector(15 downto 0);
	
	-- Sign Extenders	
	signal i_se6: std_logic_vector(5 downto 0);
	signal i_se9: std_logic_vector(8 downto 0);
	signal o_se6,o_se9 : std_logic_vector(15 downto 0);

	-- Left Shifter
	signal i_ls1,o_ls1,i_ls8,o_ls8: std_logic_vector(15 downto 0);

	begin
		
		se6: component Signed_Extender
			port map(i_se6,o_se6);
		
		se9: component Signed_Extender
			generic map(input_size => 9)
			port map(i_se9,o_se9);
		
		reg16_ir: component Register_N
			port map(i_ir, wenable_ir, clk, o_ir);
			
		reg16_a: component Register_N
			port map(i_rega, wenable_rega, clk, o_rega);
		
		reg16_b: component Register_N
			port map(i_regb, wenable_regb, clk, o_regb);
			
		reg16_c: component Register_N
			port map(i_regc, wenable_regc, clk, o_regc);
			
		reg16_pc: component Register_N
			port map(i_reg_pc, wenable_reg_pc, clk, o_reg_pc);
		
		reg3: component Register_N
			generic map(size=>3)
			port map(i_reg3, wenable_reg3, clk, o_reg3);
		
		leftshift8: component Left_Shifter
			port map(i_ls8,o_ls8);
			
		leftshift1: component Left_Shifter_2Mul
			port map(i_ls1,o_ls1);
			
		rf: component Register_File
			port map(i_rfa1,i_rfa2,i_rfa3, i_rfd3, o_rfd1, o_rfd2,clk,wenable_rf);
			
		alucomp: component ALU
			port map(alu_a,alu_b,alu_op,alu_c,alu_fz);
		
		mem: component Memory
			port map(clk, m_wr, m_rd, mem_addr, mem_in, mem_out);
			
		opcode_out <= o_ir(15 downto 12) when state /= s0 else mem_out(15 downto 12);
		z_in <= alu_fz;
		
		datapath_process: process(state,o_rfd1,o_rfd2,mem_out,alu_c,alu_fz,o_ir,o_rega,o_regb,o_regc,o_reg_pc,o_reg3,o_se6,o_se9,o_ls8,o_ls1)
		begin
			i_se6 <= (others => '0');
			i_se9 <= (others => '0');
			
			i_rfa3 <= (others => '0');
			i_rfa2 <= (others => '0');
			i_rfa1 <= (others => '0');
			i_rfd3 <= (others => '0');
			
			i_ls8 <= (others => '0');
			i_ls1 <= (others => '0');
			
			alu_a <= (others => '0');
			alu_b <= (others => '0');

			i_ir <= (others => '0');
			i_rega <= (others => '0');
			i_regb <= (others => '0');
			i_regc <= (others => '0');
			i_reg_pc <= (others => '0');
			i_reg3 <= (others => '0');
			
			-- Flags
			alu_op <= (others => '0');
			
			wenable_rf <= '0';
			wenable_ir <= '0';
			wenable_rega <= '0';
			wenable_regb <= '0';
			wenable_regc <= '0';
			wenable_reg_pc <= '0';
			wenable_reg3 <= '0';
			
			m_rd <= '0';
			m_wr <= '0';
			
			case state is
				when s0 =>
					i_rfa1 <= "111";
					mem_addr <= o_rfd1;
					i_ir <= mem_out;
					alu_a <= o_rfd1;
					alu_b <= "0000000000000001";
					i_reg_pc <= alu_c;
					
					wenable_ir <= '1';
					m_rd <= '1';
					wenable_reg_pc <= '1';
					alu_op <= "000";
				
				when s1 =>
					i_rfa1 <= o_ir(11 downto 9);
					i_rfa2 <= o_ir(8 downto 6);
					i_rega <= o_rfd1;
					i_regb <= o_rfd2;
					
					wenable_rega <= '1';
					wenable_regb <= '1';
				
				when s2 =>
					alu_a <= o_rega;
					alu_b <= o_regb;
					i_regc <= alu_c;
					i_reg3 <= o_ir(5 downto 3);
					
					wenable_reg3 <= '1';
					wenable_regc <= '1';
					alu_op <= o_ir(14 downto 12);
				
				when s3 =>
					i_rfa3 <= "111";
					i_rfd3 <= o_reg_pc;
			
					wenable_rf <= '1';
					
				when s4 =>
					i_rfa3 <= o_reg3;
					i_rfd3 <= o_regc;
			
					wenable_rf <= '1';
				
				when s5 =>
					i_se6 <= o_ir(5 downto 0);
					alu_b <= o_se6;
					alu_a <= o_rega;
					i_regc <= alu_c;
					i_reg3 <= o_ir(8 downto 6);
					
					wenable_reg3 <= '1';
					wenable_regc <= '1';
					alu_op <= "000";
				
				when s6 =>
					alu_b <= o_regb;
					i_se6 <= o_ir(5 downto 0);
					alu_a <= o_se6;
					i_regc <= alu_c;
					
					wenable_regc <= '1';
					alu_op <= "000";
					
				when s7 =>
					i_rfa3 <= o_ir(11 downto 9);
					mem_addr <= o_regc;
					i_rfd3 <= mem_out;
					
					wenable_rf <= '1';
					m_rd <= '1';
					
				when s8 =>
					mem_addr <= o_regc;
					mem_in <= o_rega;
					
					m_wr <= '1';
				
				when s9 =>
					i_se9 <= o_ir(8 downto 0);
					i_ls8 <= o_se9;
					i_regc <= o_ls8;
					i_reg3 <= o_ir(11 downto 9);
					
					wenable_reg3 <= '1';
					wenable_regc <= '1';
					
				when s10 =>
					i_se9 <= o_ir(8 downto 0);
					i_regc <= o_se9;
					i_reg3 <= o_ir(11 downto 9);
					
					wenable_reg3 <= '1';
					wenable_regc <= '1';
					
				when s11 =>
					i_se9 <= o_ir(8 downto 0);
					i_ls1 <= o_se9;
					i_regc <= o_ls1;
					
					wenable_regc <= '1';
					
				when s12 =>
					i_rfa1 <= "111";
					alu_a <= o_rfd1;
					alu_b <= o_regc;
					i_reg_pc <= alu_c;
					i_regc <= o_rfd1;
					i_reg3 <= o_ir(11 downto 9);
					
					wenable_reg_pc <= '1';
					wenable_regc <= '1';
					wenable_reg3 <= '1';
					alu_op <= "000";
					
				when s13 =>
					i_rfa2 <= o_ir(8 downto 6);
					i_reg_pc <= o_rfd2;
					i_reg3 <= o_ir(11 downto 9);
					
					wenable_reg_pc <= '1';
					wenable_reg3 <= '1';
					
				when s14 =>
					alu_a <= o_rega;
					alu_b <= o_regb;
					
					alu_op <= "010"; -- Sub
					
				when s15 =>
					i_se6 <= o_ir(5 downto 0);
					i_ls1 <= o_se6;
					i_regc <= o_ls1;
					
					wenable_regc <= '1';
					
				when others =>
					alu_op <= "000";
			end case;
		end process;
end architecture path;
		
		
		
		
		