library IEEE;
use IEEE.std_logic_1164.all;

---------------------------------------------------------------
-- Entity Statement
---------------------------------------------------------------
entity ClkDiv is
  port (
    clk_in : in std_logic;
    clk_out : out std_logic);
end ClkDiv;

---------------------------------------------------------------
-- Architecture
---------------------------------------------------------------
architecture CLKdivider of ClkDiv is
  signal P : std_logic := '1'; -- Local signal to hold previous clock state
  
begin
  process(clk_in)
   begin
   if clk_in'event and clk_in='1' then
    P <= NOT P; -- Inverter
     clk_out <= P; -- Sets output to local signal
  end if;
  
 end process;
end CLKdivider;
