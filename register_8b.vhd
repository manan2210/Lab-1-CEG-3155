LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register_8b IS
	PORT (i_in 				  : IN STD_LOGIC_VECTOR(7 downto 0);
			i_load 	   	  : IN STD_LOGIC;
			i_clock, i_reset : IN STD_LOGIC;
			o_out 			  : OUT STD_LOGIC_VECTOR(7 downto 0));
END register_8b;

ARCHITECTURE rtl OF register_8b IS
	COMPONENT en_ar_dff
		PORT (i_d, i_enable	  : IN STD_LOGIC;
				i_clock, i_reset : IN STD_LOGIC;
				o_q, o_qBar 	  : OUT STD_LOGIC);
	END COMPONENT en_ar_dff;	
BEGIN
		-- Component instantiation
		bit7: en_ar_dff
		PORT MAP (i_d => i_in(7),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(7));
		
		bit6: en_ar_dff
		PORT MAP (i_d => i_in(6),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(6));
					 
		bit5: en_ar_dff
		PORT MAP (i_d => i_in(5),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(5));
					 
		bit4: en_ar_dff
		PORT MAP (i_d => i_in(4),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(4));
					 
		bit3: en_ar_dff
		PORT MAP (i_d => i_in(3),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(3));
					 
		bit2: en_ar_dff
		PORT MAP (i_d => i_in(2),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(2));
					 
		bit1: en_ar_dff
		PORT MAP (i_d => i_in(1),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(1));
					 
		bit0: en_ar_dff
		PORT MAP (i_d => i_in(0),
					 i_enable => i_load,
					 i_clock => i_clock,
					 i_reset => i_reset,
					 o_q => o_out(0));		
END ARCHITECTURE rtl;

















