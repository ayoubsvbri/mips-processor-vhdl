-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity instruction_management_unit is
	generic(
        N_bit : integer := 32
    );
	port(
		clk, rst, nPC_sel : in std_logic;
		offset : in std_logic_vector(23 downto 0);			-- jump value
		instruction : out std_logic_vector((N_bit - 1) downto 0)
	);
end entity instruction_management_unit;

architecture structural of instruction_management_unit is

	signal PC_new, offset_ext : std_logic_vector((N_bit - 1) downto 0);
	signal PC_to_mem: std_logic_vector((N_bit - 1) downto 0):=(others => '0');

begin

	Instruction_Memory : entity work.instruction_memory port map(
		PC => PC_to_mem,
		instruction => instruction
	);

	PC_register : entity work.PC_register port map(
		clk => clk,
		rst => rst,
		data_in => PC_new,
		data_out => PC_to_mem
	);

	EXT : entity work.extender_24v32 port map(
		E => offset,
		S => offset_ext
	);

	UPDATE_PC : entity work.update_PC port map(
		nPC_sel => nPC_sel,
		offset_ext => offset_ext,
		data_in => PC_to_mem,
		data_out => PC_new
	);

end architecture structural;
