LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY displayController IS
	PORT (i_right, i_left : IN STD_LOGIC;
			i_gclk, i_gres  : IN STD_LOGIC;
			o_out 			 : OUT STD_LOGIC_VECTOR(7 downto 0));
END ENTITY displayController;

ARCHITECTURE rtl OF displayController IS
	SIGNAL int_left_en, int_right_en, int_shift_l, int_shift_r : STD_LOGIC;
	SIGNAL int_loadLEFT, int_loadRIGHT, int_loadDISPLAY		  : STD_LOGIC;
	SIGNAL int_left_q, int_right_q									  : STD_LOGIC;

	COMPONENT datapath
		PORT (i_in1, i_in2 									: IN STD_LOGIC;
				i_left_en, i_right_en 						: IN STD_LOGIC;
				i_shift_l, i_shift_r 						: IN STD_LOGIC;
				i_loadDISPLAY, i_loadLEFT, i_loadRIGHT : IN STD_LOGIC;
				i_gclk, i_gres 								: IN STD_LOGIC;
				o_left_q, o_right_q							: OUT STD_LOGIC;
				o_out												: OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT datapath;
	
	COMPONENT controlpath
		PORT (i_left_q, i_right_q 								  : IN STD_LOGIC;
				i_gclk, i_gres               				  	  : IN STD_LOGIC;
            o_left_en, o_right_en, o_shift_l, o_shift_r : OUT STD_LOGIC;
				o_loadLEFT, o_loadRIGHT, o_loadDISPLAY	     : OUT STD_LOGIC);
	END COMPONENT controlpath;

BEGIN
	dp : datapath
	PORT MAP (i_in1 => i_left,
				 i_in2 => i_right,
				 i_left_en => int_left_en,
				 i_right_en => int_right_en,
				 i_shift_l => int_shift_l,
				 i_shift_r => int_shift_r,
				 i_loadDISPLAY => int_loadDISPLAY,
				 i_loadLEFT => int_loadLEFT,
				 i_loadRIGHT => int_loadRIGHT,
				 i_gclk => i_gclk,
				 i_gres => i_gres,
				 o_left_q => int_left_q,
				 o_right_q => int_right_q,
				 o_out => o_out);
	
	cp : controlpath
	PORT MAP (i_left_q => int_left_q,
				 i_right_q => int_right_q,
				 i_gclk => i_gclk,
				 i_gres => i_gres,
				 o_left_en => int_left_en,
				 o_right_en => int_right_en,
				 o_shift_l => int_shift_l,
				 o_shift_r => int_shift_r,
				 o_loadLEFT => int_loadLEFT,
				 o_loadRIGHT => int_loadRIGHT,
				 o_loadDISPLAY => int_loadDISPLAY);
END ARCHITECTURE rtl;