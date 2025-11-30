library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity fsm_controller is
  port (
    sw_syn     : in  std_logic_vector(7 downto 0); -- single switch bus (synchronized)
    clk        : in  std_logic;
    reset      : in  std_logic;
    next_btn   : in  std_logic;                    -- single-cycle pulse from button synchronizer
    display_val: out std_logic_vector(11 downto 0);
    state_leds : out std_logic_vector(3 downto 0)  -- 1000=A 0100=B 0010=ADD 0001=SUB
  );
end entity fsm_controller;

architecture beh of fsm_controller is
  type state_type is (INPUT_A, INPUT_B, ADD, SUB);
  signal state : state_type := INPUT_A;
  signal a_reg, b_reg : std_logic_vector(7 downto 0) := (others => '0');

  signal sum9  : unsigned(8 downto 0);
  signal diff9 : unsigned(8 downto 0);
  signal sum_v  : std_logic_vector(11 downto 0);
  signal diff_v : std_logic_vector(11 downto 0);
begin

  -- modulo-512 arithmetic (wraps automatically on unsigned)
  sum9  <= resize(unsigned(a_reg), 9) + resize(unsigned(b_reg), 9);
  diff9 <= resize(unsigned(a_reg), 9) - resize(unsigned(b_reg), 9);

  sum_v  <= std_logic_vector(resize(sum9, 12));
  diff_v <= std_logic_vector(resize(diff9, 12));

  process(clk, reset)
  begin
    if reset = '1' then
      state <= INPUT_A;
      a_reg <= (others => '0');
      b_reg <= (others => '0');
      display_val <= (others => '0');
      state_leds <= "1000";
    elsif rising_edge(clk) then
      if next_btn = '1' then
        case state is
          when INPUT_A =>
            a_reg <= sw_syn;   -- capture switches into A
            state <= INPUT_B;
          when INPUT_B =>
            b_reg <= sw_syn;   -- capture switches into B
            state <= ADD;
          when ADD =>
            state <= SUB;
          when SUB =>
            state <= INPUT_A;
        end case;
      end if;

      -- display live switches when in input states, otherwise show computed results
      case state is
        when INPUT_A =>
          display_val <= std_logic_vector(resize(unsigned(sw_syn), 12));
          state_leds <= "1000";
        when INPUT_B =>
          display_val <= std_logic_vector(resize(unsigned(sw_syn), 12));
          state_leds <= "0100";
        when ADD =>
          display_val <= sum_v;
          state_leds <= "0010";
        when SUB =>
          display_val <= diff_v;
          state_leds <= "0001";
        when others =>
          display_val <= (others => '0');
          state_leds <= "0000";
      end case;
    end if;
  end process;

end architecture;