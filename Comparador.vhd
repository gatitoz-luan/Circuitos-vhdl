library ieee;
use ieee.std_logic_1164.all;
entity Comparador is port(
    in0, in1: in  std_logic_vector(7 downto 0);
    S       : out std_logic);
end Comparador;
architecture archComparador of Comparador is
begin

    
        -- A <= in0(7) and in1(7);
        -- B <= in0(6) and in1(6);
        -- C <= in0(5) and in1(5);
        -- D <= in0(4) and in1(4);
        -- E <= in0(3) and in1(3);
        -- F <= in0(2) and in1(2);
        -- G <= in0(1) and in1(1);
        -- H <= in0(0) and in1(0);
    
        
        -- S <= A and B and C and D and E and F and G and H;
    S <= '1' when (in0 = in1) else '0';
end archComparador;
