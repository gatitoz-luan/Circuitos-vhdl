-- remember name to usertest 
library ieee;
use ieee.std_logic_1164.all;

entity usertest is
end usertest;

architecture tb of usertest is
  signal A, B, Sum, Cout: std_logic;
  component halfadder is port (
   A, B: in std_logic;
   Sum, Cout: out std_logic);
  end component;
begin
  DUT: halfadder port map (A => A,
                           B => B,
                           Sum => Sum,
                           Cout => Cout);
 process
   constant period: time := 10 ns;
   begin
   A <= '0'; B <= '0';
   wait for period;
   assert ((Sum = '0') and (Cout = '0'))
   report "Failed for 00." severity error;
   A <= '0'; B <= '1';
   wait for period;
   assert ((Sum = '1') and (Cout = '0'))
   report "Failed for 01." severity error;
   A <= '1'; B <= '0';
   wait for period;
   assert ((Sum = '1') and (Cout = '0'))
   report "Failed for 10." severity error;
   A <= '1'; B <= '1';
   wait for period;
   assert ((Sum = '0') and (Cout = '1'))
   report "Failed for 11." severity error;
   wait;
 end process;
end tb;