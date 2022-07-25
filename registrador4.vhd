library ieee;
use ieee.std_logic_1164.all;
entity registrador4 is port (
	CLK: in std_logic;
	E: in std_logic;
	R: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0));
end registrador4;
architecture arch_registrador4 of registrador4 is
begin
	process(CLK, R)
	begin
	    if (R = '1') then
	        Q <= "0000";
		elsif ((CLK'event and CLK = '1') and (E = '1')) then
            Q <= D;
		end if;
	end process;
end arch_registrador4;
