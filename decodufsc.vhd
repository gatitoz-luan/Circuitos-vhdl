library IEEE;
use IEEE.Std_Logic_1164.all;

entity decodufsc is
 port (SW: in std_logic_vector(3 downto 0);
       HEX0: out std_logic_vector(6 downto 0));
end decodufsc;

architecture decod of decodufsc is
begin
 HEX0 <=    "1000001" when SW = "0000" else  --U
            "0001110" when SW = "0001" else  --F
            "0010010" when SW = "0010" else  --S
            "1000110" when SW = "0011" else  --C
            "1111111";
end decod;