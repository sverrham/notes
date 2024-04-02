----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:17:30 04/02/2024 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in  STD_LOGIC;
           led : out  STD_LOGIC_VECTOR(3 downto 0));
end top;

architecture Behavioral of top is

begin

process is
	variable cnt : unsigned(23 downto 0) := X"ffffff";
	variable led_cnt : unsigned(3 downto 0) := x"0";
begin
 if rising_edge(clk) then
	cnt := cnt - 1;
	if cnt = 0 then
		led_cnt := led_cnt + 1;
	end if;
	led <= std_logic_vector(led_cnt);
	
 end if;
end process;

end Behavioral;

