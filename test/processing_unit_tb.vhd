-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Processing_unit_tb is
end Processing_unit_tb;

architecture testbench of processing_unit_tb is

  signal ALU_src_b, wr_src_b, wr_en_b, reg_wr_b : std_logic := '0';
  signal imm_b : std_logic_vector(7 downto 0) := (others => '0');
  signal RA_b, RB_b, RW_b : std_logic_vector(3 downto 0) := (others => '0');

  signal OP_b : std_logic_vector(1 downto 0) := "00";
  signal N_b : std_logic := '0';
  signal clk_b : std_logic := '0';

  signal done : boolean := False;

  begin

    UTT: entity work.processing_unit port map(
        clk => clk_b,
        ALUSrc => ALU_src_b,
        WrSrc => wr_src_b,
        WrEn => wr_en_b,
        RegWr => reg_wr_b,
        imm => imm_b,
        RA => RA_b,
        RB => RB_b,
        RW => RW_b,
        OP => OP_b,
        N => N_b
    );

  clk_b <= '0' when done else (not clk_b) after 50 ns;

  stimuli : process
	begin

	wait for 10 ns;

	-- for the test please uncomment the following lines in the file matrix_reg.vhd
	--RegMeme(0)  :=X"00000010";
	--RegMem(4)   :=X"00000020";
	--RegMem(15)  :=X"00000030";

	-- Test reg_mem
	reg_wr_b <= '1';               -- on ecrit dans RegMem
	RA_b <= "0000";		          -- Banc(0) = 0x10
	RB_b <= "0001";		          -- Banc(1) = 0x00
	RW_b <= "0001";		          -- Banc(1) <= 0x10
	imm_b <= (others => '0');	  -- not used
	ALU_src_b <= '0';  	          -- Selectionner le Bus B
	OP_b <= "00";		          -- somme : 0x10 + 0x00
	wr_en_b <= '0';		          -- on ne va pas ecrire dans DataMemory
	wr_src_b <= '0'; 	          -- On selectionne ALUOut
	wait for 100 ns;


	-- Test Immediat
    	reg_wr_b <= '1';		  -- on ecrit dans RegMem
	RA_b <= "0001";		          -- Banc(0) = 0x10
	RB_b <= "0000";		          --
	RW_b <= "0010";		          -- Banc(2) <= 0x18
	imm_b <= "00001000";	      -- Imm = 0x08
	ALU_src_b <= '1';  	          -- Selectionner Imm
	OP_b <= "00";		          -- somme
	wr_en_b <= '0';		          -- on ne va pas ecrire dans data_memory
	wr_src_b <= '0'; 	          -- On selectionne ALUOut
    wait for 100 ns;


    -- Test data_memory (Write)
    reg_wr_b <= '0';		      -- on n'ecrit pas dans RegMem
	RA_b <= "0011";		          -- Banc(0) <= 0x00 (A = adresse)
	RB_b <= "0010";		          -- Banc(3) = 0x18 (B - donnee)
	RW_b <= "0011";		          -- on n'ecrit pas dans RegMem
	imm_b <= "00000000";	      -- Not used
	ALU_src_b <= '0';  	          -- Selectionner bus_B
	OP_b <= "11";		          -- Y = A
	wr_en_b <= '1';		          -- on va ecrire dans data_memory
	wr_src_b <= '0'; 	          -- Not used
    wait for 100 ns;

	-- Test data_memory (Read)
	reg_wr_b <= '1';		      -- on ecrit dans RegMem
	RA_b <= "1000";		          -- Banc(8) = 0x00
	RB_b <= "0000";		          -- on n'ecrit pas dans DataMem
	RW_b <= "1111";		          -- Banc(15) <= RegMem(0) := 0x18
	imm_b <= "00000000";	      -- Imm = 0x00
	ALU_src_b <= '0';  	          -- Not used
	OP_b <= "11";		          -- Y = A
	wr_en_b <= '0';		          -- on ne va pas ecrire dans data_memory
	wr_src_b <= '1'; 	          -- On selectionne data_mem_out
    wait for 100 ns;

    done <= True;
    wait;
    end process;
end architecture ;
