LIBRARY IEEE;
USE ieee.std_logic_1164.all;


ENTITY decoder4_16 IS
PORT ( 
		RFwa : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		RFwe : IN STD_LOGIC;
		RFId : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END  decoder4_16;

ARCHITECTURE structural OF decoder4_16 IS
BEGIN
	PROCESS(RFwe, RFwa)
	BEGIN
		IF(RFwe = '1') THEN
		RFId(0) <= (NOT RFwa(3)) and (NOT RFwa(2)) and (NOT RFwa(1)) and (NOT RFwa(0));
		RFId(1) <= (NOT RFwa(3)) and (NOT RFwa(2)) and (NOT RFwa(1)) and RFwa(0);
		RFId(2) <= (NOT RFwa(3)) and (NOT RFwa(2)) and  RFwa(1) and (NOT RFwa(0));
		RFId(3) <= (NOT RFwa(3)) and (NOT RFwa(2)) and  RFwa(1) and RFwa(0);
		RFId(4) <= (NOT RFwa(3)) and RFwa(2) and (NOT RFwa(1)) and (NOT RFwa(0));
		RFId(5) <= (NOT RFwa(3)) and RFwa(2) and (NOT RFwa(1)) and RFwa(0);
		RFId(6) <= (NOT RFwa(3)) and RFwa(2) and RFwa(1) and (NOT RFwa(0));
		RFId(7) <= (NOT RFwa(3)) and RFwa(2) and RFwa(1) and RFwa(0);
		RFId(8) <= RFwa(3) and (NOT RFwa(2)) and (NOT RFwa(1)) and (NOT RFwa(0));
		RFId(9) <= RFwa(3) and (NOT RFwa(2)) and (NOT RFwa(1)) and RFwa(0);
		RFId(10) <= RFwa(3) and (NOT RFwa(2)) and  RFwa(1) and (NOT RFwa(0));
		RFId(11) <= RFwa(3) and (NOT RFwa(2)) and  RFwa(1) and RFwa(0);
		RFId(12) <= RFwa(3) and RFwa(2) and (NOT RFwa(1)) and (NOT RFwa(0));
		RFId(13) <= RFwa(3) and RFwa(2) and (NOT RFwa(1)) and RFwa(0);
		RFId(14) <= RFwa(3) and RFwa(2) and RFwa(1) and (NOT RFwa(0));
		RFId(15) <= RFwa(3) and RFwa(2) and RFwa(1) and RFwa(0);
		ELSE
		RFId <= x"0000";
		END IF;
	END PROCESS;
END structural;

