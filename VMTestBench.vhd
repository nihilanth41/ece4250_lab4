library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- entity for Vending Machine test bench. No port declarations.
entity VMTestBench_behave is
  generic (clk_delay: time := 100 ns);
end VMTestBench_behave;

architecture VMTestBench_behave_arch of VMTestBench_behave is
  -- component declaration for unit under test (UUT)
  --component VMBehave is
    component VMROM is
    port(D, N, clk : in std_logic := '0';
         rtn_nickel, disp_drink : out std_logic := '0');
  end component;

component VMBehave is
  port(D, N, clk: in std_logic := '0';
       rtn_nickel, disp_drink : out std_logic := '0');
end component;

  -- inputs -- initial value only simulation
  signal d : std_logic := '0';
  signal n : std_logic := '0';
  signal clk : std_logic := '1';
  -- outputs
  signal rtn_nickel : std_logic := '0';
  signal disp_drink : std_logic := '0';
  signal rtn_nickel1 : std_logic := '0';
  signal disp_drink1 : std_logic := '0';
begin -- concurrent statements
  
  -- component instantiation
  uut1: VMBehave port map(clk => clk, D => d, N => n, rtn_nickel => rtn_nickel1, disp_drink => disp_drink1);
  uut: VMROM port map(clk => clk, D => d, N => n, rtn_nickel => rtn_nickel, disp_drink => disp_drink);
  
  clk <= not clk after clk_delay/2;

  test_process : process
  begin
    
    -- Test two dimes case
wait for 100 ns;
    for i in 0 to 2 loop
      d <= not d;
      wait for 100 ns;
    end loop;
    assert(rtn_nickel='0' and disp_drink='1')
      report "Wrong answer $0.10 + $0.10"
      severity error;
 
    -- Test dime, nickel, dime
    d <= '1';
    wait for 100 ns;
    d <= '0';
    n <= '1';
    wait for 100 ns;
    n <= '0';
    d <= '1';
    wait for 100 ns;
    d <= '0';
    assert(rtn_nickel='1' and disp_drink='1')
      report "Wrong answer $0.10 + $0.05 + $0.10"
      severity error;
    
    report "Test Finished";
  end process;
  
end VMTestBench_behave_arch;

