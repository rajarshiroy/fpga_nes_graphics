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
--the entity is name as big_uo_down_counter
entity big_up_down_counter is--this is the input and output
port ( clk,enable,up_down:in std_logic;
asynch_clr: in std_logic;
Q: out std_logic_vector(20 downto 0));
end entity;

architecture counter_behavior of big_up_down_counter is
signal count: std_logic_vector (20 downto 0);
--count is an internal signal to this process

Begin
process(clk,asynch_clr) --sensitivity list
begin
if(asynch_clr='1') then
count<="000000000000000000000";
elsif(clk'event and clk='1') then --rising edge
	if(enable='1') then
		if(up_down='1') then
		count<=count+"000000000000000000001";
	else
		count<=count-"000000000000000000001";
	end if;
end if;

--end if is not permitted here for elsif
end if;
end process;
Q<=count;
end counter_behavior;