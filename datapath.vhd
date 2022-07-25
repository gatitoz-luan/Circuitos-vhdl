library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity datapath is port(

    SW: in std_logic_vector(17 downto 0);
    CLK: in std_logic;
	 Enter_left, Enter_right: in std_logic;
    R1, E1, E2, E3, E4, E5, E6: in std_logic;
	 end_game, end_sequence, end_round, end_left, end_right: out std_logic;
    HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
    LEDR: out std_logic_vector(17 downto 0));

end datapath;

architecture arc_data of datapath is

-- signals padronizados. Favor utilizar estes.

signal play_left, play_right: std_logic_vector(15 downto 0);
signal control_left, control_right, rst_divfreq, not_entl, not_entr: std_logic;
signal sel, X: std_logic_vector(3 downto 0);
signal seq_out_left, seq_out_right, penalty: std_logic_vector(7 downto 0);
signal T_left_BCD, T_right_BCD, T_left_out, T_right_out: std_logic_vector(7 downto 0);
signal end_time_left, end_time_right: std_logic;
signal termo: std_logic_vector(15 downto 0);
signal pisca, mx_time_left, mx_time_right, mx_sqoutl, mx_sqoutr, mx_trm: std_logic_vector(8 downto 0);
signal S: std_logic_vector(79 downto 0);

signal mx_hex7, mx_hex6, mx_hex5, mx_hex4: std_logic_vector(3 downto 0);
signal mx_1hex3, mx_2hex3, mx_1hex2, mx_2hex2, mx_1hex1, mx_2hex1, mx_1hex0, mx_2hex0: std_logic_vector(3 downto 0);
signal mxsel_msb, mxsel_lsb: std_logic_vector(3 downto 0);
signal E2_and_X0, notE1_or_R1: std_logic; 
signal saida_rom0, saida_rom1, saida_rom2, saida_rom3: std_logic_vector(79 downto 0);
signal sel_cnt, sel_mxledr: std_logic_vector(1 downto 0);
signal mux_ctrlleft, saida_load_left, mux_ctrlright, saida_load_right: std_logic_vector(7 downto 0);
signal CLK_1Hz, Sim_1Hz, enable_left, enable_right: std_logic;
signal SWleft, SWRight: std_logic_vector(15 downto 0);

signal left_penalty, right_penalty: std_logic_vector(7 downto 0);

----- Signals criados

signal d_reg_left, d_reg_right: std_logic_vector(15 downto 0);
signal signal_out_counter_seq: std_logic_vector(1 downto 0);
signal mux1_right_counter_time_output, mux2_right_counter_time_output, mux1_left_counter_time_output, mux2_left_counter_time_output: std_logic_vector(7 downto 0);
signal div_freq_r: std_logic;
signal counter_seq_r: std_logic;

----- components

component decoder_termometrico is port(
    
    X: in  std_logic_vector(3 downto 0);
    S: out std_Logic_vector(15 downto 0));
    
end component;

component Div_Freq_Emu is
	port (	clk: in std_logic;
			reset: in std_logic;
			CLK_1Hz: out std_logic;
			Sim_1Hz: out std_logic);
end component;

component DecBCD is port (

	input  : in  std_logic_vector(7 downto 0);
	output : out std_logic_vector(7 downto 0));

end component;

component ROM0 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(79 downto 0));
    
end component;

component ROM1 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(79 downto 0));
    
end component;

component ROM2 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(79 downto 0));
    
end component;

component ROM3 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(79 downto 0));
    
end component;

component Comparador is port(
    
    in0, in1: in  std_logic_vector(7 downto 0);
    S       : out std_logic);
    
end component;

component Mux2_1x4 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(3 downto 0);
    D     : out std_logic_vector(3 downto 0));
    
end component;

component Mux2_1x8 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(7 downto 0);
    D     : out std_logic_vector(7 downto 0));
    
end component;

component Mux4_1x8 is port(

    S             : in  std_logic_vector(1 downto 0);
    L0, L1, L2, L3: in  std_logic_vector(7 downto 0);
    D             : out std_logic_vector(7 downto 0));
    
end component;

component Mux4_1x9 is port(

    S: in std_logic_vector(1 downto 0);
    L0, L1, L2, L3: in std_logic_vector(8 downto 0);
    D: out std_logic_vector(8 downto 0));
    
end component;

component Mux4_1x80 is port(

    S: in std_logic_vector(1 downto 0);
    L0, L1, L2, L3: in std_logic_vector(79 downto 0);
    D: out std_logic_vector(79 downto 0));
    
end component Mux4_1x80;

component decod7seg is port (

	input  : in  std_logic_vector(3 downto 0);
	output : out std_logic_vector(6 downto 0));

end component;

------------------------completar os components que faltam------------------------------

component registrador16 is port (
	CLK: in std_logic;
	E: in std_logic;
	R: in std_logic;
	D: in std_logic_vector(15 downto 0);
	Q: out std_logic_vector(15 downto 0));
end component;

component registrador4 is port (
	CLK: in std_logic;
	E: in std_logic;
	R: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0));
end component;

component Counter_round is port ( 
  CLK: in std_logic;
  Enable: in std_logic;
  Set: in std_logic;
  tc:out std_logic;
  output: out std_logic_vector(3 downto 0));
end component;

component Counter_seq is port ( 
  CLK: in std_logic;
  Enable: in std_logic;
  Set: in std_logic;
  tc:out std_logic;
  output: out std_logic_vector(1 downto 0));
end component;

component Counter_time is port ( 
  CLK: in std_logic;
  Enable: in std_logic;
  Set: in std_logic;
  load_step: in std_logic_vector(7 downto 0);
  tc:out std_logic;
  output: out std_logic_vector(7 downto 0));
end component;

begin

------ HEX ----------------------------

E2_and_X0 <= E2 and X(0);
notE1_or_R1 <= not(E1 or R1);

--usando o decod7seg fornecido, "1111" apaga os displays

--HEX7

mx_hx7: mux2_1x4 port map(notE1_or_R1, "1111", T_left_BCD(7 downto 4), mx_hex7);
d7_hx7: decod7seg port map(mx_hex7, HEX7);

--HEX6

mx_hx6: mux2_1x4 port map(notE1_or_R1, "1111", T_left_BCD(3 downto 0), mx_hex6);
d7_hx6: decod7seg port map(mx_hex6, HEX6);

--HEX5

mx_hx5: mux2_1x4 port map(E2_and_X0, "1111", Seq_out_left(7 downto 4), mx_hex5);
d7_hx5: decod7seg port map(mx_hex5, HEX5);

--HEX4

mx_hx4: mux2_1x4 port map(E2_and_X0, "1111", Seq_out_left(3 downto 0), mx_hex4);
d7_hx4: decod7seg port map(mx_hex4, HEX4);

--HEX3

mx_1hx3: mux2_1x4 port map(E1, "1111", "1100", mx_1hex3); -- 1100 eh J no decod7seg fornecido
mx_2hx3: mux2_1x4 port map(notE1_or_R1, mx_1hex3, T_right_BCD(7 downto 4), mx_2hex3);
d7_hx3: decod7seg port map(mx_2hex3, HEX3);

--HEX2

mxsel_msb <= "00" & sel(3 downto 2);
mx_1hx2: mux2_1x4 port map(E1, "1111", mxsel_msb, mx_1hex2);
mx_2hx2: mux2_1x4 port map(notE1_or_R1, mx_1hex2, T_right_BCD(3 downto 0), mx_2hex2);
d7_hx2: decod7seg port map(mx_2hex2, HEX2);

--HEX1

mx_1hx1: mux2_1x4 port map(E1, "1111", "1101", mx_1hex1); -- 1101 eh L no decod7seg fornecido
mx_2hx1: mux2_1x4 port map(E2_and_X0, mx_1hex1, Seq_out_right(7 downto 4), mx_2hex1);
d7_hx1: decod7seg port map(mx_2hex1, HEX1);

--HEX0

mxsel_lsb <= "00" & sel(1 downto 0);
mx_1hx0: mux2_1x4 port map(E1, "1111", mxsel_lsb, mx_1hex0);
mx_2hx0: mux2_1x4 port map(E2_and_X0, mx_1hex0, Seq_out_right(3 downto 0), mx_2hex0);
d7_hx0: decod7seg port map(mx_2hex0, HEX0);


---- ROM's

ROM_0: ROM0 port map(X, saida_rom0);
ROM_1: ROM1 port map(X, saida_rom1);
ROM_2: ROM2 port map(X, saida_rom2);
ROM_3: ROM3 port map(X, saida_rom3);

---- Muxes LEDR

sel_mxledr <= (E5 or E6) & ((E2 and not(X(0))) or E6);
mx_time_left <= pisca when end_time_left = '0' else "000000000";
mx_time_right <= pisca when end_time_right = '0' else "000000000";


mx_sqoutl <= seq_out_left & '0';
mx_sqoutr <= '0' & seq_out_right;
mx_trm <= "00" & termo(15 downto 9);
mxlrmsb: Mux4_1x9 port map(sel_mxledr, "000000000", mx_sqoutl, mx_trm, mx_time_left, LEDR(17 downto 9));
mxlrlsb: Mux4_1x9 port map(sel_mxledr, "000000000", mx_sqoutr, termo(8 downto 0), mx_time_right, LEDR(8 downto 0));


not_entl <= not enter_left;
not_entr <= not  enter_right;


---- Sinais/Entradas logicas

end_left <= Enter_left;   --como entradas e saidas nao podem ter o mesmo nome, foram chamadas de "end_left" e "end_right",
end_right <= Enter_right; --mas no resto do projeto continuam sendo Enter_left e Enter_right.

---- Comparador

comp_left: Comparador port map(play_left(7 downto 0), play_left(15 downto 8), control_left);
comp_right: Comparador port map(play_right(7 downto 0), play_right(15 downto 8), control_right);

---- Registradores 16
-- Signals dos registradores

d_reg_left <= SW(17 downto 10) & S(79 downto 72);
reg_left: Registrador16 port map(CLK, not_entl, R1, d_reg_left, play_left);

d_reg_right <= SW(7 downto 0) & S(39 downto 32);
reg_right: Registrador16 port map(CLK, not_entr, R1, d_reg_right, play_right);

---- Registrador 4

reg_sel: Registrador4 port map(CLK, E1, R1, SW(3 downto 0), sel);

---- Penalty mux

penalty_mux: Mux4_1x8 port map(sel(1 downto 0), "11111110", "11111100", "11111110", "11111000", penalty);

---- Mux de 80 bits

eight_bits_mux: Mux4_1x80 port map(sel(3 downto 2), saida_rom0, saida_rom1, saida_rom2, saida_rom3, s);

---- Mux das sequências

mux_seq_out_right: Mux4_1x8 port map(signal_out_counter_seq, s(7 downto 0), s(15 downto 8), s(23 downto 16), s(31 downto 24), seq_out_right);
mux_seq_out_left: Mux4_1x8 port map(signal_out_counter_seq, s(47 downto 40), s(55 downto 48), s(63 downto 56), s(71 downto 64), seq_out_left);


---- Counter time right

--- Lógicas de entrada
-- Lógicas combinacionais
enable_right <= (E4 or ((not enter_right) and E3 and CLK_1Hz));
-- Muxes
mux1_right_counter_time: Mux2_1x8 port map(control_right, penalty, "00000000", mux1_right_counter_time_output);
mux2_right_counter_time: Mux2_1x8 port map(E4, "11111111", mux1_right_counter_time_output, mux2_right_counter_time_output);

counter_time_right: Counter_time port map(CLK, enable_right, R1, mux2_right_counter_time_output, end_time_right, T_right_out);
-- Saída
dec_bcd_right: DecBCD port map(T_right_out, T_right_BCD);


---- Counter time left

--- Lógicas de entrada
-- Lógicas combinacionais
enable_left <= (E4 or ((not enter_left) and E3 and CLK_1Hz));
-- Muxes
mux1_left_counter_time: Mux2_1x8 port map(control_left, penalty, "00000000", mux1_left_counter_time_output);
mux2_left_counter_time: Mux2_1x8 port map(E4, "11111111", mux1_left_counter_time_output, mux2_left_counter_time_output);

counter_time_left: Counter_time port map(CLK, enable_left, R1, mux2_left_counter_time_output, end_time_left, T_left_out);
-- Saída
dec_bcd_left: DecBCD port map(T_left_out, T_left_BCD);


---- Lógica combinacional end_game

end_game <= (end_time_left or end_time_right);

---- Lógica combinacional pisca

pisca <= "000000000" when Sim_1Hz = '0' else "111111111";


---- Counter_seq - Contador sequencial

counter_seq_r <= R1 or E5;
cnt_seq: Counter_seq port map(CLK_1Hz, E2, counter_seq_r, end_sequence, signal_out_counter_seq);

---- Counter_round - Contador de rodada

cnt_round: Counter_round port map(CLK, E4, R1, end_round, x); 
-- Saída
dec_termometrico: decoder_termometrico port map(x, termo);

---- Div_freq - Divisor de frequência
div_freq_r <= (E1 or E5);
Div_Freq: Div_Freq_Emu port map(CLK, div_freq_r, CLK_1Hz, Sim_1Hz);




------------------------------------ FAZER ----------------------------------------



end arc_Data;
