library ieee;
use ieee.std_logic_1164.all;

entity VMBehave is
  generic (delay: time := 2 ns);
  port(D, N : in std_logic := '0';
       rtn_nickel, disp_drink : out std_logic := '0');
end VMBehave;

architecture VMBehave_arch of VMBehave is
  -- signals for state and next_state (because the state is determined by the output ports)
  signal state, next_state : std_logic_vector(1 downto 0) := "00";
begin
    -- mealy machine: output determined by current state and the current inputs
    -- process current state and current inputs
    process(state, D, N)
      variable input : std_logic_vector( 1 downto 0) := "00";
      variable output : std_logic_vector( 1 downto 0) := "00";
    begin
      -- default values
      rtn_nickel <= '0';
      disp_drink <= '0';
      -- var for concatenated inputs to make things simpler
      input := (d&n);
      case state is
        when "00" => -- $0.00
          -- evaluate inputs and set next state
          case input is
            when "00" => -- nothing
              next_state <= "00"; -- 0 cents
              output := "00";
            when "01" => -- nickel entered
              next_state <= "01"; -- 5 cents
              output := "00";
            when "10" => -- dime entered
              next_state <= "10"; -- 10 cents
              output := "00";
--            when "11" => --nickel and dime entered -- not possible
            when others => null;
          end case;
        when "01" => -- $0.05
          case input is
            when "00" => -- nothing entered
              next_state <= "01"; -- 5 cents
              output := "00";
            when "01" => -- nickel entered
              next_state <= "10"; -- 10 cents
              output := "00";
            when "10" => -- dime entered
              next_state <= "11"; -- 15 cents
              output := "00";
            when others => null;
          end case;
        when "10" => -- $0.10
          case input is
            when "00" => -- nothing entered
              next_state <= "10"; -- 10 cents
                  output := "00";  
            when "01" => -- nickel entered
              next_state <= "11"; -- 15 cents
              output := "00";
            when "10" => -- dime entered => 20 cents
              next_state <= "00"; -- Next state will be $0.00 because we will disp drink
              output := "01"; -- disp the drink and refund nothing
            when others => null;
          end case;
        when "11" => -- $0.15
          case input is
            when "00" => -- nothing entered
              next_state <= "11"; -- 15 cents
              output := "00";
            when "01" => -- nickel entered  => 20 cents exactly
              next_state <= "00"; -- Next state will be $0.00 because we will disp drink
              output := "01"; -- disp the drink and refund nothing
            when "10" => -- dime entered => 25 cents
              next_state <= "00"; -- Next state will be $0.00 because we will disp drink
              output := "11"; -- disp the drink and refund a nickel
            when others => null;
          end case;
        when others => null;
      end case;
      --  Set the output ports from the value output variable
      rtn_nickel <= output(1); -- msb;
      disp_drink <= output(0); -- lsb;
    end process;

    -- update the current state process
    process(next_state)
    begin
      state <= next_state after delay;
    end process;

end VMBehave_arch;
