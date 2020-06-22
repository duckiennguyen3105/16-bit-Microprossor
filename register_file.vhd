LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE work.CPU_16bit_lib.all;

ENTITY register_file IS
PORT (RFin: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RFwa,OPr1a,OPr2a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		RFwe,OPr1e,OPr2e, Clk : IN STD_LOGIC;
		OPr2,OPr1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END  register_file;

ARCHITECTURE Behavior OF register_file IS
SIGNAL R0out,R1out,R2out,R3out,R4out,R5out,R6out,R7out,R8out,
R9out,R10out,R11out,R12out,R13out,R14out,R15out,RFId: STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
--decoder4-16
	decoder4_16_u: decoder4_16 port map(
		RFwa => RFwa,
		RFwe => RFwe,
		RFId => RFId);

--rf[0]
	rf00: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(0),
	Clk => Clk,
	Rout => R0out);

--rf[1]
	rf01: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(1),
	Clk => Clk,
	Rout => R1out);

--rf[2]
	rf02: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(2),
	Clk => Clk,
	Rout => R2out);
	
--rf[3]
	rf03: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(0),
	Clk => Clk,
	Rout => R3out);

--rf[4]
	rf04: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(4),
	Clk => Clk,
	Rout => R4out);

--rf[5]
	rf05: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(5),
	Clk => Clk,
	Rout => R5out);

--rf[6]
	rf06: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(6),
	Clk => Clk,
	Rout => R6out);

--rf[7]
	rf07: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(7),
	Clk => Clk,
	Rout => R7out);

--rf[8]
	rf08: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(8),
	Clk => Clk,
	Rout => R8out);

--rf[9]
	rf09: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(9),
	Clk => Clk,
	Rout => R9out);

--rf[10]
	rf10: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(10),
	Clk => Clk,
	Rout => R10out);

--rf[11]
	rf11: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(11),
	Clk => Clk,
	Rout => R11out);

--rf[12]
	rf12: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(12),
	Clk => Clk,
	Rout => R12out);

--rf[13]
	rf13: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(13),
	Clk => Clk,
	Rout => R13out);

	--rf[14]
	rf14: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(14),
	Clk => Clk,
	Rout => R14out);

--rf[15]
	rf15: rf16 PORT MAP(
	RFin => RFin,
	RFld => RFId(15),
	Clk => Clk,
	Rout => R15out);

--16x1 Mux
	Mux1: mux16_1 PORT MAP(
	Clk => Clk,
	OPre => OPr1e,
	R0 => R0out,
	R1 => R1out,
	R2 => R2out,
	R3 => R3out,
	R4 => R4out,
	R5 => R5out,
	R6 => R6out,
	R7 => R7out,
	R8 => R8out,
	R9 => R9out,
	R10 => R10out,
	R11 => R11out,
	R12 => R12out,
	R13 => R13out,
	R14 => R14out,
	R15 => R15out,
	OPra => OPr1a,
	M => OPr1);

	Mux2: mux16_1 PORT MAP(
	Clk => Clk,
	OPre => OPr2e,
	R0 => R0out,
	R1 => R1out,
	R2 => R2out,
	R3 => R3out,
	R4 => R4out,
	R5 => R5out,
	R6 => R6out,
	R7 => R7out,
	R8 => R8out,
	R9 => R9out,
	R10 => R10out,
	R11 => R11out,
	R12 => R12out,
	R13 => R13out,
	R14 => R14out,
	R15 => R15out,
	OPra => OPr2a,
	M => OPr2);



END Behavior;

