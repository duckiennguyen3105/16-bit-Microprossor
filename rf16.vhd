library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rf16 is
	Port ( 
		RFin : in std_logic_vector(15 downto 0);
		RFld, Clk : in std_logic;
		Rout : out std_logic_vector(15 downto 0)
	);
end rf16;

architecture Behavioral of rf16 is

begin
	process(Clk, RFld)
		begin
		if (rising_edge(Clk)) and (RFld = '1') then
		Rout <= RFin;
		end if;
		
	end process;
end Behavioral;