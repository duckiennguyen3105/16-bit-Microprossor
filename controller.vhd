library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;


entity controller is
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
     	  Ms: out std_LOGIC_VECTOR(1 downto 0);
     	    -- add ports as required here
        RFwa, OPR1a, OPR2a: out std_LOGIC_VECTOR(3 downto 0);
        RFwe, OPR1e, OPR2e : out std_logic);
end controller;

architecture behavioral of controller is
-- types and signals are declared here  
	type fsm is (RESET_STATE, FETCH, FETCH1, FETCH2, DECODE, MOV1_r, MOV1_w, MOV2_r, MOV2_w, 
	MOV3_r, MOV3_w, MOV4_r, ADD_r, ADD_w, SUB_r, SUB_w, JPZ_r, JPZ_w);
	signal current_state, next_state: fsm;
	signal rn, rm, OPCODE : STD_LOGIC_VECTOR(3 downto 0);

begin
rn <= IR_in(11 downto 8);
rm <= IR_in(7 downto 4);
OPCODE <= IR_in(15 downto 12);
	-- state transition
  FSM_trans:process(clk,Reset)  
      begin  
           if(Reset = '1') then  
                current_state <= RESET_STATE;  
           else
					if (rising_edge(clk)) then  
					 current_state <= next_state;  
					end if;
           end if;  
      end process; 
  FSM_control:process(current_state,IR_in)
       begin
		 case(current_state) is
			when RESET_STATE =>
				PCclr <='1';
				PCld <= '0';
         			next_state <= FETCH;
			when FETCH =>
				OPR1e <= '0';
				OPR2e <= '0';
				Mwe <= '0';
				RFwe <= '0';
				Ms <= "10";
				Mre <='1';
				PCclr <= '0';
				next_state <= FETCH1;
			when FETCH1 =>
				IRld <= '1';
				next_state <= FETCH2;
			when FETCH2 =>
				PCinc <= '1';
				next_state <= DECODE;
			when DECODE =>
				PCinc <= '0';
				case OPCODE is
					when "0000" => next_state <= MOV1_r;
					when "0001" => next_state <= MOV2_r;
					when "0010" => next_state <= MOV3_r;
					when "0011" => next_state <= MOV4_r;
					when "0100" => next_state <= ADD_r;
					when "0101" => next_state <= SUB_r;
					when "0110" => next_state <= JPZ_r;
					when others => null;
					end case;
			when MOV1_r =>
				Ms <= "01";
				Mre <= '1';
				next_state <= MOV1_w;
			when MOV1_w =>
				RFs <= "10";
				RFwa <= rn;
				RFwe <= '1';
				next_state <=  FETCH;
			when MOV2_r =>
				OPR1a <= rn;
				OPR1e <= '1';
				next_state <= MOV2_w;
			when MOV2_w =>
				Mre <= '0';
				Ms <= "01";
				Mwe <= '1';
				next_state <= FETCH;
			when MOV3_r =>
				OPR1a <= rn;
				OPR1e <= '1';
				OPR2a <= rm;
				OPR2e <= '1';
				next_state <= MOV3_w;
			when MOV3_w =>
				Mre <= '0';
				Ms <= "00";
				Mwe <= '1';
				next_state <= FETCH;
			when MOV4_r =>
				RFs <= "01";
				RFwa <= rn;
				RFwe <= '1';
				next_state <= FETCH;
			when ADD_r =>
				OPR1a <= rn;
				OPR1e <= '1';
				OPR2a <= rm;
				OPR2e <= '1';
				next_state <= ADD_w;
			when ADD_w =>
				RFs <= "00";
				RFwa <= rn;
				RFwe <= '1';
				ALUs <= "00";
				next_state <= FETCH;
			when SUB_r =>
				OPR1a <= rn;
				OPR1e <= '1';
				OPR2a <= rm;
				OPR2e <= '1';
				next_state <= SUB_w;
			when SUB_w =>
				RFs <= "00";
				RFwa <= rn;
				RFwe <= '1';
				ALUs <= "01";
				next_state <= FETCH;
			when JPZ_r =>
				OPR1a <= rn;
				OPR1e <= '1';
				next_state <= JPZ_w;
			when JPZ_w =>
				PCld <= ALUz;
				PCclr <= '1';
				next_state <= FETCH;
				
			end case;
		 end process;
end behavioral;
