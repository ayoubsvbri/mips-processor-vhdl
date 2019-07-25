-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;

entity extender_8v32 is
    generic(
        N : integer := 8
    );
    port(
        E : in std_logic_vector((N - 1) downto 0);
	    S : out std_logic_vector(31 downto 0)
    );
end entity extender_8v32;

architecture RTL of extender_8v32 is

begin

	S <= SXT(E,S'length);

end architecture RTL;
