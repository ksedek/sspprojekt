-----------------------------------
-- Arithmetic Logic Unit
-- Hubert Grzywacz 2011
-----------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_misc.all;


----------------------------------

entity alu is
	generic( w : integer := 8 --WIELKOSCI OPERANDOW
	);
	port(   clk : in std_logic; -- ZEGAR
		A, B : in std_logic_vector(w-1 downto 0); -- OPERANDY WEJSCIOWE
		OP : in std_logic_vector(3 downto 0); -- KOD OPERACJI
		P : out std_logic_vector(w-1 downto 0);  --WYJSCIE ALU
		Q : in std_logic_vector(w-1 downto 0); -- FLAGI
		F : out std_logic_vector(w-1 downto 0)
	);
end alu;

----------------------------------


architecture alu_arch of alu is

	signal sig_A, sig_B, sig_P, sig_F, sig_Q : std_logic_vector(w-1 downto 0) := (others => '0');
	signal result, tmp_A, tmp_B : std_logic_vector(w downto 0) := (others => '0');
	signal tmp_C : std_logic_vector(w downto 0) := (others => '0');
	constant ZEROS : std_logic_vector(w-1 downto 0) := (others => '0');

begin

	sig_A <= A;
	sig_B <= B;
	P <= sig_P;
	F <= sig_F;
	sig_Q <= Q;


	process(clk)

	begin

		if(rising_edge(clk)) then
			case OP is
				when "0000" => 
					result <= (sig_A(w-1) & sig_A) + (sig_B(w-1) & sig_B);
					sig_P <= result(w-1 downto 0);
					sig_F(3) <= (result(w) xor result(w-1)); -- Carry
					sig_F(2) <= not or_reduce(sig_P); -- Zero
					sig_F(1) <= sig_P(w-1) xor sig_A(w-1); -- Overflow
					sig_F(0) <= sig_P(w-1); -- Negative
				when "0001" =>
					tmp_A <= sig_A(w-1) & sig_A;
					tmp_B <= sig_B(w-1) & sig_B;
					tmp_C <= ZEROS & Q(3);
					result <= (sig_A(w-1) & sig_A) + (sig_B(w-1) & sig_B) + (ZEROS & Q(3)); 
					sig_P <= result(w-1 downto 0);
					sig_F(3) <= (result(w) xor result(w-1)); -- Carry
					sig_F(2) <= not or_reduce(sig_P); -- Zero
					sig_F(1) <= sig_P(w-1) xor sig_A(w-1); -- Overflow
					sig_F(0) <= sig_P(w-1); -- Negative
				when "0010" =>
					sig_P <= sig_A and sig_B;  -- SUB (placeholder)
				when "0011" =>
					sig_P <= sig_A xor sig_B; -- SUBC
				when "0100" =>
					sig_P <= sig_B xor sig_A; -- RSUBC 
				when "0101" =>
					sig_P <= sig_A and sig_B;  -- AND
				when "0110" =>
					sig_P <= sig_A or sig_B;  -- OR   
				when "0111" =>
					sig_P <= sig_A xor sig_B; -- XOR	
				when "1000" =>
					sig_P <= sig_A xor sig_B; -- TST
				when "1001" =>
					sig_P <= sig_A xor sig_B; -- CMP
				when "1010" =>
					sig_P <= sig_F; -- GETF
				when "1011" =>
					sig_F <= sig_A; -- PUTF
				when others =>
					NULL;
			end case;      
		end if;

	end process;   

end alu_arch;
