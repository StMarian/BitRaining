-------------------------------------------------------------------------------
--
-- Title       : Form_output
-- Design      : game_1
-- Author      : Kp0c
-- Company     : SYGMA. Inc
--
-------------------------------------------------------------------------------
--
-- Description : formats final output text
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity form_output_v2 is
	port(
		CLK : in STD_LOGIC;
		IS_DEC : in STD_LOGIC;
		DEC_OUT : in STD_LOGIC_VECTOR(16 downto 0);
		TEXT_OUT : in STD_LOGIC_VECTOR(41 downto 0);
		FORMAT_OUT : out STD_LOGIC_VECTOR(41 downto 0)
		);
end form_output_v2;

architecture behavioral of form_output_v2 is
	
	--types
	type intArr is array (6 downto 0) of integer;
	type outputSignal is array (0 to 10) of std_logic_vector(6 downto 0);
	--constants
	constant out_zero: 	std_logic_vector(6 downto 0) := "0111111";
	constant out_one: 	std_logic_vector(6 downto 0) := "0000110";
	constant out_two:	std_logic_vector(6 downto 0) := "1011011";
	constant out_three: std_logic_vector(6 downto 0) := "1001111";
	constant out_four: 	std_logic_vector(6 downto 0) := "1100110";
	constant out_five: 	std_logic_vector(6 downto 0) := "1101101";
	constant out_six: 	std_logic_vector(6 downto 0) := "1111101";
	constant out_seven: std_logic_vector(6 downto 0) := "0000111";
	constant out_eight: std_logic_vector(6 downto 0) := "1111111";
	constant out_nine: 	std_logic_vector(6 downto 0) := "1101111";
	constant out_fail:  std_logic_vector(6 downto 0) := "1110001";	
	constant IndicatorSignals :	outputSignal := (out_zero, out_one, out_two, out_three, out_four, out_five, out_six,
	out_seven, out_eight, out_nine, out_fail);
	
begin 		  
	process(CLK)
		--variables
		variable x : integer;
		variable i : integer;
		variable remX : integer;
		variable intArray : intArr;
		variable output : std_logic_vector(41 downto 0);
	begin  
		
		if rising_edge(CLK) then
			
			if IS_DEC = '0' then
				FORMAT_OUT <= not TEXT_OUT;	-- already formated text
			else

				for k in 0 to 5 loop
					intArray(k) := 0;
				end loop;
				
				output := (others => '0');
				x:= conv_integer(DEC_OUT);		
				
				i:=0;
				while x > 9 loop
					remX := x rem 10;
					x:= (x-remX)/10;
					intArray(i):=remX;
					i:=i+1;
					if i > 5 then
						exit;
					end if;
				end loop;
				
				intArray(i):=x;
				
				for k in 5 downto 0 loop
					output(7*(k+1)-1 downto 7*k) := IndicatorSignals(intArray(k));
				end loop;				
				
				FORMAT_OUT <= not output;
			end if;	
		end if;	
	end process;
end behavioral;
