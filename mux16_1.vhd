LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY MUX16_1 IS
PORT ( R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		OPra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Clk,OPre : IN STD_LOGIC;
		M : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END  MUX16_1;

ARCHITECTURE Behavior OF MUX16_1 IS
BEGIN
	PROCESS(OPra,Clk,OPre)
	BEGIN
		if rising_edge(Clk) then
		if OPre ='1' then
		CASE OPra IS
			WHEN "0000" => M <= R0;
			WHEN "0001" => M <= R1;
			WHEN "0010" => M <= R2;
			WHEN "0011" => M <= R3;
			WHEN "0100" => M <= R4;
			WHEN "0101" => M <= R5;
			WHEN "0110" => M <= R6;
			WHEN "0111" => M <= R7;
			WHEN "1000" => M <= R8;
			WHEN "1001" => M <= R9;
			WHEN "1010" => M <= R10;
			WHEN "1011" => M <= R11;
			WHEN "1100" => M <= R12;
			WHEN "1101" => M <= R13;
			WHEN "1110" => M <= R14;
			WHEN "1111" => M <= R15;
			WHEN OTHERS => NULL;
		END CASE;
		end if;
		end if;
	END PROCESS;

END Behavior;

