library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity VMTestBench is
  port ( D, N, rtn_nickel, disp_drink : out std_logic ); 
end VMTestBench
  
  architecture behavior of VMTestBench is
    -- Array[16] of 4-bit vectors
    type ROM is array(0 to 15) of std_logic_vector(3 downto 0);
      -- Array of expected results for i=0 through i=11
      constant input_arr : ROM := (
      constant output_results : ROM := ("0000", "0100", "1000", "1111", "0100", "1000", "1100", "1111", "1000", "1100", "0001", "1111", "1100", "0001", "0011", "1111");

  component VMROM
    port( D, N : in std_logic;
          rtn_nickel, disp_drink : out std_logic;
          clk : in std_logic);
  end component;

  TEST_ROM_PROC: process
    variable bits : std_logic_vector(3 downto 0) := "0000";
  begin
    for i in 0 to 15 loop
      -- construct D,N from i
      bits := bit_vector(TO_UNSIGNED(i, 4));
      D <=  
    end loop
      
      
      
        

  


end behavior;                         -- Complete syntax
