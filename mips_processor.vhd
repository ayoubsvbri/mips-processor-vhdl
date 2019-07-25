-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

-- Top level design

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mips_processor is
    generic(
        N_bit : integer := 32
    );
    port(
        clk, rst : in std_logic
    );
end entity mips_processor;

architecture structural of mips_processor is

    signal ALU_src, wr_src, reg_wr, nPC_sel, PSR_en, N, mem_wr, reg_sel : std_logic;
    signal PC_to_mem, PC_new, offset_ext : std_logic_vector((N_bit - 1) downto 0);
    signal instruction, PSR : std_logic_vector((N_bit - 1) downto 0);
    signal imm_8            : std_logic_vector(7 downto 0);
    signal offset           : std_logic_vector(23 downto 0);
    signal RA, RB, RW, Rm   : std_logic_vector(3 downto 0);
    signal ALU_ctr          : std_logic_vector(1 downto 0);

begin

	processing_unit : entity work.processing_unit port map(
		clk           => clk,
		ALU_src       => ALU_src,
		wr_src        => wr_src,
		WrEn          => mem_wr,
		reg_wr        => reg_wr,
		imm           => imm_8,
		RA            => RA,
		RB            => RB,
		RW            => RW,
		OP            => ALU_ctr,
		N             => N);

	Instruction_management_unit : entity work.Instruction_Management_Unit port map(
		clk           => clk,
		rst           => rst,
		nPC_sel       => nPC_sel,
		offset        => offset,
		instruction   => instruction);

	Control_Unit : entity work.control_unit port map(
		instruction   => instruction,
		PSR           => PSR,
		nPC_sel       => nPC_sel,
		reg_wr        => reg_wr,
		ALU_src       => ALU_src,
		PSR_en        => PSR_en,
		mem_wr        => mem_wr,
		wr_src        => wr_src,
		reg_sel       => reg_sel,
		ALU_ctr       => ALU_ctr,
		Rn            => RA,
		Rd            => RW,
		Rm            => Rm,
		offset        => offset,
		imm           => imm_8,
		clk           => clk);

	PSR_component : entity work.PSR port map(
		data_in       => N,
		data_out      => PSR,
		clk           => clk,
		rst           => rst,
		WE            => PSR_en);

	MUX_Rb : entity work.MUX_Rb port map (
		A             => Rm,
		B             => RW,
		COM           => reg_sel,
		S             => RB);
        
end architecture;
