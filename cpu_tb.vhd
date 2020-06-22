library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use WORK.CPU_16bit_lib.ALL;
 
use std.textio.all;
 
entity cpu_tb is

end cpu_tb;

 
 
architecture behavior of cpu_tb is
  Constant   CLKTIME   :       time      := 20 ns;

  signal clk :       std_logic := '0';
  signal Reset :      std_logic := '0';
  signal nReset :      std_logic := '0';
  
  signal addr : std_logic_vector( 15 downto 0);
  signal  wen  :       std_logic;
  signal  datain :  std_logic_vector(15 downto 0);
  
  signal  ren :       std_logic;
 
  signal dataout :   std_logic_vector(15 downto 0);
Begin
-- write your code here
-- Clock generation
 Clk <= not clk after CLKTIME/2;  
-- UUT componenet
dut_pro: cpu 
    Port Map( 
		  Reset => reset, 
        clk => clk,  
	     Addr_out => Addr,
	     IR_in => Datain,
	     ALU_out => dataout,
     	   Mre => Ren,
			Mwe => Wen);

-- Memory
  nReset <= Not Reset;
  dut_mem:  dpmem --dpmem
    port map (  
      clk      => clk,
      nReset   => nReset,
      addr     => addr,
      Wen       => wen,
      Datain    => dataout,
      
      Ren       => ren,
      
      Dataout   => datain
      
      );
---   
  stimuli_proc :  process
  Begin
      -- Reset generation
		  
        Reset  <= '1'; 
        wait for  50 ns;                                         
        Reset  <= '0';
        wait ;
        
        
  end process stimuli_proc;   
End behavior;