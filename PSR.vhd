-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity PSR is
    generic(
        N_bit : integer := 32
    );
    port(
        data_in : in std_logic;
        data_out : out std_logic_vector((N_bit - 1) downto 0);
        clk, rst, WE : in std_logic
    );
end PSR;

architecture behav of PSR is

begin

    process(clk,rst)
    begin
        if rst = '1' then
            data_out <= (others => '0');

        elsif rising_edge(clk) then
            if WE = '1' then
                if (data_in = '1') then
                    data_out <= ( 0 => '1', others => '0');
                else
                    data_out <= (others => '0');
                end if;
            end if;
        end if;
    end process;
end behav;
