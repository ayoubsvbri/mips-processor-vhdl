-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Processing_Unit is
	generic(
		N_bit : integer := 32
	);
	port(
		clk, ALU_src, wr_src, wr_en, reg_wr : in std_logic;
		imm : in std_logic_vector(7 downto 0);
		RA, RB, RW : in std_logic_vector(3 downto 0);
		OP : in std_logic_vector(1 downto 0);
		N : out std_logic
	);
end entity Processing_Unit;

architecture structural of Processing_Unit is

signal bus_A, bus_B, bus_W, ext_to_mux, mux_to_ALU, ALU_out, dataMem_to_mux : std_logic_vector((N_bit - 1) downto 0);

begin

c_ALU : entity work.ALU port map(
	OP => OP,
	A => bus_A,
	B => mux_to_ALU,
	Y => ALU_out,
	N => N
);


c_Matrice_Registres : entity work.matrix_reg port map(
	clk => clk,
	W => bus_W,
	RA => RA,
	RB => RB,
	RW => RW,
	WE => reg_wr,
	A => bus_A,
	B => bus_B
);


c_extender : entity work.extender_8v32 port map (
	E => imm,
	S => ext_to_mux
);


c_MUX_in : entity work.MUX_2v1 port map (
	A => bus_B,
	B => ext_to_mux,
	COM => ALU_src,
	S => mux_to_ALU
);


c_MUX_out : entity work.MUX_2v1 port map (
	A => ALU_out,
	B => dataMem_to_mux,
	COM => wr_src,
	S => bus_W
);


c_data_memory : entity work.data_memory port map (
	clk => clk,
	addr => ALU_out(5 downto 0),
	wr_en => wr_en,
	data_in => bus_B,
	data_out => dataMem_to_mux
);

end architecture structural;
