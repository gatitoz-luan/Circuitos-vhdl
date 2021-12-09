library IEEE;
use IEEE.Std_Logic_1164.all;

entity principal is
    port (X: in std_logic_vector(7 downto 0);
          HEX0, HEX1, HEX2: out std_logic_vector(6 downto 0));
end principal;

architecture weightconv of principal is
    signal DOBRO, UMQUARTO, EXPRESSAORESULT, BCDNUM: std_logic_vector(11 downto 0);
    
    component soma8 is
        port(A: in std_logic_vector(7 downto 0);
             B: in std_logic_vector(7 downto 0);
             S: out std_logic_vector(7 downto 0));
    end component;

    component div4 is
        port(A:  in std_logic_vector(7 downto 0);
             S:  out std_logic_vector(7 downto 0));
    end component;
    
    component binbcd is
        port(bin_in: in std_logic_vector (7 downto 0);
             bcd_out: out std_logic_vector (11 downto 0));
    end component;

    component bcd7seg is
        port(bcd_in:  in std_logic_vector(3 downto 0);
             out_7seg:  out std_logic_vector(6 downto 0));
    end component;
    
begin
    multiplicacao2: soma8 port map(A => X(7 downto 0),
                                   B => X(7 downto 0),
                                   S => DOBRO(7 downto 0));
    
    divisaopor4: div4 port map(A => X(7 downto 0),
                               S => UMQUARTO(7 downto 0));
    
    somatotal: soma8 port map(A => DOBRO(7 downto 0),
                              B => UMQUARTO(7 downto 0),
                              S => EXPRESSAORESULT(7 downto 0));
                              
    binarioparabcd: binbcd port map(bin_in => EXPRESSAORESULT(7 downto 0),
                                    bcd_out => BCDNUM(11 downto 0));
                                    
    VISORHEX0: bcd7seg port map(bcd_in => BCDNUM(3 downto 0),
                                out_7seg => HEX0(6 downto 0));
                                
    VISORHEX1: bcd7seg port map(bcd_in => BCDNUM(7 downto 4),
                               out_7seg => HEX1(6 downto 0));

    VISORHEX2: bcd7seg port map(bcd_in => BCDNUM(11 downto 8),
                                out_7seg => HEX2(6 downto 0));

end weightconv;