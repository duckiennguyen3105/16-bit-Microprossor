--This confidential and proprietary software may be used
--only as authorized by a licensing agreement from
--Laboratory for Smart Integrated Systems (SIS), VNU University of Engineering and Technology (VNU-UET).
-- (C) COPYRIGHT 2015
-- ALL RIGHTS RESERVED
-- The entire notice above must be reproduced on all authorized copies.
--
-- Filename : RCA_define.v
-- Author : Hung Nguyen
-- Date : 
-- Version : 0.1
-- Description Package declares all constants, types, 
-- and components for project.               
-- Modification History:
-- Date By Version Change Description
-- ========================================================
-- 05/08.2014  0.1 Original
-- ========================================================
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all ;
use std.textio.all;

package CPU_16bit_lib is

component dpmem is
  generic (
    DATA_WIDTH        :     integer   := 16;     -- Word Width
    ADDR_WIDTH        :     integer   := 16      -- Address width
    );

  port (
    -- Writing
    Clk              : in  std_logic;          -- clock
	nReset             : in  std_logic; -- Reset input
    addr              : in  std_logic_vector(ADDR_WIDTH -1 downto 0);   --  Address
	-- Writing Port
	Wen               : in  std_logic;          -- Write Enable
    Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');   -- Input Data
    -- Reading Port
    
    Ren               : in  std_logic;          -- Read Enable
    Dataout           : out std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data
    
    );
end component dpmem;

--cpu--
component cpu is
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
end component cpu;

--control_unit--
component control_unit is             	
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
end component control_unit;

component mux3_1 IS
PORT ( X,Y : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Z : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		M : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END component mux3_1;

component PC IS
PORT ( PCin : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Clk, PCclr, PCinc, PCld : IN STD_LOGIC;
		PCout : buffer STD_LOGIC_VECTOR(15 DOWNTO 0));
END component PC;

component IR IS
PORT ( IRin : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Clk, IRld : IN STD_LOGIC;
		IRout : buffer STD_LOGIC_VECTOR(15 DOWNTO 0));
END component IR;

component controller is             	
  Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port (--you will need to add more ports here as design grows
        Reset   : in STD_LOGIC; -- low active reset signal
        clk   : in STD_LOGIC;    -- Clock
        IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
         -- status signals from ALU
        ALUz  : in std_logic; 
        RFs, ALUs    : out std_logic_vector(1 downto 0);
        Mre, Mwe, IRld, PCld, PCinc, PCclr : out std_logic;
     	  Ms : out std_LOGIC_VECTOR(1 downto 0);
     	    -- add ports as required here
        RFwa, OPR1a, OPR2a: out std_LOGIC_VECTOR(3 downto 0);
        RFwe, OPR1e, OPr2e : out std_logic);
end component controller;
-----------------
--datapath--
component data_path is
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
end component data_path;



COMPONENT ALU 
PORT ( OPr1, OPr2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ALUs : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUz : OUT STD_LOGIC;
		ALUr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT ALU;

COMPONENT decoder4_16
PORT(
		RFwa : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		RFwe : IN STD_LOGIC;
		RFId : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT decoder4_16;


COMPONENT mux16_1
PORT(
		R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		OPra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Clk,OPre : IN STD_LOGIC;
		M : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT mux16_1;



COMPONENT rf16
	Port ( 
		RFin : in std_logic_vector(15 downto 0);
		RFld, Clk : in std_logic;
		Rout : out std_logic_vector(15 downto 0)
	);
end COMPONENT rf16;

COMPONENT register_file
PORT (RFin: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RFwa,OPr1a,OPr2a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		RFwe,OPr1e,OPr2e, Clk : IN STD_LOGIC;
		OPr2,OPr1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT register_file;

-----------------
end CPU_16bit_lib;

PACKAGE BODY CPU_16bit_lib IS
	-- package body declarations

END PACKAGE BODY CPU_16bit_lib;