library IEEE;
use IEEE.Std_Logic_1164.all;

entity exercicio02 is
port (X: in std_logic_vector(7 downto 0);
      HEX0: out std_logic_vector(6 downto 0);
      HEX1: out std_logic_vector(6 downto 0);
      HEX2: out std_logic_vector(6 downto 0));
end exercicio02;

architecture circuito of exercicio02 is
    signal C, D, F, soma: std_logic_vector(11 downto 0);

    component soma8 is
        port (A:  in std_logic_vector(7 downto 0);
              B:  in std_logic_vector(7 downto 0);
              S:  out std_logic_vector(7 downto 0));
    end component;
    
    component div4 is
        port (A:  in std_logic_vector(7 downto 0);
              S:  out std_logic_vector(7 downto 0));
    end component;

    component binbcd is
        port (bin_in: in std_logic_vector (7 downto 0);
              bcd_out: out std_logic_vector (11 downto 0));
    end component;

    component bcd7seg is
        port(bcd_in:  in std_logic_vector(3 downto 0);
             out_7seg:  out std_logic_vector(6 downto 0));
    end component;

begin
    MULT2: soma8 port map(A => X(7 downto 0),
                          B => X(7 downto 0),
                          S => C(7 downto 0));

    DIVI4: div4 port map(A => X(7 downto 0),
                         S => D(7 downto 0));
    
    SOMA2: soma8 port map(A => C(7 downto 0),
                         B => D(7 downto 0),
                         S => soma(7 downto 0));

    BIN_BCD: binbcd port map(bin_in => soma(7 downto 0),
                            bcd_out => F(11 downto 0));

    BCD7SEG1: bcd7seg port map(bcd_in => F(3 downto 0),
                               out_7seg => HEX0(6 downto 0));

    BCD7SEG2: bcd7seg port map(bcd_in => F(7 downto 4),
                               out_7seg => HEX1(6 downto 0));

    BCD7SEG3: bcd7seg port map(bcd_in => F(11 downto 8),
                               out_7seg => HEX2(6 downto 0));


end circuito;