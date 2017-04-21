-------------------------------------------------------------------------------
--
-- Title       : Random
-- Design      : BitRaining
--
-------------------------------------------------------------------------------
--
-- Description : random generating module
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Random is
	port(
		CLK : in STD_LOGIC;
		generated : out STD_LOGIC_VECTOR(9 downto 0)
		);
end Random;

architecture Random of Random is
begin
	
	process( CLK )
		variable x : std_logic_vector(9 downto 0) := (others => '0');	
	begin  
		if rising_edge(CLK) then
			x := x + '1';		  
		end	if;
		
		generated <= x;
	end process;	 
	
end Random;
