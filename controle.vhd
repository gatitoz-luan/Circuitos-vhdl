library ieee;

use ieee.std_logic_1164.all;
entity controle is port (
   CLK: in std_logic;
   enter, reset: in std_logic;
   R1, E1, E2, E3, E4, E5, E6: out std_logic;
   end_game, end_sequence, end_round, enter_left, enter_right: in std_logic
   );

end controle;

architecture controle_arq of controle is
    -- Estados
   type STATES is (st_init, st_setup, st_sequence, st_play, st_check, st_wait, st_result);
   signal EAtual, PEstado: STATES;


begin

    -- Register
	REG: process(CLK,reset)
	begin
	    if (reset = '1') then
			EAtual <= st_init;
        elsif (CLK'event AND CLK = '1') then -- Activates in the upper clock 
         	EAtual <= PEstado;
	    end if;
	end process;
	-- Logic
    COMB: process(EAtual, reset, enter, end_sequence, enter_left, enter_right, end_game, end_round)
	begin
		case EAtual is
			when st_init => PEstado <= st_setup;
                            R1 <= '1';
                            E1 <= '0';
                            E2 <= '0';
                            E3 <= '0';
                            E4 <= '0';
                            E5 <= '0';
                            E6 <= '0';
            when st_setup => 	if (enter = '1') then
                        			PEstado <= st_sequence;
                                else  
                                 	PEstado <= st_setup;
                        	    end if;
                         		R1 <= '0';
                                E1 <= '1';
                                E2 <= '0';
                                E3 <= '0';
                                E4 <= '0';
                                E5 <= '0';
                                E6 <= '0';
            when st_sequence => if (end_sequence = '1') then
                                    PEstado <= st_play;
                                else
                                    PEstado <= st_sequence;
                         		end if;
                         		R1 <= '0';
                                E1 <= '0';
                                E2 <= '1';
                                E3 <= '0';
                                E4 <= '0';
                                E5 <= '0';
                                E6 <= '0';
            when st_play => 	if ((enter_left and enter_right) = '1') then
                        			PEstado <= st_check;
                                else 
                                    PEstado <= st_play;
                        	    end if;
                         		R1 <= '0';
                                E1 <= '0';
                                E2 <= '0';
                                E3 <= '1';
                                E4 <= '0';
                                E5 <= '0';
                                E6 <= '0';
                         		
            when st_check =>    PEstado <= st_wait;
                                R1 <= '0';
                                E1 <= '0';
                                E2 <= '0';
                                E3 <= '0';
                                E4 <= '1';
                                E5 <= '0';
                                E6 <= '0';
                                
            when st_wait  => 	if ((enter) = '1') then 
                                    if ((end_round or end_game) = '1') then
                            			PEstado <= st_result;
                                    else
                                        PEstado <= st_sequence;
                            	    end if;
                            	else
                            	    PEstado <= st_wait;
                            	end if;
                         		R1 <= '0';
                                E1 <= '0';
                                E2 <= '0';
                                E3 <= '0';
                                E4 <= '0';
                                E5 <= '1';
                                E6 <= '0';
            when st_result => 	if (enter = '1') then
                        			PEstado <= st_init;
                                else
                                    PEstado <= st_result;
                        	    end if;
                         		R1 <= '0';
                                E1 <= '0';
                                E2 <= '0';
                                E3 <= '0';
                                E4 <= '0';
                                E5 <= '0';
                                E6 <= '1';

		end case;
	end process;
end controle_arq;