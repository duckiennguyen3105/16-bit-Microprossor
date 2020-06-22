LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ALU IS
PORT ( OPr1, OPr2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ALUs : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUz : OUT STD_LOGIC;
		ALUr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END  ALU;

ARCHITECTURE Behavior OF ALU IS
BEGIN
	PROCESS(ALUs, OPr1, OPr2)
	BEGIN
		CASE ALUs IS
			WHEN "00" => ALUr <= OPr1 + OPr2;
			WHEN "01" => ALUr <= OPr1 - OPr2;
			WHEN "10" => ALUr <= OPr1 OR OPr2;
			WHEN "11" => ALUr <= OPr1 AND OPr2;
			WHEN OTHERS => NULL;
		END CASE;
	END PROCESS;

	ALUz <= '1' WHEN OPr1 = x"0000" ELSE
				'0';

END Behavior;
