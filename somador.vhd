library ieee;
use ieee.std_logic_1164.all;

entity somador is
port( A, B: in std_logic_vector(3 downto 0);
      S: out std_logic_vector(4 downto 0) );
end somador;

architecture rtl of somador is

   signal C: std_logic_vector(2 downto 0);

   component halfadder is
   port(A, B: in std_logic;
        S, Cout: out std_logic );
   end component;

begin
  HA: halfadder port map( A => A(0),
                          B => B(0),
                          S => S(0),
                          Cout => C(0));
  FA1: fulladder port map( A => A(1),
                           B => B(1),
                           Cin => C(0),
                           S => S(1),
                           Cout => C(1));
  FA2: fulladder port map ( A => A(2),
                            B => B(2),
                            Cin => C(1),
                            S => S(2),
                            Cout => C(2));
  FA3: fulladder port map ( A => A(3),
                            B => B(3),
                            Cin => C(2),
                            S => S(3),
                            Cout => S(4));

end rtl;