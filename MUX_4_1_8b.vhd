LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_4_1_8b IS
	PORT (i_00, i_01, i_10, i_11 : IN STD_LOGIC_VECTOR(7 downto 0);
			i_sel0, i_sel1 		  : IN STD_LOGIC;
			o_out						  : OUT STD_LOGIC_VECTOR(7 downto 0));
END ENTITY MUX_4_1_8b;

ARCHITECTURE rtl OF MUX_4_1_8b IS
BEGIN
	o_out <= i_00 when (i_sel1 = '0' and i_sel0 = '0') else
				i_01 when (i_sel1 = '0' and i_sel0 = '1') else
				i_10 when (i_sel1 = '1' and i_sel0 = '0') else
				i_11 when (i_sel1 = '1' and i_sel0 = '1');
END ARCHITECTURE  rtl;