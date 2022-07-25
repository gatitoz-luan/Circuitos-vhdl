library ieee;
use ieee.std_logic_1164.all;
entity registrador16 is port (
	CLK: in std_logic;
	E: in std_logic;
	R: in std_logic;
	D: in std_logic_vector(15 downto 0);
	Q: out std_logic_vector(15 downto 0));
end registrador16;
architecture arch_registrador16 of registrador16 is
begin
	process(CLK, R)
	begin
	    if (R = '1') then
	        Q <= "0000000000000000";
		elsif ((CLK'event and CLK = '1') and (E = '1')) then
            Q <= D;
		end if;
	end process;
end arch_registrador16;
