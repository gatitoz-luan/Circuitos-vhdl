library ieee;
use ieee.std_logic_1164.all;

entity halfadder is
port( A,B: in std_logic;
      S,Cout: out std_logic
);
end halfadder;

architecture ha1 of halfadder is
begin
  S <= A xor B;
  Cout <= A and B;
end ha1;