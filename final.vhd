-- Copyright (C) 1991-2010 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Web Edition"
-- CREATED		"Wed Dec 01 17:44:02 2010"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;
--The entity is name final
ENTITY final IS 
	PORT--this is the input and output
	(
		Clk :  IN  STD_LOGIC;
		Reset :  IN  STD_LOGIC;
		data1 :  IN  STD_LOGIC;
		VGA_clk :  OUT  STD_LOGIC;
		sync :  OUT  STD_LOGIC;
		blank :  OUT  STD_LOGIC;
		vs :  OUT  STD_LOGIC;
		hs :  OUT  STD_LOGIC;
		latch1 :  OUT  STD_LOGIC;
		power1 :  OUT  STD_LOGIC;
		ground1 :  OUT  STD_LOGIC;
		pulse1 :  OUT  STD_LOGIC;
		A :  OUT  STD_LOGIC;
		B :  OUT  STD_LOGIC;
		Sel :  OUT  STD_LOGIC;
		Start :  OUT  STD_LOGIC;
		Up :  OUT  STD_LOGIC;
		Dn :  OUT  STD_LOGIC;
		Lt :  OUT  STD_LOGIC;
		Rt :  OUT  STD_LOGIC;
		Blue :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		Green :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		Red :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END final;

ARCHITECTURE bdf_type OF final IS 

COMPONENT computevalid
	PORT(Q : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		 Valid : OUT STD_LOGIC
	);
END COMPONENT;
--this is bouncingball component
COMPONENT bouncingball
	PORT(Clk : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 W : IN STD_LOGIC;
		 S : IN STD_LOGIC;
		 A : IN STD_LOGIC;
		 D : IN STD_LOGIC;
		 G : IN STD_LOGIC;
		 VGA_clk : OUT STD_LOGIC;
		 sync : OUT STD_LOGIC;
		 blank : OUT STD_LOGIC;
		 vs : OUT STD_LOGIC;
		 hs : OUT STD_LOGIC;
		 Blue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Green : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 HitCount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Red : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;
--dflipflop component
COMPONENT dflipflop
	PORT(D : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 Q : OUT STD_LOGIC
	);
END COMPONENT;
--big_up_down_counter
COMPONENT big_up_down_counter
	PORT(clk : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 up_down : IN STD_LOGIC;
		 asynch_clr : IN STD_LOGIC;
		 Q : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END COMPONENT;
--computereset component
COMPONENT computereset
	PORT(Q : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		 ResetCount : OUT STD_LOGIC
	);
END COMPONENT;
--computelatch component
COMPONENT computelatch
	PORT(Q : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		 Latch : OUT STD_LOGIC
	);
END COMPONENT;
--computepulse
COMPONENT computepulse
	PORT(Q : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		 Pulse : OUT STD_LOGIC
	);
END COMPONENT;
--reg_9 component
COMPONENT reg_9
	PORT(Clk : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 Shift_In : IN STD_LOGIC;
		 Load : IN STD_LOGIC;
		 Shift_En : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 Shift_Out : OUT STD_LOGIC;
		 Data_Out : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;
--hexdriver component
COMPONENT hexdriver
	PORT(In0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Out0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;
--nesdecode component
COMPONENT nesdecode
	PORT(Valid : IN STD_LOGIC;
		 RawData : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 A : OUT STD_LOGIC;
		 B : OUT STD_LOGIC;
		 Sel : OUT STD_LOGIC;
		 Start : OUT STD_LOGIC;
		 Up : OUT STD_LOGIC;
		 Dn : OUT STD_LOGIC;
		 Lt : OUT STD_LOGIC;
		 Rt : OUT STD_LOGIC
	);
END COMPONENT;
--additional internal signals
SIGNAL	H :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(0 TO 8);
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC_VECTOR(8 DOWNTO 0);


BEGIN -- It connect one entity to the other
power1 <= '1';
ground1 <= '0';
latch1 <= SYNTHESIZED_WIRE_22;
pulse1 <= SYNTHESIZED_WIRE_21;
B <= SYNTHESIZED_WIRE_6;
Start <= SYNTHESIZED_WIRE_15;
Up <= SYNTHESIZED_WIRE_2;
Dn <= SYNTHESIZED_WIRE_3;
Lt <= SYNTHESIZED_WIRE_4;
Rt <= SYNTHESIZED_WIRE_5;
SYNTHESIZED_WIRE_8 <= '0';
SYNTHESIZED_WIRE_30 <= '1';
SYNTHESIZED_WIRE_31 <= '0';
SYNTHESIZED_WIRE_20 <= "000000000";



SYNTHESIZED_WIRE_16 <= NOT(Reset);


--connecting computevalid entity
b2v_inst1 : computevalid
PORT MAP(Q => SYNTHESIZED_WIRE_28,
		 Valid => SYNTHESIZED_WIRE_26);

--connecting bouncingball entity
b2v_inst23 : bouncingball
PORT MAP(Clk => Clk,
		 Reset => SYNTHESIZED_WIRE_1,
		 W => SYNTHESIZED_WIRE_2,
		 S => SYNTHESIZED_WIRE_3,
		 A => SYNTHESIZED_WIRE_4,
		 D => SYNTHESIZED_WIRE_5,
		 G => SYNTHESIZED_WIRE_6,
		 VGA_clk => VGA_clk,
		 sync => sync,
		 blank => blank,
		 vs => vs,
		 hs => hs,
		 Blue => Blue,
		 Green => Green,
		 HitCount => H,
		 Red => Red);


-connecting dflipflop entity
b2v_inst31 : dflipflop
PORT MAP(D => SYNTHESIZED_WIRE_29,
		 clk => Clk,
		 reset => SYNTHESIZED_WIRE_8,
		 Q => SYNTHESIZED_WIRE_24);


--connecting big_up_down_counter entity
b2v_inst34 : big_up_down_counter
PORT MAP(clk => Clk,
		 enable => SYNTHESIZED_WIRE_30,
		 up_down => SYNTHESIZED_WIRE_30,
		 asynch_clr => SYNTHESIZED_WIRE_11,
		 Q => SYNTHESIZED_WIRE_28);


--connecting computereset entity
b2v_inst37 : computereset
PORT MAP(Q => SYNTHESIZED_WIRE_28,
		 ResetCount => SYNTHESIZED_WIRE_11);

--connecting computelatch entity
b2v_inst38 : computelatch
PORT MAP(Q => SYNTHESIZED_WIRE_28,
		 Latch => SYNTHESIZED_WIRE_22);

--connecting computepulse entity
b2v_inst39 : computepulse
PORT MAP(Q => SYNTHESIZED_WIRE_28,
		 Pulse => SYNTHESIZED_WIRE_21);


SYNTHESIZED_WIRE_1 <= SYNTHESIZED_WIRE_15 OR SYNTHESIZED_WIRE_16;

--connecting reg_9 entity
b2v_inst41 : reg_9
PORT MAP(Clk => Clk,
		 Reset => SYNTHESIZED_WIRE_31,
		 Shift_In => data1,
		 Load => SYNTHESIZED_WIRE_31,
		 Shift_En => SYNTHESIZED_WIRE_19,
		 D => SYNTHESIZED_WIRE_20,
		 Data_Out => SYNTHESIZED_WIRE_27);




SYNTHESIZED_WIRE_29 <= SYNTHESIZED_WIRE_21 OR SYNTHESIZED_WIRE_22;


SYNTHESIZED_WIRE_19 <= SYNTHESIZED_WIRE_23 AND SYNTHESIZED_WIRE_24;


SYNTHESIZED_WIRE_23 <= NOT(SYNTHESIZED_WIRE_29);


--connecting hexdriver entity
b2v_inst5 : hexdriver
PORT MAP(In0 => H(3 DOWNTO 0),
		 Out0 => HEX0);


--connecting nesdecode entity
b2v_inst51 : nesdecode
PORT MAP(Valid => SYNTHESIZED_WIRE_26,
		 RawData => SYNTHESIZED_WIRE_27,
		 A => A,
		 B => SYNTHESIZED_WIRE_6,
		 Sel => Sel,
		 Start => SYNTHESIZED_WIRE_15,
		 Up => SYNTHESIZED_WIRE_2,
		 Dn => SYNTHESIZED_WIRE_3,
		 Lt => SYNTHESIZED_WIRE_4,
		 Rt => SYNTHESIZED_WIRE_5);

--connecting hexdriver entity
b2v_inst6 : hexdriver
PORT MAP(In0 => H(7 DOWNTO 4),
		 Out0 => HEX1);


END bdf_type;