LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY PC IS
PORT ( PCin : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Clk, PCclr, PCinc, PCld : IN STD_LOGIC;
		PCout : buffer STD_LOGIC_VECTOR(15 DOWNTO 0));
END  PC;

ARCHITECTURE Behavior OF PC IS
BEGIN
	PROCESS(Clk,PCclr,PCinc,PCld)
	BEGIN
		if (PCclr = '0') then
			if(rising_edge(Clk)) then
				if (PCld = '0')  then
					if (PCinc = '1') then
					PCout <= PCout + 1;
			  	        else
					PCout <= PCout;
					end if;
				else
				PCout <= PCin; 
				end if;
			end if;
		else 
			PCout <= x"0000";
		end if;
	END PROCESS;

END Behavior;

