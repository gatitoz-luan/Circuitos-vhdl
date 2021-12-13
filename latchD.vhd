library ieee;
use ieee.std_logic_1164.all;

entity latchD is port (
  C: in std_logic;
  D: in std_logic;
  Q: out std_logic);
end latchD;

architecture behv of latchD is
begin
  process(C, D)
  begin
   if (C = '1') then
       Q <= D;
   end if;
  end process;
end behv;
