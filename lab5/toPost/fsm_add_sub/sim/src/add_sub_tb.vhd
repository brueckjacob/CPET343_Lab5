library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_tb is
end add_sub_tb;


architecture arch of add_sub_tb is
  component add_sub is
    port (
      a             : in  std_logic_vector(7 downto 0);
      b             : in  std_logic_vector(7 downto 0);
      clk           : in  std_logic;
      reset         : in  std_logic;
      next_btn       : in  std_logic;
      seg_hundreds  : out std_logic_vector(6 downto 0);
      seg_tens      : out std_logic_vector(6 downto 0);
      seg_ones      : out std_logic_vector(6 downto 0)
    );
  end component;
 
  constant SEQUENTIAL_FLAG : boolean := true;
 
  -- Signals
  signal a: std_logic_vector(7 downto 0) := (others => '0');
  signal b: std_logic_vector(7 downto 0) := (others => '0');
  signal reset: std_logic := '0';
  signal clk: std_logic := '0';
  signal next_btn: std_logic := '0';
  signal seg_hundreds: std_logic_vector(6 downto 0) := (others => '0');
  signal seg_tens: std_logic_vector(6 downto 0) := (others => '0');
  signal seg_ones: std_logic_vector(6 downto 0) := (others => '0');
  
  begin
    uut: add_sub
    port map (
      a => a,
      b => b,
      reset => reset,
      clk => clk,
      next_btn => next_btn,
      seg_hundreds => seg_hundreds,
      seg_tens => seg_tens,
      seg_ones => seg_ones
    );
    
    clock_sim: process
    begin
      while true loop
        clk <= '0';
        wait for 20 ns;
        clk <= '1';
        wait for 20 ns;
      end loop;
    end process;
    
    sequential_stimuli: if SEQUENTIAL_FLAG generate
      sequential_tb : process
      begin
        
        --reset
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for 40 ns;
        
        --A = 5
        a <= std_logic_vector(to_unsigned(5, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;
        
        --B = 2
        b <= std_logic_vector(to_unsigned(2, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display SUM
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display DIFF
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        --A = 2
        a <= std_logic_vector(to_unsigned(2, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        --B = 5
        b <= std_logic_vector(to_unsigned(5, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display SUM
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display DIFF
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        --A = 200
        a <= std_logic_vector(to_unsigned(200, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        --B = 100
        b <= std_logic_vector(to_unsigned(100, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display SUM
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display DIFF
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        --A = 100
        a <= std_logic_vector(to_unsigned(100, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        --B = 200
        b <= std_logic_vector(to_unsigned(200, 8));
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display SUM
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        -- Display DIFF
        next_btn <= '1'; wait for 50 ns; next_btn <= '0'; wait for 50 ns;

        report "****************** sequential testbench stop ****************";
        wait;
      end process;
    end generate sequential_stimuli;
    

end arch;