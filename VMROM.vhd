Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vending_machine is 
	port 	(
			D, N : in std_logic; -- D = dime input, N = nickel input
			rtn_nickel, disp_drink : out std_logic -- rtn_nickel if excess change was entered, display drink if >= $0.20 was entered
		);
end vending_machine;

architecture behave of vending_machine is
	-- signals for present state and next state
	signal present_state, next_state : std_logic_vector ( 1 downto 0 ); -- 2 bit for 4 possible stages
	
	signal temp : STD_LOGIC_VECTOR ( 3 downto 0 );

	signal element : STD_LOGIC_VECTOR ( 3 downto 0 );

	TYPE ROM is ARRAY ( 0 to 15 ) of STD_LOGIC_VECTOR ( 3 downto 0 );
	Constant vending_machine_rom : ROM :=
		(
			"0000", -- element 0
			"0100", -- element 1
			"1000", -- element 2
			"1111", -- element 3 -> this can never happen, 1111 corresponds to NULL
			"0100", -- element 4
			"1000", -- element 5
			"1100", -- element 6
			"1111", -- element 7 -> this can never happen, 1111 corresponds to NULL
			"1000", -- element 8
			"1100", -- element 9
			"0001", -- element 10
			"1111", -- element 11 -> this can never happen, 1111 corresponds to NULL 
			"1100", -- element 12
			"0001", -- element 13
			"0011", -- element 14
			"1111" -- element 15 -> this can never happen, 1111 corresponds to NULL
		);
	begin
	element <= present_state(1) & present_state(0) & D & N;


	temp <= vending_machine_rom ( element );
	next_state = temp( 3 ) & test( 2 );
	rtn_nickel = temp( 2 );
	disp_drink = temp( 1 );


end behave; 
