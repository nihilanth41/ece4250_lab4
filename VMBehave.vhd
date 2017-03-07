library ieee;
use ieee.std_logic_1164.all;

entity hw5_behave is
  port(D, N : in std_logic;
       rtn_nickel, disp_drink : out std_logic);
end hw5_behave;

architecture hw5_behave_arch of hw5_behave is
  -- signals for ps and ns (because the state is determined by the output ports)
  signal ps, ns : std_logic_vector(1 downto 0);
  begin 
    -- mealy machine: output determined by current state and the current inputs
    -- process current state and current inputs
    process(ps, D, N)
    begin
      case ps is
        when "00" =>
        -- evaluate inputs and set next state
        when "01" =>
        -- evaluate inputs
        when "10" =>
        -- evaluate inputs
        when "11" =>
        -- evaluate inputs
        when others => null;
      end case;
    end process;

    process(clk)
    begin
      if(clk'event and clk='1') then
        ps <= ns;
      end if;
    end process;

end hw5_behave_arch;
