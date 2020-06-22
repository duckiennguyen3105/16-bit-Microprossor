-- Nguyen Kiem Hung
-- cpu : the top level entity

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.CPU_16bit_lib.all;

-- 
entity cpu is
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( Reset   : in STD_LOGIC; -- low active reset signal
          clk   : in STD_LOGIC;    -- Clock
	       Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	       ALU_out : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     	   
     	   -- control signals for accessing to memory
     	   Mre, Mwe : out std_logic
     	    -- add ports as required here
        );
end cpu;


architecture struc of cpu is

-- declare internal signals here
signal IRout: std_LOGIC_VECTOR(15 downto 0);
signal OPr2: std_LOGIC_VECTOR(15 downto 0);
signal RFwa, OPR1a, OPR2a: std_LOGIC_VECTOR(3 downto 0);
signal RFwe, OPR1e, OPr2e : std_logic;
signal RFs, ALUs    : std_logic_vector(1 downto 0);
signal ALUz  : std_logic; 
		
begin

control_unit_cpu: control_unit port map(
		Reset => Reset,
      clk => clk,
		Data_in => IR_in,
		IRout => IRout,
		OPr2 => OPr2,
		ADDR => Addr_out,
		RFwa => RFwa,
		OPR1a => OPR1a,
		OPR2a => OPR2a,
      RFwe => RFwe,
		OPR1e => OPR1e,
		OPr2e => OPr2e,
		RFs => RFs,
		ALUs => ALUs,
		ALUz => ALUz, 
		Mre => Mre,
		Mwe => Mwe);

data_path_cpu: data_path port map( 
          CLK => clk,
			 RFwe => RFwe,
			 OPr1e => OPR1e, 
			 OPr2e => OPR2e,
			 ALUz => ALuz,
			 RFwa => RFwa,
			 OPr1a => OPR1a,
			 OPr2a => OPR2a,
	       IRout => IRout(7 downto 0),
			 RFs => RFs,
			 ALUs => ALUs,
	       Data_in => IR_in,
          Data_out => ALU_out,
			 OPr2_out => OPr2);


end struc;




