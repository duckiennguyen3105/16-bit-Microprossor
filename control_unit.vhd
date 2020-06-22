library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.CPU_16bit_lib.all;

entity control_unit is             	

   port (
		Reset   : in STD_LOGIC; -- low active reset signal
      clk   : in STD_LOGIC;
		Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		IRout : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0);
		OPr2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ADDR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		RFwa, OPR1a, OPR2a: out std_LOGIC_VECTOR(3 downto 0);
      RFwe, OPR1e, OPr2e : out std_logic;
		RFs, ALUs    : out std_logic_vector(1 downto 0);
		ALUz  : in std_logic; 
		Mre, Mwe : out std_logic);
end control_unit;

ARCHITECTURE struct OF control_unit IS
SIGNAL PCout : std_LOGIC_VECTOR(15 downto 0);
SIGNAL Ms : std_LOGIC_VECTOR(1 downto 0);
SIGNAL IRld, PCclr, PCinc, PCld : std_LOGIC;
BEGIN
MUX3_1output:  mux3_1 PORT MAP(
	X => PCout,
	Y => OPr2,
	Z => IRout(7 downto 0),
	S => Ms,
	M => ADDR);

IR_process:  IR PORT MAP(
	IRin => Data_in,
	 Clk => clk,
	 IRld => IRld,
	 IRout => IRout);

PC_process:  PC PORT MAP(
	PCin => IRout,
		 Clk => Clk,
		 PCclr => PCclr, 
		 PCinc => PCinc , 
		 PCld => PCld,
		PCout => PCout);

controller_process: controller port map(
		Reset => Reset,
		clk => Clk,
		IR_in => IRout,
		ALUz => ALUz,
		RFs => RFs, 
		ALUs => ALUs,
		Mre => Mre, 
		Mwe =>Mwe, 
		IRld => IRld,
		PCld => PCld,
		PCinc => PCinc,
		PCclr => PCclr,
		Ms => Ms,
		RFwa => RFwa,
		OPR1a => OPR1a, 
		OPR2a => OPR2a,
		RFwe =>RFwe,  
		OPR1e => OPR1e,
		OPr2e => OPr2e);


END struct;