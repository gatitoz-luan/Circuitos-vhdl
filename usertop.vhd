library IEEE;
use IEEE.Std_Logic_1164.all;

entity usertop is
port (SW: in std_logic_vector(3 downto 0);
      LEDR: out std_logic_vector(3 downto 0)
      );
end usertop;

architecture circuito_logico of usertop is
    signal A, B, C, D, Z, Y, X, W: std_logic;
begin

    A <= SW(3);
    B <= SW(2);
    C <= SW(1);
    D <= SW(0);
    
    LEDR(3) <= W;
    LEDR(2) <= X;
    LEDR(1) <= Y;
    LEDR(0) <= Z;

    W <= (not A and C) or (A and not B and not C) or (not A and B) or (C and not D);
    X <= (not A and D) or (not A and C) or (not A and B);
    Y <= (not C and not D);
    Z <= (not A and not B) or (not A and not C and not D);
    
end circuito_logico;