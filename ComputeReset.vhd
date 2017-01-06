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
--The entity is name ComputeReset
entity ComputeReset is
--This is the input and output
 Port ( Q: in std_logic_vector (20 downto 0);
	ResetCount: out std_logic);
end ComputeReset;

architecture Behavioral of computeReset is
begin

  Reset_proc : process (Q)
  begin
--this entity will set ResetCount=1 after 83333 cycle
  if (Q="011001011011100110101") then
     ResetCount <= '1';
  else
     ResetCount <= '0';
  end if;

  end process Reset_proc;


end behavioral;	