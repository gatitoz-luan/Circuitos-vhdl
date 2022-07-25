library ieee;

use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_signed.all;

entity Counter_time is port ( 
  CLK: in std_logic;
  Enable: in std_logic;
  Set: in std_logic;
  load_step: in std_logic_vector(7 downto 0);
  tc:out std_logic;
  output: out std_logic_vector(7 downto 0));
end Counter_time;

architecture behv of Counter_time is
  signal cnt: std_logic_vector(7 downto 0);

begin
    --mx_time_left <= pisca when end_time_left = '0' else "000000000";
  process(CLK, Set)
  begin
    if (Set = '1') then
        cnt <= "01100011";
    elsif (CLK'event and CLK = '1') then
        if cnt < "00000001" then
            tc <= '1';
            cnt <= "00000000";
    
        elsif (Enable = '1') then
            cnt <= cnt + load_step;
        else 
            tc <= '0';
        end if;
    end if;
  end process;
  output <= cnt;
  tc <= '1'  when cnt = "00000000" else '0'; 
  
end behv;
