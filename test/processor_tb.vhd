-- Author : Ayoub SABRI
-- single-cycle MIPS processor
-- Polytech Sorbonne

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity processor_tb is
end processor_tb;

architecture testbench of processor_tb is

    signal clk_b: std_logic := '1';
    signal rst_b: std_logic := '0';
    signal done : boolean := False;

begin

    UTT: entity work.processor_monocycle port map(
        clk => clk_b,
        rst => rst_b
    );

    clk_b <= '0' when done else (not clk_b) after 50 ns;

    stimuli : process
	begin

	rst_b <= '0';
	wait for 100 us;
	done <= True;
    wait;

    end process;
    
end architecture;
