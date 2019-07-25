-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity PC_register is
	port(
		clk, rst : in std_logic;
		data_in : in std_logic_vector(31 downto 0);
		data_out : out std_logic_vector(31 downto 0)
	);
end PC_register;

architecture behav of PC_register is

	signal PC : std_logic_vector(31 downto 0):=(others => '0');

begin

		data_out <= PC;
		process(clk, rst)
		begin
			if rst = '1' then
				PC <= (others => '0');
			elsif rising_edge(clk) then
				PC <= data_in;
			else
				PC <= PC;
			end if;
		end process;

end behav;
