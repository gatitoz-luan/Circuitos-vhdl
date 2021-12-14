library ieee;
use ieee.std_logic_1164.all;

entity shiftRecorder is 
  port (
   D0: in std_logic;
   clock: in std_logic;
   RES0, RES1, RES2, RES3: out std_logic);
end shiftRecorder;

architecture behv of shiftRecorder is
 signal Q0, Q1, Q2, Q3: std_logic;
 
 component flipFlopD is
  port(CLK: in std_logic;
       D: in std_logic;
       Q: out std_logic);
 end component;

 begin
  firstFlipFlopD: flipFlopD port map(CLK => clock,
                                     D => D0,
                                     Q => Q0);

  scndFlipFlopD: flipFlopD port map(CLK => clock,
                                     D => Q0,
                                     Q => Q1);

  thirdFlipFlopD: flipFlopD port map(CLK => clock,
                                     D => Q1,
                                     Q => Q2);
                                     
  fourthFlipFlopD: flipFlopD port map(CLK => clock,
                                      D => Q2,
                                      Q => Q3);
    RES0 <= Q0;
    RES1 <= Q1;
    RES2 <= Q2;
    RES3 <= Q3; -- to port map
end behv;
