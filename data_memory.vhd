-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


entity data_memory is
	generic(
		N_bit : integer := 32
	);
	port(
		clk : in std_logic;
		addr : in std_logic_vector(5 downto 0);
		wr_en : in std_logic;
		data_in: in std_logic_vector((N_bit - 1) downto 0);
		data_out: out std_logic_vector((N_bit - 1) downto 0)
	);
end entity data_memory;

architecture behav of data_memory is

	type RamType is array (0 to 63) of std_logic_vector((N_bit - 1) downto 0);

	function init_RAM return RamType is

		variable result : RamType;

		begin
			for i in 63 downto 0 loop
				result(i) := (others => '0');
			end loop;

			-- NOTE: memory initialization, only for test purpose
			result (32):=x"00000001";
			result (33):=x"00000001";
			result (34):=x"00000001";
			result (35):=x"00000001";
			result (36):=x"00000001";
			result (37):=x"00000001";
			result (38):=x"00000001";
			result (39):=x"00000001";
			result (40):=x"00000001";
			result (41):=x"00000001";
			result (42):=x"00000001";

			return result;

	end init_RAM;

	signal RAM: RamType:=init_RAM;

begin

	-- memory write
	write : process(clk)
	begin

		if(rising_edge(clk)) then

			if(wr_en = '1') then
				RAM(to_integer(unsigned(addr))) <= data_in;
			end if;

		end if;

	end process write;

	-- memory read
	data_out <= RAM(to_integer(unsigned(addr)));

end architecture behav;
