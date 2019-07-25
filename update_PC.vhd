-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity update_PC is
    generic(
        N_bit : integer := 32
    );
    port(
        nPC_sel : in std_logic;
        offset_ext, data_in : in std_logic_vector((N_bit - 1) downto 0) := (others => '0');
        data_out : out std_logic_vector((N_bit - 1) downto 0)
    );
end update_PC;

architecture behav of update_PC is

begin

    with nPC_sel select

    data_out <= std_logic_vector(to_unsigned(to_integer(unsigned(data_in)) + 1 , N_bit)) when '0',
               std_logic_vector(to_unsigned(to_integer(unsigned(data_in)) + 1 + to_integer(unsigned(offset_ext)), N_bit)) when '1',
               data_in when others;
end behav;
