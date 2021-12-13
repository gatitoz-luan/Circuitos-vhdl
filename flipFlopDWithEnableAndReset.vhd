--revisar
library ieee;
use ieee.std_logic_1164.all;

entity flipFlopDWithEnableAndReset is port (
  CLK: in std_logic;
  EN: in std_logic;
  RST: in std_logic;
  D: in std_logic;
  Q: out std_logic);
end flipFlopDWithEnableAndReset;

architecture behv of flipFlopDWithEnableAndReset is
begin
  process(CLK, RST)
  begin
    if (RST = '0') then
     Q <= '0';
    elsif (CLK'event and CLK = '1') then
      if (EN = '1') then
       Q <= D;
      end if;
    end if;
  end process;
end behv;
