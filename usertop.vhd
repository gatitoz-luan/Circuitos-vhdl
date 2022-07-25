library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity usertop is port (

   CLK: in std_logic;
   SW: in std_logic_vector (17 downto 0);
   KEY: in std_logic_vector (3 downto 0);
   out_LEDR: out std_logic_vector (17 downto 0);
   out_HEX0, out_HEX1, out_HEX2, out_HEX3, out_HEX4, out_HEX5, out_HEX6, out_HEX7: out std_logic_vector (6 downto 0)
   );

end usertop;

architecture usertop_arq of usertop is

---- Declaração dos sinais

   signal enter, reset, Enter_left, Enter_right: std_logic;
   signal st_R1, st_E1, st_E2, st_E3, st_E4, st_E5, st_E6: std_logic;
   signal im_end_game, im_end_sequence, im_end_round, im_enter_left, im_enter_right: std_logic;
   
---- Declaração de componentes

component datapath is port(
    
    SW: in std_logic_vector(17 downto 0);
    CLK: in std_logic;
	Enter_left, Enter_right: in std_logic;
    R1, E1, E2, E3, E4, E5, E6: in std_logic;
	end_game, end_sequence, end_round, end_left, end_right: out std_logic;
    HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
    LEDR: out std_logic_vector(17 downto 0));
    
end component;

component controle is port (

   CLK: in std_logic;
   enter, reset: in std_logic;
   R1, E1, E2, E3, E4, E5, E6: out std_logic;
   end_game, end_sequence, end_round, enter_left, enter_right: in std_logic
   );
   
end component;

component ButtonPlay is port(

    KEY1, KEY0: in  std_logic;
    Reset, clk: in  std_Logic;
    BTN1, BTN0: out std_logic); 
    
end component;

component ButtonSync is port(

    KEY1, KEY0, CLK: in  std_logic;
    BTN1, BTN0   : out std_logic);

end component;

begin
    
    ---- Button play
    
    comp_BT_play: ButtonPlay port map(KEY(3), KEY(2), st_E2, CLK, Enter_left, Enter_right);

    ---- Button sync
    
    comp_BT_sync: ButtonSync port map(KEY(1), KEY(0), CLK, enter, reset);
    
    ---- Datapath
    
    comp_datapath: datapath port map(
    
        SW(17 downto 0), CLK, Enter_left, Enter_right, 
        st_R1, st_E1, st_E2, st_E3, st_E4, st_E5, st_E6, 
        im_end_game, im_end_sequence, im_end_round, im_enter_left, im_enter_right,
        out_HEX7, out_HEX6, out_HEX5, out_HEX4, out_HEX3, out_HEX2, out_HEX1, out_HEX0,
        out_LEDR
    
        );
    
    ---- Controle
    
    comp_controle: controle port map(
    
        CLK, enter, reset,
        st_R1, st_E1, st_E2, st_E3, st_E4, st_E5, st_E6,
        im_end_game, im_end_sequence, im_end_round, im_enter_left, im_enter_right
    
        );

    
    
end usertop_arq;