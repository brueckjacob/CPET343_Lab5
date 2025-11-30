library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_controller is
  port (
    a             : in  std_logic_vector(7 downto 0);
    b             : in  std_logic_vector(7 downto 0);
    a_syn         : in  std_logic_vector(7 downto 0);
    b_syn         : in  std_logic_vector(7 downto 0);
    clk           : in  std_logic;
    reset         : in  std_logic;
    next_btn      : in  std_logic;
    display_val   : out std_logic_vector(7 downto 0)
  );
end entity fsm_controller;

architecture beh of fsm_controller is

  type state_type is(INPUT_A, INPUT_B, ADD, SUB);
  signal state : state_type := INPUT_A;
  signal sum, diff : std_logic_vector(7 downto 0);
  
  begin
    process(clk, reset)
    begin
      if reset = '1' then
        state <= INPUT_A;
        a <= (others => '0');
        b <= (others => '0');
      elsif rising_edge(clk) then
        if next_btn = '1' then
          case state is
            when INPUT_A =>
              a <= a_syn;
              state <= INPUT_B;
              
            when INPUT_B =>
              b <= b_syn;
              state <= ADD;
              
            when ADD =>
              state <= SUB;
              
            when SUB =>
              state <= INPUT_A;
              
            when others =>
              state <= INPUT_A;
          end case;
        end if;
      end if;
    end process;
    
    
    sum <= std_logic_vector(unsigned(a) + unsigned(b));
    diff <= std_logic_vector(unsigned(a) + unsigned(b));
    
    
    process(state, a, b, sum, diff)
    begin
      case state is
        when INPUT_A    => display_val <= a;
        when INPUT_B    => display_val <= b;
        when ADD        => display_val <= sum;
        when SUB        => display_val <= diff;
        when others     => display_val <= (others => '0');
      end case;
    end process;
end architecture;