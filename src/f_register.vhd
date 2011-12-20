-------------------------------------
-- Flag register
-- Hubert Grzywacz, 2011
-------------------------------------

library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


-------------------------------------

entity f_register is

		generic ( w : natural :=8);
		port( 	I : in std_logic_vector(w-1 downto 0); -- wejscie
		     	clk : in std_logic; 
		     	L : in std_logic; -- LOAD
		     	clr : in std_logic; -- clearowanie
		     	Q : out std_logic_vector(w-1 downto 0) -- wyjscie
	     );
end f_register;

-------------------------------------

architecture f_register_arch of f_register is

	signal tmp_Q: std_logic_vector(w-1 downto 0);

begin

	process(clk)
	begin

		if clr = '0' then
			tmp_Q <= (tmp_Q'range => '0');
		elsif (clk='1' and clk'event) then
			if L = '1' then
				tmp_Q <= I;
			end if;
		end if;

	end process;

	Q <= tmp_Q;

end f_register_arch;
