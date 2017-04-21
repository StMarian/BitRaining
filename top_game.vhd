-------------------------------------------------------------------------------
--
-- Title       : top_game
-- Design      : BitRaining
--
-------------------------------------------------------------------------------
--
-- Description : top level of the game
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top_game is
	port(
		RESET : in STD_LOGIC;
		CLK : in STD_LOGIC;
		SW : in STD_LOGIC_VECTOR(9 downto 0);
		KEY : in STD_LOGIC_VECTOR(2 downto 0);
		FORMAT_OUT : out std_logic_vector (41 downto 0)
		);
end top_game;				   			  

architecture top_game of top_game is
	
	component random
		port(
			CLK : in STD_LOGIC;
			generated : out STD_LOGIC_VECTOR(9 downto 0)
			);
	end component;
	
	component state_machine
		port(
		RANDOM_NUMBER : in STD_LOGIC_VECTOR (9 downto 0);
		RESET : in STD_LOGIC;					
		CLK : in STD_LOGIC;
		SW : in STD_LOGIC_VECTOR(9 downto 0);		
		KEYS : in STD_LOGIC_VECTOR (2 downto 0);						  
		DEC_OUT : out std_logic_vector (16 downto 0);
		IS_DEC : out std_logic;
		TEXT_OUT : out std_logic_vector (41 downto 0)
		);
	end component;			
	
	component form_output_v2
		port(
		CLK : in STD_LOGIC;
		DEC_OUT : in std_logic_vector (16 downto 0);
		IS_DEC : in std_logic;
		TEXT_OUT : in std_logic_vector (41 downto 0); 
		FORMAT_OUT : out std_logic_vector (41 downto 0)
		);
	end component;
	
	signal generatedNumber : STD_logic_vector(9 downto 0);
	signal DEC_OUT : std_logic_vector (16 downto 0);
	signal IS_DEC : std_logic;
	signal TEXT_OUT : std_logic_vector (41 downto 0);
	
begin 
	
	SM : state_machine
	port map (generatedNumber, RESET, CLK, SW, KEY, DEC_OUT, IS_DEC, TEXT_OUT);
	
	RNG : random
	port map (CLK, generatedNumber);
	
	FO : form_output
	port map (CLK, DEC_OUT, IS_DEC, TEXT_OUT, FORMAT_OUT);
	
end top_game;
