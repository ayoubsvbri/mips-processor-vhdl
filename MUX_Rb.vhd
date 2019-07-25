-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MUX_Rb is
    generic(
        N : integer := 4
    );
    port(
	   A, B : in std_logic_vector((N-1) downto 0);
       COM : in std_logic;
       S : out std_logic_vector((N-1) downto 0)
    );
end entity MUX_Rb;

architecture RTL of MUX_Rb is

begin

	with COM select S <= A when '0',
			B when '1',
			(others => '0') when others;

end architecture RTL;
