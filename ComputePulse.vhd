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
--the entity is name as ComputePulse
entity ComputePulse is
--This is the input and output
 Port ( Q: in std_logic_vector (20 downto 0);
	Pulse: out std_logic);
end ComputePulse;

architecture Behavioral of ComputePulse is
begin

  Pulse_proc : process (Q)
  begin

--starts from 18us after initial latch high = 900 cycles
--then pulses with 12us period and duty cycle 50% 
--so pulses for 6us everytime which is 300 clock cycles
  if (Q>="000000000001110000100") and (Q<"000000000010010110000") then -- pulse 1
     Pulse <= '1';
  elsif(Q>="000000000010111011100") and (Q<"000000000011100001000") then --pulse 2
     Pulse <= '1';
  elsif(Q>="000000000100000110100") and (Q<"000000000100101100000") then --pulse 3
     Pulse <= '1';
  elsif(Q>="000000000101010001100") and (Q<"000000000101110111000") then --pulse 4
     Pulse <= '1';
  elsif(Q>="000000000110011100100") and (Q<"000000000111000010000") then --pulse 5
     Pulse <= '1';
  elsif(Q>="000000000111100111100") and (Q<"000000001000001101000") then --pulse 6
     Pulse <= '1';
  elsif(Q>="000000001000110010100") and (Q<"000000001001011000000") then --pulse 7
     Pulse <= '1';
  elsif(Q>="000000001001111101100") and (Q<"000000001010100011000") then --pulse 8
     Pulse <= '1';
    
  else
     Pulse <= '0';
  end if;

  end process Pulse_proc;


end behavioral;	