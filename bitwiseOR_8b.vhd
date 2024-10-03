LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bitwiseOR_8b IS
	PORT (i_a, i_b : IN STD_LOGIC_VECTOR(7 downto 0);
			o_out		: OUT STD_LOGIC_VECTOR(7 downto 0));
END ENTITY bitwiseOR_8b;

ARCHITECTURE rtl OF bitwiseOR_8b IS
BEGIN
	o_out(7) <= i_a(7) or i_b(7);
	o_out(6) <= i_a(6) or i_b(6);
	o_out(5) <= i_a(5) or i_b(5);
	o_out(4) <= i_a(4) or i_b(4);
	o_out(3) <= i_a(3) or i_b(3);
	o_out(2) <= i_a(2) or i_b(2);
	o_out(1) <= i_a(1) or i_b(1);
	o_out(0) <= i_a(0) or i_b(0);
END ARCHITECTURE rtl;