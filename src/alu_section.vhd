---------------------------------
-- ALU + Flag register + multiplexer 
-- Hubert Grzywacz, 2011
---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL;

---------------------------------

entity alu_section is
	generic(w: integer :=8 --wielkosc operandow
	);
	port(   clk : in std_logic; --sygnal zegara
		A, B : in std_logic_vector(w-1 downto 0); --input operands
		DIN : in std_logic_vector(w-1 downto 0); -- DIN
		SEL : in std_logic;
		OP : in std_logic_vector(3 downto 0); --Operation
		S : out std_logic_vector(w-1 downto 0);  --output
		LOAD : in std_logic;
		CLR : in std_logic
	);
end alu_section;

---------------------------------



architecture alu_section_arch of alu_section is

---------------------------------
component alu
	generic(w: integer :=8 -- wielkosc operandow
	);
	port(   clk : in std_logic; -- sygnal zegara
		A, B : in std_logic_vector(w-1 downto 0); -- wejscia
		OP : in std_logic_vector(3 downto 0); -- opkod
		P : out std_logic_vector(w-1 downto 0);  -- wyjscie
		Q : in std_logic_vector(w-1 downto 0);
		F : out std_logic_vector(w-1 downto 0)
	);
end component;
---------------------------------


---------------------------------
component mux is
	generic (w : integer := 8);
	port(
		M1 	: in std_logic_vector(w-1 downto 0); -- dla sel = 0
		M2 	: in std_logic_vector(w-1 downto 0); -- dla sel = 1
		R 	: out std_logic_vector(w-1 downto 0);
		SEL 	: in std_logic
	);
end component;
---------------------------------


---------------------------------
component f_register is
		generic ( w : natural :=8);
		port( 	I : in std_logic_vector(w-1 downto 0);
		     	clk : in std_logic;
		     	L : in std_logic; 
		     	clr : in std_logic;
		     	Q : out std_logic_vector(w-1 downto 0)
	     );
end component;
---------------------------------


signal sec_A, sec_B, sec_P, sec_DIN, sec_S, sec_FI, sec_FQ : std_logic_vector(w-1 downto 0);
signal sec_clk, sec_SEL, sec_LOAD, sec_CLR: std_logic;
signal sec_op : std_logic_vector(3 downto 0);

begin

	sec_A <= A;
	sec_B <= B;
	sec_OP <= OP;
	sec_DIN <= DIN;

	sec_clk <= clk;
	sec_SEL <= SEL;

	sec_LOAD <= LOAD;
	sec_CLR <= CLR;

	ALU1 : alu
		generic map (w => w)
		port map (clk => sec_clk, A => sec_A, B => sec_B,
				OP => sec_OP, P => sec_P, 
				F => sec_FI, Q => sec_FQ);

	MUX1 : mux
		generic map (w => w)
		port map (M1 => sec_P, M2 => sec_DIN, R => sec_S, 
				SEL => sec_SEL);

	REG1 : f_register
		generic map (w => w)
		port map (I => sec_FI, clk => sec_clk, L => sec_LOAD,
				clr => sec_CLR, Q => sec_FQ);

	S <= sec_S;

end alu_section_arch;
