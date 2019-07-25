-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
    generic(
        N_bit : integer := 32
    );
    port(
        OP : in std_logic_vector (1 downto 0);
        A, B : in std_logic_vector ((N_bit - 1) downto 0);
        Y : out std_logic_vector ((N_bit - 1) downto 0) := (others => '0');
        N : out std_logic
    );
end entity ALU;

architecture RTL of ALU is

    signal A_tmp, B_tmp : integer;
    signal Y_tmp : std_logic_vector((N_bit - 1) downto 0) := (others => '0');

begin

	A_tmp <= to_integer(signed(A));
	B_tmp <= to_integer(signed(B));

	with OP select Y_tmp <= std_logic_vector(to_signed((A_tmp + B_tmp), N_bit)) when "00",
				            std_logic_vector(to_signed((B_tmp), N_bit)) when "01",
				            std_logic_vector(to_signed((A_tmp - B_tmp), N_bit)) when "10",
                            std_logic_vector(to_signed((A_tmp), N_bit)) when "11",
	                        (others => '0') when others;


	N <= Y_tmp((N_bit - 1));
	Y <= Y_tmp;

end architecture RTL;
