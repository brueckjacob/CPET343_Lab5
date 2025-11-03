

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
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
end entity add_sub;

architecture beh of add_sub is

type state_type is(INPUT_A, INPUT_B, ADD, SUB);
signal state, next_state : state_type;

-- initializes components --
component rising_edge_synchronizer is
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component rising_edge_synchronizer;

component synchronizer_8bit is
  generic (
    bits      : integer:=8
  );
  port (
    clk       : in  std_logic;
    reset     : in  std_logic;
    async_in  : in  std_logic_vector(bits-1 downto 0);
    sync_out  : out std_logic_vector(bits-1 downto 0)
  );
end component synchronizer_8bit;

component seven_seg is
	port (
		clk				    : in std_logic;
		reset			    : in std_logic;
		bcd				    : in std_logic_vector(3 downto 0);
		seven_seg_out	    : out std_logic_vector(6 downto 0)
	);
end component seven_seg;

component bin_to_bcd is
  port (
    bin_in			: in  std_logic_vector(7 downto 0);
		ones_bcd		: out std_logic_vector(3 downto 0);
		tens_bcd		: out std_logic_vector(3 downto 0);
		hundreds_bcd	: out std_logic_vector(3 downto 0)
	);
end component bin_to_bcd;

component fsm_controller is
  port (
    a_syn         : in  std_logic_vector(7 downto 0);
    b_syn         : in  std_logic_vector(7 downto 0);
    clk           : in  std_logic;
    reset         : in  std_logic;
    next_btn      : in  std_logic;
    display_val   : out std_logic_vector(7 downto 0)
  );
end component fsm_controller;


  constant     bits            : integer := 8;
  -- initializes signals --
  signal result, input                        : std_logic;
  signal next_button                          : std_logic;
  signal syn_a, syn_b, sum, diff              : std_logic_vector(bits-1 downto 0);
  signal ones, tens, hundreds                 : std_logic_vector(3 downto 0);
  signal output                               : std_logic_vector(bits-1 downto 0);

begin
  -- ports all functions --
  u_rising_add  : rising_edge_synchronizer
    port map (
      clk => clk,
      reset => reset,
      input => next_btn,
      edge => next_button
    );
  
  u_sync_a  : synchronizer_8bit
    generic map (
      bits => bits
    )
    port map (
      clk => clk,
      reset => reset,
      async_in => a,
      sync_out => syn_a
    );
	
  u_sync_b  : synchronizer_8bit
    generic map (
      bits => bits
    )
    port map (
      clk => clk,
      reset => reset,
      async_in => b,
      sync_out => syn_b
    );
    
  u_fsm : fsm_controller
    port map(
      a_syn => syn_a,
      b_syn => syn_b,
      clk   => clk,
      reset => reset,
      next_btn => next_button,
      display_val => output
    );
    
    u_bcd : bin_to_bcd
      port map(
        bin_in => output,
        ones_bcd => ones,
        tens_bcd => tens,
        hundreds_bcd => hundreds
      );
      
    u_seg_ones: seven_seg
      port map(
        clk => clk,
        reset => reset,
        bcd => ones,
        seven_seg_out => seg_ones
      );
      
    u_seg_tens: seven_seg
      port map(
        clk => clk,
        reset => reset,
        bcd => tens,
        seven_seg_out => seg_tens
      );
      
    u_seg_hundreds: seven_seg
      port map(
        clk => clk,
        reset => reset,
        bcd => hundreds,
        seven_seg_out => seg_hundreds
      );
  
end beh;