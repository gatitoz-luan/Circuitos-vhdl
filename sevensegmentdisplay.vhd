library IEEE;
use IEEE.Std_Logic_1164.all;

entity sevensegmentdisplay is
 port (SW: in std_logic_vector(3 downto 0);
       HEX0: out std_logic_vector(6 downto 0));
end sevensegmentdisplay;

architecture decod of sevensegmentdisplay is
begin
 HEX0 <=    "0000000" when SW = "0000" else  --0
            "1111001" when SW = "0001" else  --1
            "0100100" when SW = "0010" else  --2
            "0110000" when SW = "0011" else  --3
            "0011001" when SW = "0100" else  --4
            "0010010" when SW = "0101" else  --5
            "0000010" when SW = "0110" else  --6
            "1111000" when SW = "0111" else  --7
            "0000000" when SW = "1000" else  --8
            "0010000" when SW = "1001" else  --9
            "0001000" when SW = "1010" else  --A
            "0000011" when SW = "1011" else  --b
            "0100111" when SW = "1100" else  --C
            "0100001" when SW = "1101" else  --d
            "0000110" when SW = "1110" else  --e
            "0001110" when SW = "1111" else  --f
            "1111111";
end decod;