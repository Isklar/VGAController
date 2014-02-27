library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
---------------------------------------------------------------
-- Entity Statement
---------------------------------------------------------------

entity 	VGA_SYNC_TB is
end 	   VGA_SYNC_TB;


---------------------------------------------------------------
-- TestBench Architecture
---------------------------------------------------------------

architecture behavior OF VGA_SYNC_TB is 


---------------------------------------------------------------
-- Component Description
---------------------------------------------------------------
component VGA_SYNC is
  port(
    Clk: in std_logic;
    Reset: in std_logic;
    pixel_x: out std_logic_vector(9 downto 0);
    pixel_y: out std_logic_vector(9 downto 0);
    h_sync: out std_logic;
    v_sync: out std_logic;
    vid_on: out std_logic );
end component;

component ClkDiv is
  port (
    clk_in  : in std_logic;
    clk_out : out std_logic);
end component;

---------------------------------------------------------------
-- signal declarations 
---------------------------------------------------------------
 signal Clk50 :std_logic := '0'; -- Local signal for 50MHz clock
 signal Clk25 :std_logic;        -- Local signal for 25MHz Divided clock

 signal Reset_i :std_logic := '1';
 signal pixel_x :std_logic_vector(9 downto 0);
 signal pixel_y :std_logic_vector(9 downto 0);
 signal h_sync :std_logic;
 signal v_sync :std_logic;
 signal vid_on :std_logic;

begin
---------------------------------------------------------------
-- Component Instantiation
---------------------------------------------------------------

-- Port mapping for Clock Divider
uuc: ClkDiv
port map(
  clk_in  => Clk50,  -- Maps Clock divider input to 50MHz local variable
  clk_out => Clk25); -- Maps Clock divider out to 25MHz local variable

-- Port mapping for VGA_SYNC
uut: VGA_SYNC
port map(
  
    Clk     => Clk25,
    Reset   => Reset_i,
    pixel_x => pixel_x,
    pixel_y => pixel_y,
    h_sync  => h_sync,
    v_sync  => v_sync,
    vid_on  => vid_on);

-- Start clock with 20ns period for 50MHz
Clk50 <= not(Clk50) after 10 ns;

-- Begin testbench process
   tb : process 
   
   begin

      wait for 20 ns;
         Reset_i <= '0';
        
      wait; -- will wait forever

   end process;

end;