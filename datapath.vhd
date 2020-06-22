-- Nguyen Kiem Hung
-- datapath for microprocessor

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.CPU_16bit_lib.all;

entity data_path is
  Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( -- you will need to add more ports here as design grows
          CLK, RFwe, OPr1e, OPr2e: in STD_LOGIC;
			 ALUz: out STD_LOGIC;
			 RFwa, OPr1a, OPr2a: in STD_LOGIC_VECTOR(3 downto 0);
	       IRout     : in std_logic_vector(7 downto 0);
			 RFs, ALUs : in std_LOGIC_VECTOR(1 downto 0);
	       Data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
          Data_out, OPr2_out: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
          );
end data_path;

architecture struct of data_path is
SIGNAL RFin, ALUr, OPr2, OPr1: STD_LOGIC_VECTOR(15 DOWNTO 0);

begin
	MUX3_1output:  mux3_1 PORT MAP(
	X => Data_in,
	Y => ALUr,
	Z => IRout,
	S => RFs,
	M => RFin);

	RF: register_file PORT MAP(
	RFin => RFin,
	RFwa => RFwa,
	OPr1a => OPr1a,
	OPr2a => OPr2a, 
	RFwe => RFwe,
	OPr1e => OPr1e,
	OPr2e => OPr2e,
	Clk => CLK,
	OPr2 => OPr2,
	OPr1 => Opr1);
	
	OPr2_out <= OPr2;
	Data_out <= OPr1;
	
	ALUoutput: ALU PORT MAP(
	OPr1 => OPr1,
	OPr2 => OPr2,
		ALUs => ALUs,
		ALUz => ALUz,
		ALUr => ALUr);

end struct;


