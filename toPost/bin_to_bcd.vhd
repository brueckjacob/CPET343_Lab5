library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_to_bcd is
	port(
		bin_in			: in  std_logic_vector(7 downto 0);
		ones_bcd		: out std_logic_vector(3 downto 0);
		tens_bcd		: out std_logic_vector(3 downto 0);
		hundreds_bcd	: out std_logic_vector(3 downto 0)
	);
end bin_to_bcd;

architecture beh of bin_to_bcd is
begin
	process(bin_in)
        variable var        : integer;
        variable ones       : integer;
        variable tens       : integer;
        variable hundreds   : integer;
        
    begin
        var := to_integer(unsigned(bin_in));
        
        ones := var mod 10;
        tens := (var/10) mod 10;
        hundreds := value / 100;
        
        ones_bcd        <= std_logic_vector(to_unsigned(ones, 4));
        tens_bcd        <= std_logic_vector(to_unsigned(tens, 4));
        hundreds_bcd    <= std_logic_vector(to_unsigned(hundreds, 4));
    end process;
end beh;