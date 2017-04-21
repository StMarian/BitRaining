-------------------------------------------------------------------------------
--
-- Title       : State_machine
-- Design      : game_1
-- Author      : Kp0c
-- Company     : SYGMA. Inc
--
-------------------------------------------------------------------------------
--
-- Description : state machine for the game 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity State_machine is
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
end State_machine;

architecture State_machine of State_machine is
	
	--types
	type state_type is (SELECT_LEVEL, IN_GAME, FINISH);	
	type LvlMasksType is array (0 to 2) of std_logic_vector(9 downto 0);
	--variables
	constant level_masks : LvlMasksType := ("0000001111","0001111111","1111111111");    
	constant S : std_logic_vector (6 downto 0) := "1101101";  
	constant U : std_logic_vector (6 downto 0) := "0111110";
	constant C : std_logic_vector (6 downto 0) := "0111001"; 
	constant E : std_logic_vector (6 downto 0) := "1111001"; 
	constant L : std_logic_vector (6 downto 0) := "0111000";
	constant \_\ : std_logic_vector (6 downto 0) := "0001000";
	constant succes : std_logic_vector(41 downto 0) := S & U & C & C & E & S;
	constant sel_lv : std_logic_vector(41 downto 0) := S & E & L & \_\ & L & U;
	--signals
	signal state : state_type;
	
begin
	state_proc:
		process ( CLK, RESET )
		variable generatedNumber 	: std_logic_vector(9 downto 0);
	begin
		if RESET = '1' then
			state <= SELECT_LEVEL;
		elsif rising_edge(CLK) then
			case state is 
				--====================================================================================================
				when SELECT_LEVEL =>
					
					IS_DEC <= '0';
					TEXT_OUT <= sel_lv;
					
					case KEYS is	
						when "001" => 
							state <= IN_GAME;
							generatedNumber := RANDOM_NUMBER and level_masks(0);
						when "010" => 
							state <= IN_GAME; 
							generatedNumber := RANDOM_NUMBER and level_masks(1);
						when "100" =>
							state <= IN_GAME;
							generatedNumber := RANDOM_NUMBER and level_masks(2);  
						when others => null;
					end case;	
					
				--====================================================================================================
				when IN_GAME =>
					
					IS_DEC <= '1';
					DEC_OUT <= "0000000" & generatedNumber; 
					if SW = generatedNumber and (KEYS = "100" or KEYS = "010" or KEYS = "001") then --!WIN!
						state <= FINISH;
					end if;
					
				--====================================================================================================
				when FINISH =>
					
					IS_DEC <= '0';
					TEXT_OUT <= succes;
					end if;
					
				--====================================================================================================
				when OTHERS => null;
				end 
			case;
		end if;	
	end process;	
end State_machine;
