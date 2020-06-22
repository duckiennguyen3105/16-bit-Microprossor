LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY IR IS
PORT ( IRin : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Clk, IRld : IN STD_LOGIC;
		IRout : buffer STD_LOGIC_VECTOR(15 DOWNTO 0));
END  IR;

ARCHITECTURE Behavior OF IR IS
BEGIN
	PROCESS(Clk, IRld)
	BEGIN
		
	if(rising_edge(Clk)) then
		if (IRld = '0') then
			IRout <= IRout;
		else
			IRout <= IRin; 
		end if;
	end if;
	
	END PROCESS;

END Behavior;

