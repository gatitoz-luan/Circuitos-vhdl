library IEEE;
use IEEE.Std_Logic_1164.all;

entity decodUFSC is
 port (C: in std_logic_vector(3 downto 0);
       F: out std_logic_vector(6 downto 0));
end decodUFSC;

architecture decod of decodUFSC is
begin
 F <= "1000001" when C = "0000" else  --U
      "0001110" when C = "0001" else  --F
      "0010010" when C = "0010" else  --S
      "1000110" when C = "0011" else  --C
      "1111111";
end decod;