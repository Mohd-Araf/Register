library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit_tb is
end register_8bit_tb;

architecture sim of register_8bit_tb is
    component register_8bit
        Port ( clk, rst, en : in STD_LOGIC;
               d : in  STD_LOGIC_VECTOR (7 downto 0);
               q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal en  : STD_LOGIC := '0';
    signal d   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal q   : STD_LOGIC_VECTOR (7 downto 0);

    constant CLK_PERIOD : time := 10 ns;
begin
    uut: register_8bit port map (clk => clk, rst => rst, en => en, d => d, q => q);

    clk_process: process
    begin
        clk <= '0'; wait for CLK_PERIOD/2;
        clk <= '1'; wait for CLK_PERIOD/2;
    end process;

    stim_proc: process
    begin
        -- 1. Reset
        rst <= '1'; wait for 12 ns;
        rst <= '0'; wait for 8 ns;

        -- 2. Load 0xA5
        d <= x"A5"; en <= '1'; wait for CLK_PERIOD;

        -- 3. Disable enable: output must hold 0xA5 while d changes
        en <= '0'; d <= x"FF"; wait for 2*CLK_PERIOD;

        -- 4. Load 0x3C
        d <= x"3C"; en <= '1'; wait for CLK_PERIOD;

        -- 5. Asynchronous reset in the middle of a clock cycle
        wait for 3 ns;
        rst <= '1'; wait for 4 ns;
        rst <= '0'; wait for 2*CLK_PERIOD;

        -- 6. Load 0x7E
        d <= x"7E"; wait for CLK_PERIOD;

        wait;
    end process;
end sim;