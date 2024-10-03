LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY en_as_dff IS
	PORT (i_d, i_enable	: IN STD_LOGIC;
			i_clock, i_set : IN STD_LOGIC;
			o_q, o_qBar 	: OUT STD_LOGIC);
END en_as_dff;

ARCHITECTURE rtl OF en_as_dff IS
	SIGNAL int_q, int_qBar 				: STD_LOGIC;
	SIGNAL int_masterEn, int_slaveEn : STD_LOGIC;
	SIGNAL int_masterS, int_slaveS   : STD_LOGIC;
	
	COMPONENT enabledSRlatch
		PORT (i_set, i_reset	: IN	STD_LOGIC;
				i_enable			: IN	STD_LOGIC;
				o_q, o_qBar		: OUT	STD_LOGIC);
	END COMPONENT enabledSRlatch;
	
	BEGIN
		-- Component instantiation
		masterLatch: enabledSRlatch
		PORT MAP (i_set    => int_masterS,
					 i_reset  => not(int_masterS),
					 i_enable => int_masterEn,
					 o_q 		 => int_q,
					 o_qBar	 => int_qBar);
		
		slaveLatch: enabledSRlatch
		PORT MAP (i_set 	 => int_slaveS,
					 i_reset  => not(int_slaveS),
					 i_enable => int_slaveEn,
					 o_q 		 => o_q,
					 o_qBar 	 => o_qBar);
		
		-- Concurrent signal assignment
		int_masterEn <= (not(i_clock) and i_enable) or i_set;
		int_slaveEn  <= (i_clock and i_enable) or i_set;
		int_masterS  <= i_d or i_set;
		int_slaveS   <= int_q or i_set;
		
END ARCHITECTURE rtl;

















