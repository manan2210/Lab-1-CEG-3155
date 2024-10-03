LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lshift_register_8b IS
	PORT (i_in 				  : IN STD_LOGIC_VECTOR(7 downto 0);
			i_load, i_shift  : IN STD_LOGIC;
			i_clock, i_reset : IN STD_LOGIC;
			o_out 			  : OUT STD_LOGIC_VECTOR(7 downto 0));
END ENTITY lshift_register_8b;

ARCHITECTURE rtl OF lshift_register_8b IS
	SIGNAL int_out 	   : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_shifted   : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_nextstate : STD_LOGIC_VECTOR(7 downto 0);
	
	COMPONENT register_8b
		PORT (i_in 				  : IN STD_LOGIC_VECTOR(7 downto 0);
				i_load 	   	  : IN STD_LOGIC;
				i_clock, i_reset : IN STD_LOGIC;
				o_out 			  : OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT register_8b;
BEGIN
	reg : register_8b
	PORT MAP (i_in    => int_nextstate,
				 i_load  => i_load or i_shift,
				 i_clock => i_clock,
				 i_reset => i_reset,
				 o_out   => int_out);
	
	int_shifted   <= int_out(6 downto 0) & int_out(7);
	int_nextstate <= int_shifted when i_shift = '1' else i_in;
	o_out <= int_out;
END ARCHITECTURE rtl;