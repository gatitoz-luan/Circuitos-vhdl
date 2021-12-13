library ieee;
use ieee.std_logic_1164.all;

entity flipFlopD is port (
 CLK: in std_logic;
 D: in std_logic;
 Q: out std_logic);
end flipFlopD;

architecture behv of flipFlopD is
begin
  process(CLK)
  begin
    if (CLK'event and CLK = '1') then 
    --if some clock change and clock equal one, then...
      Q <= D;
    end if;
  end process;
end behv;
