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
use IEEE.math_real.all;
--the entity is name ball
entity ball is--this is the input and output
   Port ( Reset : in std_logic;
        frame_clk : in std_logic;
        W : in std_logic;
        S : in std_logic;
        A : in std_logic;
        D : in std_logic;
        G : in std_logic;
        HoleSelectX : out std_logic_vector(2 downto 0);
        HoleSelectY : out std_logic_vector(2 downto 0);
        MoleSelectX : out std_logic_vector(2 downto 0);
        MoleSelectY : out std_logic_vector(2 downto 0);
        HitNumber: out std_logic_vector(7 downto 0); 
        Timeout: out std_logic_vector(9 downto 0);
        Hit: out std_logic);
end ball;

--additional signal
architecture Behavioral of ball is
signal Hole_X, Hole_Y, Mole_X, Mole_Y : std_logic_vector(1 downto 0); 
signal TimerSelect : std_logic_vector(4 downto 0); --Timer for selection movement
signal TimerMole : std_logic_vector(8 downto 0);   --Timer for mole movement
signal TimerGap : std_logic_vector(8 downto 0);    --Gap between time
signal RandX: std_logic_vector(7 downto 0);        --random number variable
signal RandY: std_logic_vector(7 downto 0);        --""
signal HitRecorded: std_logic;                     --whether hit or not
signal HitCount: std_logic_vector(7 downto 0);     --hit count noone can reach 512 :S
signal Gprev: std_logic;                           --previous G
signal TimerOverall : std_logic_vector(10 downto 0);      --

begin

  
-------------------------------------------------

  Move_Sel: process(Reset, frame_clk, W, S, A, D) --move selection
  begin
    if(Reset = '1') then   --Asynchronous Reset
     Hole_X <= "10";
     Hole_Y <= "10";
     TimerSelect <="00000";
 
    elsif(rising_edge(frame_clk)) then
    
      if (TimerSelect = "01000") then --if every half second around there
        if(W = '1') then
           if (Hole_Y = "00") then
            Hole_Y <= "10";
           else
            Hole_Y <= Hole_Y-"01";
           end if; 
        elsif(S = '1') then
           if (Hole_Y = "10") then
            Hole_Y <= "00";
           else
            Hole_Y <= Hole_Y+"01";
           end if; 
        elsif(A = '1') then
        Hole_X <= Hole_X-"01";
        elsif(D = '1') then
        Hole_X <= Hole_X+"01";
        end if;   --endif for hole select
        TimerSelect <= "00000";  
      else 
        TimerSelect <= TimerSelect+"00001";
      end if; --endif for timer
    end if; --endif for reset and rising edge clock elsif
  end process Move_Sel;
  
  
  Move_Mole: process(Reset, frame_clk, W, S, A, D) --move selection
  begin
    if(Reset = '1') then   --Asynchronous Reset
     Mole_X <= "11";
     Mole_Y <= "01";
     TimerMole <= "000000000";    
     TimerGap <= "010000000";
     RandX <= "10001011";--LFSR
     RandY <= "01110010";--LFSR
     HitCount<="00000000";
     elsif(rising_edge(frame_clk)) and (TimerOverall/="11110000000") then

     if (TimerMole = TimerGap) then --if every half second
       RandX(6 downto 0) <= RandX(7 downto 1);
       RandX(7) <= RandX(6) xor RandX(3);
       
       RandY(6 downto 0) <= RandY(7 downto 1);
       RandY(7) <= RandY(2) xor RandY(4);
       
       
       Mole_X(1)<=RandX(7);
       Mole_X(0)<=RandX(2);
       
       if((RandY(3)='1') and (RandY(6)='1')) then
         Mole_Y<=Mole_Y;
       else
         Mole_Y(1)<=RandY(3);
         Mole_Y(0)<=RandY(6);
       end if;           
          
       TimerMole<="000000000";
       HitRecorded <= '0';
     else 
       Gprev<=G;
       if (Gprev = '0') and (G = '1') and (Hole_X = Mole_X) and (Hole_Y = Mole_Y)then
          HitRecorded <= '1';
          HitCount <= HitCount + "00000001";
          TimerMole <= TimerGap;
       else
          TimerMole <= TimerMole+"000000001";
       end if;  
       
     end if;--endif for timer
          
     
    end if; --endif for reset and rising edge clock elsif

  end process Move_Mole;
  
  
  Game_control: process(Reset, frame_clk) --game control
  begin
    if(Reset = '1') then   --Asynchronous Reset
      TimerOverall <= "00000000000";
    elsif(rising_edge(frame_clk)) then
      if (TimerOverall="11110000000") then
          TimerOverall <=TimerOverall;  --game stops
          
          else 
          TimerOverall <= TimerOverall + "00000000001";     
          end if;
    end if; --endif for reset and rising edge clock elsif
  end process Game_control;    
  


  HoleSelectX(2) <='0';
  HoleSelectY(2) <='0';  
  HoleSelectX(1 downto 0) <=Hole_X;
  HoleSelectY(1 downto 0) <=Hole_Y;
  MoleSelectX(2) <='0';
  MoleSelectY(2) <='0';  
  MoleSelectX(1 downto 0) <=Mole_X;
  MoleSelectY(1 downto 0) <=Mole_Y;
  Hit<=HitRecorded;
  HitNumber<=HitCount;
  Timeout(8 downto 0) <= TimerOverall(10 downto 2);
  Timeout(9 downto 9) <= "0";
end Behavioral;      
