library ieee;

use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Counter_seq is port ( 
  CLK: in std_logic;
  Enable: in std_logic;
  Set: in std_logic;
  tc:out std_logic;
  output: out std_logic_vector(1 downto 0));
end Counter_seq;

architecture behv of Counter_seq is
  signal s_tc: std_logic;
  signal cnt: std_logic_vector(1 downto 0) := "00";

begin
    s_tc <= '1'  when cnt = "11" else '0'; 
    tc <= s_tc;
  process(CLK, Set)
  begin
    if (Set = '1') then
        cnt <= "00";
    elsif (CLK'event and CLK = '1'and Enable = '1' and s_tc = '0') then	
      cnt <= cnt + "01";
    end if;
  end process;
  output <= cnt;
end behv;
