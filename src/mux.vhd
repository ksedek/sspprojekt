library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity mux is
	generic (w : integer := 8);
	port(
		M1 	: in std_logic_vector(w-1 downto 0);
		M2 	: in std_logic_vector(w-1 downto 0);
		R 	: out std_logic_vector(w-1 downto 0);
		SEL 	: in std_logic
	);
end mux;


architecture mux_arch of mux is
begin
	R <= M1 when (sel = '0') else
	     M2 when (sel = '1');
end mux_arch;
