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
--the entity is name Dflipflop
entity Dflipflop is
 port(D,clk,reset: in std_logic;--This is the input and output
	Q:out std_logic);
end Dflipflop;

architecture behavior of Dflipflop is
begin--It takes new data every clock cycle if reset is 0
  process(reset,clk)
  begin
	if reset='1' then
	  Q<='0';
	elsif(rising_edge(clk)) then
	  Q<=D;
	end if;
	end process;
	end behavior;