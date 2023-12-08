library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;

architecture Behavioural of Testbench is
  component CPU is
    	port(clk: in std_logic; rst: in std_logic);
  end component;

  signal clk : std_logic := '1';
  
  constant CLOCK_PERIOD : time := 10 ns;
begin
  CPU_instance: CPU port map(clk => clk, rst => '0');

  clk_process: process
  begin
    while now < CLOCK_PERIOD * 100 loop
      clk <= not clk;
      wait for CLOCK_PERIOD / 2;
    end loop;
    wait;
  end process;
end;
