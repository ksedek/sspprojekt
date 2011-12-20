LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_alu_section IS
	END tb_alu_section;

ARCHITECTURE tb_alu_section_arch OF tb_alu_section IS

	signal clk : std_logic := '0';
	signal A, B, S, DIN : std_logic_vector(7 downto 0) := (others => '0');
	signal SEL : std_logic := '0';
	signal OP : std_logic_vector(3 downto 0) := (others => '0');
	signal LOAD : std_logic := '0';
	signal CLR : std_logic := '1';
	constant clk_okres : time := 10 ns;

BEGIN

	uut: entity work.alu_section 
				port map (clk => clk, A => A, B => B, 
					DIN => DIN, SEL => SEL,
					OP => OP, S => S, 
					CLR => CLR, LOAD => LOAD);


	Clk_process :process
	begin
		clk <= '0';
		wait for clk_okres/2;
		clk <= '1';
		wait for clk_okres/2;
	end process;

	-- Stimulus process
	stim_proc: process
	begin       
		--wait for clk_okres*1;
		A <= "00001110"; 
		B <= "00100010"; 
		DIN <= "01111111";
		CLR <= '1';
		OP <= "0000";  wait for clk_okres;
		CLR <= '0';
		OP <= "0000";  wait for clk_okres;
		OP <= "0000";  wait for clk_okres;
		LOAD <= '1';
		OP <= "0000";  wait for clk_okres;
		LOAD <= '0';
		OP <= "0000";  wait for clk_okres; 
		CLR <= '1';
		wait;
	end process;

END;
