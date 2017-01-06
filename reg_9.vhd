---------------------------------------------------------------------------
--  Copyright (C) 2010 Rajarshi Roy                                      --
--                                                                       --
--  Copying and distribution of this file, with or without modification, --
--  are permitted in any medium without royalty provided the copyright   --
--  notice and this notice are preserved.                                --
--                                                                       --
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--reg9 unit entitity is name as reg_9
entity reg_9 is
--This is the input and output
 Port ( Clk: in std_logic;
	Reset: in std_logic;
	D: in std_logic_vector(8 downto 0);
	Shift_In: in std_logic;
	Load: in std_logic;
	Shift_En: in std_logic;
	Shift_Out: out std_logic;
	Data_Out: out std_logic_vector(8 downto 0));
end reg_9;

architecture Behavioral of reg_9 is
	signal reg_value: std_logic_vector(8 downto 0);
begin
--This is the code that control the reg_9
	operate_reg: process (Clk, Reset, Load, Shift_En, Shift_In)
	begin
	   if (Reset='1') then --Asynchronous Reset
		reg_value <="000000000";-- All your data storage should have a
				 -- construct that looks like this
	   elsif(rising_edge(Clk)) then
	      if(Shift_En='1') then
		reg_value<=Shift_In & reg_value(8 downto 1);
	      elsif (Load='1') then
		reg_value<=D;
	      else
		reg_value<=reg_value;
		end if;
	end if;
	end process;

	Data_Out<=reg_value;
	Shift_Out<=reg_value(0);

end Behavioral;