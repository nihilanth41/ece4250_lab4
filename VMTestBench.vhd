library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- entity for Vending Machine test bench. No port declarations.
entity VMTestBench_behave is
  generic (clk_delay: time := 50 ns);
end VMTestBench_behave;

architecture VMTestBench_behave_arch of VMTestBench_behave is
  -- component declaration for unit under test (UUT)
  component VMBehave is
    port(D, N, clk : in std_logic := '0';
         rtn_nickel, disp_drink : out std_logic := '0');
  end component;

  -- inputs -- initial value only simulation
  signal d : std_logic := '0';
  signal n : std_logic := '0';
  signal clk : std_logic := '1';
  -- outputs
  signal rtn_nickel : std_logic := '0';
  signal disp_drink : std_logic := '0';
begin -- concurrent statements
  
  -- component instantiation
  uut: VMBehave port map(clk => clk, D => d, N => n, rtn_nickel => rtn_nickel, disp_drink => disp_drink);
  
  clk_process : process 
  begin 
    for i in 0 to 5 loop
      wait for clk_delay;
      clk <= not clk;
    end loop;
  end process;
  
  test_process : process
  begin
    for i in 0 to 2 loop
      d <= not d;
      wait for 100 ns;
    end loop;
    assert(rtn_nickel='0' and disp_drink='1')
      report "Wrong answer"
      severity error;
    -- else
    report "Test Finished";
  end process;
  
end VMTestBench_behave_arch;
