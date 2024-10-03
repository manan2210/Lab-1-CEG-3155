LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY controlpath IS
    PORT (i_left_q, i_right_q 								: IN STD_LOGIC;
          i_gclk, i_gres               					: IN STD_LOGIC;
          o_left_en, o_right_en, o_shift_l, o_shift_r : OUT STD_LOGIC;
			 o_loadLEFT, o_loadRIGHT, o_loadDISPLAY	   : OUT STD_LOGIC);
END ENTITY controlpath;

ARCHITECTURE rtl OF controlpath IS
	SIGNAL int_s0, int_s1, int_s2, int_s3, int_s4 : STD_LOGIC;

	COMPONENT en_ar_dff
		PORT (i_d, i_enable	  : IN STD_LOGIC;
				i_clock, i_reset : IN STD_LOGIC;
				o_q, o_qBar 	  : OUT STD_LOGIC);
	END COMPONENT en_ar_dff;
	
	COMPONENT en_as_dff
		PORT (i_d, i_enable	: IN STD_LOGIC;
				i_clock, i_set : IN STD_LOGIC;
				o_q, o_qBar 	: OUT STD_LOGIC);
	END COMPONENT en_as_dff;

BEGIN
	s0_dff : en_as_dff
	PORT MAP (i_d      => '0',
				 i_enable => '1',
				 i_clock  => i_gclk,
				 i_set    => i_gres,
				 o_q      => int_s0);
				 
	s1_dff : en_ar_dff
	PORT MAP (i_d      => i_left_q and i_right_q,
				 i_enable => '1',
				 i_clock  => i_gclk,
				 i_reset  => i_gres,
				 o_q      => int_s1);
				 
	s2_dff : en_ar_dff
	PORT MAP (i_d      => i_left_q and not(i_right_q),
				 i_enable => '1',
				 i_clock  => i_gclk,
				 i_reset  => i_gres,
				 o_q      => int_s2);
				 
	s3_dff : en_ar_dff
	PORT MAP (i_d      => not(i_left_q) and i_right_q,
				 i_enable => '1',
				 i_clock  => i_gclk,
				 i_reset  => i_gres,
				 o_q      => int_s3);
				 
	s4_dff : en_ar_dff
	PORT MAP (i_d      => not(i_left_q) and not(i_right_q),
				 i_enable => '1',
				 i_clock  => i_gclk,
				 i_reset  => i_gres,
				 o_q      => int_s4);
				 
	o_left_en     <= '1';
	o_right_en    <= '1';
	o_shift_l     <= int_s1 or int_s2;
	o_shift_r     <= int_s1 or int_s3;
	o_loadLEFT    <= int_s0;
	o_loadRIGHT   <= int_s0;
	o_loadDISPLAY <= '1';
END ARCHITECTURE rtl;