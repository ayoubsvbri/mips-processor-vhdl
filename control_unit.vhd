-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
    generic(
        N_bit : integer := 32
    );
    port(
        instruction,PSR : in std_logic_vector((N_bit - 1) downto 0);
        nPC_sel,reg_wr,ALU_src,PSR_en,mem_wr,wr_src,reg_sel : out std_logic := '0';
        ALU_ctr : out std_logic_vector(1 downto 0):= (others => '0');
        Rn,Rd,Rm : out std_logic_vector(3 downto 0):= (others => '0');
        offset : out std_logic_vector(23 downto 0):= (others => '0');
        imm : out std_logic_vector(7 downto 0):= (others => '0');
        clk : in std_logic
    );

end control_unit;

architecture behav of control_unit is
    type instr is (ADDi,ADDr,BAL,BLT,CMP,LDR,MOV,STR,DEF);
    signal current : instr := DEF;
begin
    process(instruction,PSR)
    begin
      	case instruction((N_bit - 1) downto 20) is
    		when "111000101000" => current <= ADDi;
    		when "111000001000" => current <= ADDr;
    		when "111000111010" => current <= MOV;
    		when "111000110101" => current <= CMP;
    		when "111001100001" => current <= LDR;
    		when "111001100000" => current <= STR;
    		when "111010101111" => current <= BAL;
    		when "101110101111" => current <= BLT;
    		when others => current <= BLT;
    	end case;
    end process;

    process(clk)
    begin
        if falling_edge(clk) then
        case current is
            when ADDi =>
                nPC_sel <= '0';
                reg_wr <= '1';
                ALU_src <= '1';
                ALU_ctr <="00";
                PSR_en <= '0';
                mem_wr <= '0';
                wr_src <= '0';
                reg_sel <= '0';
                Rn <= instruction(19 downto 16) ;
                Rd <= instruction(15 downto 12);
                Rm <= (others => '0');
                offset <= (others => '0');
                imm <= instruction(7 downto 0);
            when ADDr =>
                nPC_sel <= '0';
                reg_wr <= '1';
                ALU_src <= '0';
                ALU_ctr <="00";
                PSR_en <= '0';
                mem_wr <= '0';
                wr_src <= '0';
                reg_sel <= '0';
                Rn <= instruction(19 downto 16);
                Rd <= instruction(15 downto 12);
                Rm <= instruction(3 downto 0);
                offset <= (others => '0');
                imm <= (others => '0');
            when BAL =>
                nPC_sel <= '1';
                reg_wr <= '0';
                ALU_src <= '0';
                ALU_ctr <="00";
                PSR_en <= '0';
                mem_wr <= '0';
                wr_src <= '0';
                reg_sel <= '0';
                Rn <= (others => '0');
                Rd <= (others => '0');
                Rm <= (others => '0');
                offset <= instruction(23 downto 0);
                imm <= (others => '0');
            when CMP =>
                nPC_sel <= '0';
                reg_wr <= '0';
                ALU_src <= '1';
                ALU_ctr <="10";
                PSR_en <= '1';
                mem_wr <= '0';
                wr_src <= '0';
                reg_sel <= '0';
                Rn <= instruction(19 downto 16);
                Rd <= (others => '0');
                Rm <= (others => '0');
                offset <= (others => '0');
                imm <= instruction(7 downto 0);
            when BLT =>
                if(signed(PSR) = 1) then
                  nPC_sel <= '1';
                else
                  nPC_sel <= '0';
                end if;
                reg_wr <= '0';
                ALU_src <= '0';
                ALU_ctr <="00";
                PSR_en <= '0';
                mem_wr <= '0';
                wr_src <= '0';
                reg_sel <= '0';
                Rn <= (others => '0');
                Rd <= (others => '0');
                Rm <= (others => '0');
                offset <= instruction(23 downto 0);
                imm <= (others => '0');
            when LDR =>
                nPC_sel <= '0';
                reg_wr <= '1';
                ALU_src <= '1';
                ALU_ctr <="00";
                PSR_en <= '0';
                mem_wr <= '0';
                wr_src <= '1';
                reg_sel <= '0';
                Rn <= instruction(19 downto 16);
                Rd <= instruction(15 downto 12);
                Rm <= (others => '0');
                offset <= (others => '0');
                imm <= instruction(7 downto 0);
            when MOV =>
                nPC_sel <= '0';
                reg_wr <= '1';
                ALU_src <= '1';
                ALU_ctr <="01";
                PSR_en <= '0';
                mem_wr <= '0';
                wr_src <= '0';
                reg_sel <= '0';
                Rn <= (others => '0');
                Rd <= instruction(15 downto 12);
                Rm <= (others => '0');
                offset <= (others => '0');
                imm <= instruction(7 downto 0);
            when STR =>
                nPC_sel <= '0';
                reg_wr <= '0';
                ALU_src <= '1';
                ALU_ctr <="00";
                PSR_en <= '0';
                mem_wr <= '1';
                wr_src <= '0';
                reg_sel <= '1';
                Rn <= instruction(19 downto 16);
                Rd <= instruction(15 downto 12);
                Rm <= (others => '0');
                offset <= (others => '0');
                imm <= instruction(7 downto 0);
            when DEF =>
                nPC_sel <= '0';
                reg_wr <= '0';
                ALU_src <= '0';
                ALU_ctr <="00";
                PSR_en <= '0';
                mem_wr <= '0';
                wr_src <= '0';
                reg_sel <= '0';
                Rn <= (others => '0');
                Rd <= (others => '0');
                Rm <= (others => '0');
                offset <= (others => '0');
                imm <= (others => '0');
            end case;
        end if;
    end process;
end behav;
