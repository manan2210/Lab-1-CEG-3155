LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY datapath IS
	PORT (i_in1, i_in2 									: IN STD_LOGIC;
			i_left_en, i_right_en 						: IN STD_LOGIC;
			i_shift_l, i_shift_r 						: IN STD_LOGIC;
			i_loadDISPLAY, i_loadLEFT, i_loadRIGHT : IN STD_LOGIC;
			i_gclk, i_gres 								: IN STD_LOGIC;
			o_left_q, o_right_q							: OUT STD_LOGIC;
			o_out												: OUT STD_LOGIC_VECTOR(7 downto 0));
END ENTITY datapath;

ARCHITECTURE rtl OF datapath IS
	SIGNAL int_mux, int_bor     : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_LMASK, int_RMASK : STD_LOGIC_VECTOR(7 downto 0);

	COMPONENT en_ar_dff
		PORT (i_d, i_enable	  : IN STD_LOGIC;
				i_clock, i_reset : IN STD_LOGIC;
				o_q, o_qBar 	  : OUT STD_LOGIC);
	END COMPONENT en_ar_dff;
	
	COMPONENT register_8b
		PORT (i_in 				  : IN STD_LOGIC_VECTOR(7 downto 0);
				i_load 	   	  : IN STD_LOGIC;
				i_clock, i_reset : IN STD_LOGIC;
				o_out 			  : OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT register_8b;
	
	COMPONENT lshift_register_8b
		PORT (i_in 				  : IN STD_LOGIC_VECTOR(7 downto 0);
				i_load, i_shift  : IN STD_LOGIC;
				i_clock, i_reset : IN STD_LOGIC;
				o_out 			  : OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT lshift_register_8b;
	
	COMPONENT rshift_register_8b
		PORT (i_in 				  : IN STD_LOGIC_VECTOR(7 downto 0);
				i_load, i_shift  : IN STD_LOGIC;
				i_clock, i_reset : IN STD_LOGIC;
				o_out 			  : OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT rshift_register_8b;
	
	COMPONENT bitwiseOR_8b
		PORT (i_a, i_b : IN STD_LOGIC_VECTOR(7 downto 0);
				o_out		: OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT bitwiseOR_8b;
	
	COMPONENT MUX_4_1_8b
		PORT (i_00, i_01, i_10, i_11 : IN STD_LOGIC_VECTOR(7 downto 0);
				i_sel0, i_sel1 		  : IN STD_LOGIC;
				o_out						  : OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT MUX_4_1_8b;
		
BEGIN
	dff1 : en_ar_dff
	PORT MAP (i_d      => i_in1,
				 i_enable => i_left_en,
				 i_clock  => i_gclk,
				 i_reset  => i_gres,
				 o_q      => o_left_q);
	
	dff2 : en_ar_dff
	PORT MAP (i_d      => i_in2,
				 i_enable => i_right_en,
				 i_clock  => i_gclk,
				 i_reset  => i_gres,
				 o_q      => o_right_q);
				 
	DISPLAY : register_8b
	PORT MAP (i_in    => int_mux,
		   	 i_load  => i_loadDISPLAY,
				 i_clock => i_gclk,
				 i_reset => i_gres,
				 o_out   => o_out);
				 
	LMASK : lshift_register_8b
	PORT MAP (i_in    => "00000001",
				 i_load  => i_loadLEFT,
				 i_shift => i_shift_l,
			    i_clock => i_gclk,
			    i_reset => i_gres,
			    o_out   => int_LMASK);
				 
	RMASK : rshift_register_8b
	PORT MAP (i_in    => "10000000",
				 i_load  => i_loadRIGHT,
				 i_shift => i_shift_r,
				 i_clock => i_gclk,
				 i_reset => i_gres,
				 o_out   => int_RMASK);
				  
	bor : bitwiseOR_8b
	PORT MAP (i_a => int_LMASK,
				 i_b => int_RMASK,
				 o_out => int_bor);
	
	mux : MUX_4_1_8b
	PORT MAP (i_00 => "00000000",
				 i_01 => int_RMASK,
				 i_10 => int_LMASK,
				 i_11 => int_bor,
				 i_sel0 => i_shift_r,
				 i_sel1 => i_shift_l,
				 o_out => int_mux);
END ARCHITECTURE rtl;


















