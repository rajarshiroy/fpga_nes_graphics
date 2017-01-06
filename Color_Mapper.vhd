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
use IEEE.STD_LOGIC_SIGNED.ALL;
--The entity is name Color_Mapper
entity Color_Mapper is--The input and output
   Port ( DrawX : in std_logic_vector(9 downto 0);
          DrawY : in std_logic_vector(9 downto 0);
          HoleSelectX: in std_logic_vector(2 downto 0);
          HoleSelectY: in std_logic_vector(2 downto 0);
          MoleSelectX: in std_logic_vector(2 downto 0);
          MoleSelectY: in std_logic_vector(2 downto 0);
          Timeout: in std_logic_vector(9 downto 0);
          Hit: in std_logic;
          HitNumber: in std_logic_vector(7 downto 0); 
          Red   : out std_logic_vector(9 downto 0);
          Green : out std_logic_vector(9 downto 0);
          Blue  : out std_logic_vector(9 downto 0));
end Color_Mapper;

architecture Behavioral of Color_Mapper is
--additional signals
signal HoleBorder_on : std_logic;
signal HoleInterior_on : std_logic;
signal HoleSelect_on : std_logic;
signal MoleFaceBorder_on: std_logic;
signal MoleFaceFill_on: std_logic;
signal MoleNoseBorder_on: std_logic;
signal MoleNoseFill_on: std_logic;
signal MoleEye_on: std_logic;
signal MoleEyeGlint_on: std_logic;
signal MoleTeethFill_on: std_logic;
signal MoleTeethBorder_on: std_logic;
signal Timeout_on: std_logic;
signal HitNumber_on: std_logic;

signal XX: std_logic_vector(10 downto 0); --problem with drawx > 512 since signed library used

--signal HoleSelectX : std_logic_vector(2 downto 0) := CONV_STD_LOGIC_VECTOR(0, 3); --which hole X (to be input)
--signal HoleSelectY : std_logic_vector(2 downto 0) := CONV_STD_LOGIC_VECTOR(1, 3); --which hole Y (to be input)
signal HoleSelCentX : std_logic_vector(13 downto 0); --center of select circle
signal HoleSelCentY : std_logic_vector(12 downto 0); --center of select circle

--signal MoleSelectX : std_logic_vector(2 downto 0) := CONV_STD_LOGIC_VECTOR(2, 3); --mole hole X (to be input)
--signal MoleSelectY : std_logic_vector(2 downto 0) := CONV_STD_LOGIC_VECTOR(1, 3); --mole hole Y (to be input)
signal MoleSelCentX : std_logic_vector(12 downto 0); --center of mole
signal MoleSelCentY : std_logic_vector(12 downto 0); --center of mole


signal HoleSelectSize : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(65, 10); --radius of select circle
signal HoleBorderSize : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(57, 10); --radius of holeborder
signal HoleSize : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(54, 10);  --radius of hole interior
signal MoleFaceBorderSize: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(43, 10);
signal MoleFaceFillSize: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(40, 10);
signal MoleNoseBorderSize: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(6, 10);
signal MoleNoseFillSize: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(4, 10);
signal MoleEyeSize: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(8, 10);
signal MoleEyeGlintSize: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(4, 10);

begin

  XX(10)<= '0';   --since 640 >512
  XX(9 downto 0) <= DrawX(9 downto 0);



--///////// HoleInterior
  HoleInterior_on_proc : process (DrawX, DrawY, HoleSize)
  begin

    if ((((DrawX - "0001010000") * (DrawX - "0001010000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "0011110000") * (DrawX - "0011110000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "0110010000") * (DrawX - "0110010000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "1000110000") * (DrawX - "1000110000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';     
      
    elsif ((((DrawX - "0001010000") * (DrawX - "0001010000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "0011110000") * (DrawX - "0011110000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "0110010000") * (DrawX - "0110010000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "1000110000") * (DrawX - "1000110000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';     
      
    elsif ((((DrawX - "0001010000") * (DrawX - "0001010000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "0011110000") * (DrawX - "0011110000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "0110010000") * (DrawX - "0110010000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';
    elsif ((((DrawX - "1000110000") * (DrawX - "1000110000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleSize*HoleSize)) then
      HoleInterior_on <= '1';        
                
    else
      HoleInterior_on <= '0';
    end if;
  end process HoleInterior_on_proc;



--///////// HoleBorder
  HoleBorder_on_proc : process (DrawX, DrawY, HoleBorderSize)
  begin

    if ((((DrawX - "0001010000") * (DrawX - "0001010000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "0011110000") * (DrawX - "0011110000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "0110010000") * (DrawX - "0110010000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "1000110000") * (DrawX - "1000110000")) + ((DrawY - "0001010000") * (DrawY - "0001010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';     
      
    elsif ((((DrawX - "0001010000") * (DrawX - "0001010000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "0011110000") * (DrawX - "0011110000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "0110010000") * (DrawX - "0110010000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "1000110000") * (DrawX - "1000110000")) + ((DrawY - "0011110000") * (DrawY - "0011110000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';     
      
    elsif ((((DrawX - "0001010000") * (DrawX - "0001010000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "0011110000") * (DrawX - "0011110000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "0110010000") * (DrawX - "0110010000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';
    elsif ((((DrawX - "1000110000") * (DrawX - "1000110000")) + ((DrawY - "0110010000") * (DrawY - "0110010000"))) <= (HoleBorderSize*HoleBorderSize)) then
      HoleBorder_on <= '1';        
                
    else
      HoleBorder_on <= '0';
    end if;
  end process HoleBorder_on_proc;


--///////// HoleSelect
  HoleSelect_on_proc : process (DrawX, DrawY, HoleSelectX, HoleSelectY, HoleSelectSize)
  begin

  HoleSelCentX <= ("00000001010000"+(HoleSelectX * "00010100000"));
  HoleSelCentY <= ("0001010000"+(HoleSelectY * "0010100000"));

    if ((((XX - HoleSelCentX) * (XX - HoleSelCentX)) + ((DrawY - HoleSelCentY) * (DrawY - HoleSelCentY))) <= (HoleSelectSize*HoleSelectSize)) then
      HoleSelect_on <= '1';
                      
    else
      HoleSelect_on <= '0';
    end if;
  end process HoleSelect_on_proc;

--////Mole Select
  MoleSelect_on_proc : process (DrawX, DrawY, MoleSelectX, MoleSelectY)
  begin

  MoleSelCentX <= ("0001010000"+(MoleSelectX * "0010100000"));
  MoleSelCentY <= ("0001010000"+(MoleSelectY * "0010100000"));

    --face border
    if ((((XX - MoleSelCentX) * (XX - MoleSelCentX)) + ((DrawY - MoleSelCentY) * (DrawY - MoleSelCentY))) <= (MoleFaceBorderSize*MoleFaceBorderSize)) then
      MoleFaceBorder_on <= '1';                      
    else
      MoleFaceBorder_on <= '0';
    end if;
    
    --face fill
    if ((((XX - MoleSelCentX) * (XX - MoleSelCentX)) + ((DrawY - MoleSelCentY) * (DrawY - MoleSelCentY))) <= (MoleFaceFillSize*MoleFaceFillSize)) then
      MoleFaceFill_on <= '1';                      
    else
      MoleFaceFill_on <= '0';
    end if;    
    
    --nose border
    if ((((XX - MoleSelCentX) * (XX - MoleSelCentX)) + ((DrawY - MoleSelCentY-"0000000110") * (DrawY - MoleSelCentY-"0000000110"))) <= (MoleNoseBorderSize*MoleNoseBorderSize)) then
      MoleNoseBorder_on <= '1';                      
    else
      MoleNoseBorder_on <= '0';
    end if;     
    
    --nose fill
    if ((((XX - MoleSelCentX) * (XX - MoleSelCentX)) + ((DrawY - MoleSelCentY-"0000000110") * (DrawY - MoleSelCentY-"0000000110"))) <= (MoleNoseFillSize*MoleNoseFillSize)) then
      MoleNoseFill_on <= '1';                      
    else
      MoleNoseFill_on <= '0';
    end if; 
    
    --eye
    if ((((XX - MoleSelCentX-"0000010011") * (XX - MoleSelCentX-"0000010011")) + ((DrawY - MoleSelCentY+"0000001100") * (DrawY - MoleSelCentY+"0000001100"))) <= (MoleEyeSize*MoleEyeSize)) then
      MoleEye_on <= '1';   
    elsif ((((XX - MoleSelCentX+"0000010011") * (XX - MoleSelCentX+"0000010011")) + ((DrawY - MoleSelCentY+"0000001100") * (DrawY - MoleSelCentY+"0000001100"))) <= (MoleEyeSize*MoleEyeSize)) then
      MoleEye_on <= '1';                          
    else
      MoleEye_on <= '0';
    end if;     
    
    --eye glint
    if ((((XX - MoleSelCentX-"0000010101") * (XX - MoleSelCentX-"0000010101")) + ((DrawY - MoleSelCentY+"0000001111") * (DrawY - MoleSelCentY+"0000001111"))) <= (MoleEyeGlintSize*MoleEyeGlintSize)) then
      MoleEyeGlint_on <= '1';   
    elsif ((((XX - MoleSelCentX+"0000010001") * (XX - MoleSelCentX+"0000010001")) + ((DrawY - MoleSelCentY+"0000001111") * (DrawY - MoleSelCentY+"0000001111"))) <= (MoleEyeGlintSize*MoleEyeGlintSize)) then
      MoleEyeGlint_on <= '1';                          
    else
      MoleEyeGlint_on <= '0';
    end if;         
    
    --teethfill
    if (XX>=(MoleSelCentX-"0011"))and(XX<=(MoleSelCentX-"0001"))and(DrawY>=(MoleSelCentY+"010101"))and(DrawY<=(MoleSelCentY+"0011011")) then
      MoleTeethFill_on <= '1';   
    elsif (XX>=(MoleSelCentX+"0001"))and(XX<=(MoleSelCentX+"0011"))and(DrawY>=(MoleSelCentY+"010101"))and(DrawY<=(MoleSelCentY+"0011011")) then
      MoleTeethFill_on <= '1';                          
    else
      MoleTeethFill_on <= '0';
    end if;  
    
    
    
    --teethborder
    if (HoleSelectX=MoleSelectX) and (HoleSelectY=MoleSelectY) then
        if (XX>=(MoleSelCentX-"0101"))and(XX<=(MoleSelCentX+"0101"))and(DrawY>=(MoleSelCentY+"010101"))and(DrawY<=(MoleSelCentY+"0100000")) then
          MoleTeethBorder_on <= '1';   
        elsif ((((XX - MoleSelCentX) * (XX - MoleSelCentX)) + ((DrawY - MoleSelCentY-"0000010110") * (DrawY - MoleSelCentY-"0000010110"))) <= ((MoleNoseBorderSize-"01")*MoleNoseBorderSize)) then
          MoleTeethBorder_on <= '1';                           
        else
          MoleTeethBorder_on <= '0';
        end if;  
  
    else 
        if (XX>=(MoleSelCentX-"0101"))and(XX<=(MoleSelCentX+"0101"))and(DrawY>=(MoleSelCentY+"010011"))and(DrawY<=(MoleSelCentY+"0011101")) then
          MoleTeethBorder_on <= '1';                           
        else
          MoleTeethBorder_on <= '0';
        end if;      
    end if;
    
    
    
    
  end process MoleSelect_on_proc;

--//timeout select
  Timeout_on_proc : process (DrawY, Timeout)
  begin
    if (DrawY <= Timeout) then
      Timeout_on <= '1';
                      
    else
      Timeout_on <= '0';
    end if;
  end process Timeout_on_proc;
  
--//HitNumberSelect
  HitNumber_on_proc : process (DrawY,XX, HitNumber)
  begin
    if (DrawY <= 6) and (XX <= HitNumber*"0100") then
      HitNumber_on <= '1';                      
    else
      HitNumber_on <= '0';
    end if;
  end process HitNumber_on_proc;


--///Coloring

  RGB_Display : process (HoleInterior_on, HoleBorder_on, HoleSelect_on, MoleFaceBorder_on, MoleFaceFill_on, MoleNoseFill_on, MoleNoseBorder_on, DrawX, DrawY)
    variable GreenVar, BlueVar : std_logic_vector(22 downto 0);
  begin
 --sort based on the upmost layer
    if (MoleEyeGlint_on = '1') then -- moleeye
      Red   <= "1000000000";
      Green <= "1000000000";
      Blue  <= "1000000000";    
      
    elsif (MoleTeethFill_on = '1') then -- moleteeth
      Red   <= "1000000000";
      Green <= "1000000000";
      Blue  <= "1000000000";      
      
    elsif (MoleTeethBorder_on = '1') then -- moleteethborder
      Red   <= "0000000000";
      Green <= "0000000000";
      Blue  <= "0000000000";            
      
    elsif (MoleEye_on = '1') then -- moleeye
      Red   <= "0000000000";
      Green <= "0000000000";
      Blue  <= "0000000000";      
      
    elsif (MoleNoseFill_on = '1') then -- molenosefill
      Red   <= "0111111110";
      Green <= "0101011100";
      Blue  <= "0110010010";
      
    elsif (MoleNoseBorder_on = '1') then -- molenoseborder
      Red   <= "0000000000";
      Green <= "0000000000";
      Blue  <= "0000000000";

    elsif (MoleFaceFill_on = '1') then -- molefacefill
      Red   <= "0101110010";
      Green <= "0011110100";
      Blue  <= "0010101110";  
      
    elsif (MoleFaceBorder_on = '1') then -- molefaceborder
      Red   <= "0000000000";
      Green <= "0000000000";
      Blue  <= "0000000000";  
      
      
    elsif (HoleInterior_on = '1') then -- holeinterior
      Red   <= "0100000000";
      Green <= "0100000000";
      Blue  <= "0100000000";  
      
    elsif (HoleBorder_on = '1') then -- holeborder
      Red   <= "0000000000";
      Green <= "0000000000";
      Blue  <= "0000000000";      
      
    elsif (HoleSelect_on = '1') then -- holeselect
      Red   <= "0111111000";
      Green <= "0100001100";
      Blue  <= "0000110110"; 
      
    elsif (HitNumber_on = '1') then -- hits bar on top
      Red   <= "0000000000";
      Green <= "0000000000";
      Blue  <= "0010011000";        
    
    elsif (Timeout_on = '1') and (Timeout /= "0111100000") then -- timeoutselect
      Red   <= "0001001010";
      Green <= "0101100010";
      Blue  <= "0010011000";   
      
    elsif (Timeout_on = '1') and (Timeout = "0111100000") then -- timeoutselect
      Red   <= "0111011010";
      Green <= "0000111000";
      Blue  <= "0001001000";         
      
    else          -- green background
      Red   <= "0101101010";
      Green <= "0111001100"; --DrawY(9 downto 0);
      Blue  <= "0000111010";
    end if;
  end process RGB_Display;

end Behavioral;