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
--the entitiy is name ComputeValid
entity ComputeValid is
--This is the input and output
 Port ( Q: in std_logic_vector (20 downto 0);
	Valid: out std_logic);
end ComputeValid;

architecture Behavioral of ComputeValid is
begin

  Valid_proc : process (Q)
  begin

-- data is not valid for the period of time shifting happens
-- for safety, 2 more clock cycles are not considered valid. after that it is :)
-- valid=1 when Q>5402
  if(Q>="000000000000000000000") and (Q<"000000001010100011010") then
     Valid <= '0';  
  else
     Valid <= '1';
  end if;

  end process Valid_proc;


end behavioral;	