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
--the entity is name as ComputeLatch
entity ComputeLatch is
--this is the input and output
 Port ( Q: in std_logic_vector (20 downto 0);
	Latch: out std_logic);
end ComputeLatch;

architecture Behavioral of ComputeLatch is
begin

  Latch_proc : process (Q)
  begin
--latch=1 when 0<Q<600cycle
  if (Q>="000000000000000000000") and (Q<"000000000001001011000") then --600 cycles 12us
     Latch <= '1';
  else
     Latch <= '0';
  end if;

  end process Latch_proc;


end behavioral;	