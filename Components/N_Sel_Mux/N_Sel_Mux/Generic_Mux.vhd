library ieee;
use ieee.std_logic_1164.all;

package mux_p is
  type slv_array_t is array (natural range <>) of std_logic_vector(15 downto 0);
end package;

package body mux_p is
end package body;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mux_p;

entity N_Sel_Mux is
  generic(
    NUM : natural := 4);  -- Number of inputs, must be a pow of 2
  port(
    inputs : in  mux_p.slv_array_t(0 to 2**NUM - 1);
    sel    : in  std_logic_vector(NUM - 1 downto 0);
    output : out std_logic_vector(15 downto 0));
end entity;

architecture syn of N_Sel_Mux is
begin
  output <= inputs(to_integer(unsigned(sel)));
end architecture;