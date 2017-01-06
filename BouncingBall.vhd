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
--The entity is name Bouncing Ball
entity BouncingBall is--Here is the input and output
    Port ( Clk : in std_logic;
           Reset : in std_logic;
           W : in std_logic;
           S : in std_logic;
           A : in std_logic;
           D : in std_logic;
           G : in std_logic;
           HitCount : out std_logic_vector(7 downto 0);
           Red   : out std_logic_vector(9 downto 0);
           Green : out std_logic_vector(9 downto 0);
           Blue  : out std_logic_vector(9 downto 0);
           VGA_clk : out std_logic; 
           sync : out std_logic;
           blank : out std_logic;
           vs : out std_logic;
           hs : out std_logic);
end BouncingBall;

architecture Behavioral of BouncingBall is
--this is ball entity component
component ball is
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
           Timeout : out std_logic_vector(9 downto 0);
           Hit : out std_logic);
end component;
--this is vga_controller component
component vga_controller is
    Port ( clk : in std_logic;
           reset : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           pixel_clk : out std_logic;
           blank : out std_logic;
           sync : out std_logic;
           DrawX : out std_logic_vector(9 downto 0);
           DrawY : out std_logic_vector(9 downto 0));
end component;
--this is Color_Mapper component
component Color_Mapper is
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
end component;

signal Reset_h, vsSig, HitSig : std_logic;
signal DrawXSig, DrawYSig, TimeoutSig : std_logic_vector(9 downto 0);
signal HoleSelectXSig, HoleSelectYSig, MoleSelectXSig, MoleSelectYSig  : std_logic_vector(2 downto 0);
signal HitNumberSig : std_logic_vector(7 downto 0);

begin
--Here we connected the entity one to the other
Reset_h <= Reset; -- The push buttons are active low

vgaSync_instance : vga_controller
   Port map(clk => Clk,
            reset => Reset_h,
            hs => hs,
            vs => vsSig,
            pixel_clk => VGA_clk,
            blank => blank,
            sync => sync,
            DrawX => DrawXSig,
            DrawY => DrawYSig);

ball_instance : ball
   Port map(Reset => Reset_h,
            frame_clk => vsSig, -- Vertical Sync used as an "ad hoc" 60 Hz clock signal
            W => W,
            S => S,
            A => A,
            D => D,
            G => G,
            HoleSelectX => HoleSelectXSig,
            HoleSelectY => HoleSelectYSig,
            MoleSelectX => MoleSelectXSig,
            MoleSelectY => MoleSelectYSig,   
            Timeout => TimeoutSig,
            HitNumber=>HitNumberSig,
            Hit => HitSig);

Color_instance : Color_Mapper
   Port Map(DrawX => DrawXSig,
            DrawY => DrawYSig,
            HoleSelectX => HoleSelectXSig,
            HoleSelectY => HoleSelectYSig,
            MoleSelectX => MoleSelectXSig,
            MoleSelectY => MoleSelectYSig, 
            Hit => HitSig,
            Timeout => TimeoutSig,
            HitNumber=>HitNumberSig,
            Red => Red,
            Green => Green,
            Blue => Blue);

vs <= vsSig;
HitCount <= HitNumberSig;
end Behavioral;      
