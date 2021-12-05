library ieee;
use ieee.std_logic_1164.all;

entity fulladder is
port ( A,B, Cin: in std_logic;
       S, Cout: out std_logic
     );
end fulladder;

architecture fa1 of fulladder is
begin
  S <= (A xor B) xor (Cin);
  Cout <= ((A xor B) and Cin) or (A and B);
end fa1;