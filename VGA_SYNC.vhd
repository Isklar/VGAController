library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

---------------------------------------------------------------
-- Entity Statement
---------------------------------------------------------------
entity VGA_SYNC is
  port(
    Clk: in std_logic;
    Reset: in std_logic;
    pixel_x: out std_logic_vector(9 downto 0);  -- Horizontal counter output
    pixel_y: out std_logic_vector(9 downto 0);  -- Veritcal counter output
    h_sync: out std_logic;
    v_sync: out std_logic;
    vid_on: out std_logic );

end VGA_SYNC;

---------------------------------------------------------------
-- Architecture
---------------------------------------------------------------
architecture behav of VGA_SYNC is
  
---------------------------------------------------------------
-- signal declarations 
---------------------------------------------------------------
  signal hcount : std_logic_vector(9 downto 0); -- Local horizontal counter
  signal vcount : std_logic_vector(9 downto 0); -- Local vertical counter
  
begin
  pixel_x <= hcount;
  pixel_y <= vcount;
---------------------------------------------------------------
-- Clock Process
---------------------------------------------------------------
  process(Clk, Reset)
    begin
      -- Async reset
      if Reset = '1' then
         hcount <= (others =>'0');
         vcount <= (others =>'0');
         h_sync <= '1';
         v_sync <= '1';
    
      -- Rising edge clock checker 
      elsif clk'event and clk='1' then
        
        
        -- Horizontal counter limits
         if hcount < 799 then
           hcount <= hcount + 1;
         else 
           -- Vertical counter limits
           if vcount > 524 then 
               vcount <= (others =>'0');
           end if;
            
           -- Reset horizontal counter and increment vertical
           hcount <= (others =>'0');
           vcount <= vcount + 1;

         end if;
        
         
         -- Video on limits (Vertical and Horizontal)
         if ((hcount >= 0 AND hcount < 639) AND (vcount >=0 AND vcount < 479)) then
            vid_on <= '1';
         else 
            vid_on <= '0';
         end if;
         
         -- Horizontal sync limits
         if (hcount > 654 AND hcount < 751) then
            h_sync <= '0';
         else 
            h_sync <= '1';
         end if;
         
         -- Vertical sync limits
         if (vcount > 488 AND vcount < 491) then
            v_sync <= '0';
         else 
            v_sync <= '1';
         end if;
         
       end if;
        
  end process;
 end behav;