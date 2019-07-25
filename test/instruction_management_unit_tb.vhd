-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity instruction_management_unit_tb is
end instruction_management_unit_tb;

architecture bench of instruction_management_unit_tb is

    signal clk, rst, nPC_sel : std_logic := '0';
    signal offset : std_logic_vector(23 downto 0) := (others => '0');
    signal instruction : std_logic_vector(31 downto 0) := (others => '0');
    signal done : boolean := False;

begin

    UTT: entity work.instruction_management_unit port map(
        clk => clk,
        rst => rst,
        nPC_sel => nPC_sel,
        offset => offset,
        instruction => instruction
    );

    clk <= '0' when done else not clk after 50 ns;

    stimuli : process
    begin

    wait for 45 ns;

    nPC_sel <= '0';
    offset <= "000000000000000000000010";

    wait for 100 ns;

    nPC_sel <= '1';
    wait for 100 ns;

    rst <= '1';
    wait for 100 ns;

    rst <= '0';
    offset <= "000000000000000000000011";
    wait for 100 ns;

    nPC_sel <= '0';
    wait for 100 ns;


    done <= True;
    wait;

    end process;
    
end architecture;
