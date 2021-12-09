library IEEE;
use IEEE.Std_Logic_1164.all;

entity principal is
    port (X: in std_logic_vector(7 downto 0);
          HEX0, HEX1, HEX2: out std_logic_vector(6 downto 0);
          sel: in std_logic);
end principal;

architecture weightconv of principal is
    signal DOBRO, UMQUARTO, LIBRAS, BCDNUM: std_logic_vector(11 downto 0);
    signal lbsBCD, kgBCD: std_logic_vector(11 downto 0);
    signal lbs0, lbs1, lbs2, kg0, kg1, kg2: std_logic_vector(6 downto 0);

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
                              S => LIBRAS(7 downto 0));
    
    -- Formate meu visor em libras
    lbsbinarioparabcd: binbcd port map(bin_in => LIBRAS(7 downto 0),
                                    bcd_out => lbsBCD(11 downto 0));
                                    
    lbsVISORHEX0: bcd7seg port map(bcd_in => lbsBCD(3 downto 0),
                                out_7seg => lbs0(6 downto 0));
                                
    lbsVISORHEX1: bcd7seg port map(bcd_in => lbsBCD(7 downto 4),
                               out_7seg => lbs1(6 downto 0));

    lbsVISORHEX2: bcd7seg port map(bcd_in => lbsBCD(11 downto 8),
                                   out_7seg => lbs2(6 downto 0));

    -- Formate meu visor em binário
    kgbinarioparabcd: binbcd port map(bin_in => X(7 downto 0),
                                    bcd_out => kgBCD(11 downto 0));
                                    
    kgVISORHEX0: bcd7seg port map(bcd_in => kgBCD(3 downto 0),
                                out_7seg => kg0(6 downto 0));
                                
    kgVISORHEX1: bcd7seg port map(bcd_in => kgBCD(7 downto 4),
                               out_7seg => kg1(6 downto 0));

    kgVISORHEX2: bcd7seg port map(bcd_in => kgBCD(11 downto 8),
                                   out_7seg => kg2(6 downto 0));

    HEX0 <= lbs0 when sel = '1' else kg0;
    HEX1 <= lbs1 when sel = '1' else kg1;
    HEX2 <= lbs2 when sel = '1' else kg2;

end weightconv;