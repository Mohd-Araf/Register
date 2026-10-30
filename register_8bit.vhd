library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit is
    Port ( clk   : in  STD_LOGIC;
           rst   : in  STD_LOGIC;                       -- asynchronous, active high
           en    : in  STD_LOGIC;                       -- load enable
           d     : in  STD_LOGIC_VECTOR (7 downto 0);
           q     : out STD_LOGIC_VECTOR (7 downto 0));
end register_8bit;

architecture Behavioral of register_8bit is
    signal q_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
    process (clk, rst)
    begin
        if rst = '1' then
            q_reg <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                q_reg <= d;
            end if;
        end if;
    end process;

    q <= q_reg;
end Behavioral;