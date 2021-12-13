library ieee;
use ieee.std_logic_1164.all;

entity Sinais is port (
  C: in std_logic;
  D: in std_logic;
  Q: out std_logic);
end Sinais;

architecture behv of Sinais is
 signal A, B: std_logic;
begin
 A <= D;
 Q <= B;

 P1: process(C, D) --sensitivity list
 begin
  B <= '0';
  if (C = '1') then
    B <= D;
  end if;
 end process P1;
end behv;