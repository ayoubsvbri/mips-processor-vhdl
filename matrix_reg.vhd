-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity matrix_reg is
	generic(
		N_bit : integer := 32
	);
	port(
		clk : in std_logic;										-- clock
		W : in std_logic_vector((N_bit - 1) downto 0); 			-- data to be write
		RA, RB, RW : in std_logic_vector(3 downto 0); 			-- address
		WE : in std_logic; 										-- write enable
		A, B : out std_logic_vector((N_bit - 1) downto 0) 		-- output buses
	);
end entity matrix_reg;

architecture RTL of matrix_reg is

	type table is array(15 downto 0) of
	std_logic_vector((N_bit - 1) downto 0);

	function init_table return table is

		variable result : table;

		begin
			for i in 14 downto 0 loop
				result(i) := (others => '0');
			end loop;

			-- NOTE: memory initialization, only for test purpose
			result(0)  := X"00000010";
			result(4)  := X"00000020";
			result(15) := X"00000030";
			return result;

	end init_table;

	signal Banc: table:=init_table;

begin

	write : process(clk)
	begin

		if(rising_edge(clk)) then
			if(WE = '1') then
				Banc(to_integer(unsigned(RW))) <= W;
			end if;
		end if;

	end process write;

	-- read
	A <= Banc(to_integer(unsigned(RA)));
	B <= Banc(to_integer(unsigned(RB)));

end architecture RTL;
