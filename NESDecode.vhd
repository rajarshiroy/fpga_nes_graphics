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
--This entity is name NESdecode
entity NESDecode is
--This is the input and output
 Port ( RawData: in std_logic_vector(8 downto 0);
	Valid: in std_logic;
	A: out std_logic;
	B: out std_logic;
	Sel: out std_logic;
	Start: out std_logic;
	Up: out std_logic;
	Dn: out std_logic;
	Lt: out std_logic;
	Rt: out std_logic);
end NESDecode;

architecture Behavioral of NESDecode is
begin
--We have to inverted the input and output it when valid 1
--Nintendo NES default is being flip hence we should use inverter
decode_proc: process(RawData)
begin 
    A <= not RawData(0) and Valid;
    B <= not RawData(1) and Valid;
    Sel <= not RawData(2) and Valid;
    Start <= not RawData(3) and Valid;
    Up <= not RawData(4) and Valid;
    Dn <= not RawData(5) and Valid;
    Lt <= not RawData(6) and Valid;
    Rt <= not RawData(7) and Valid;
end process;

end behavioral;	