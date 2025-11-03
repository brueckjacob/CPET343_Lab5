-------------------------------------------------------------------------------
-- Jacob Brueck
-- Seven segment display
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- creates seven_seg entity with ports
entity seven_seg is
	port (
		clk				: in std_logic;
		reset			: in std_logic;
		bcd       		: in std_logic_vector(3 downto 0);
		seven_seg_out	: out std_logic_vector(6 downto 0)
	);
end seven_seg;

-- starts architecture for seven_seg
architecture beh of seven_seg is

begin
process(clk,reset)    -- process containing logic
	begin
		if (reset = '1') then
			seven_seg_out <= "1111111";     -- turns of seven segment display when reset is true
		elsif (clk'event and clk = '1') then
			case bcd is
				when "0000"=> seven_seg_out <="1000000";  -- '0'
				when "0001"=> seven_seg_out <="1111001";  -- '1'
				when "0010"=> seven_seg_out <="0100100";  -- '2'
				when "0011"=> seven_seg_out <="0110000";  -- '3'
				when "0100"=> seven_seg_out <="0011001";  -- '4'
				when "0101"=> seven_seg_out <="0010010";  -- '5'
				when "0110"=> seven_seg_out <="0000010";  -- '6'
				when "0111"=> seven_seg_out <="1111000";  -- '7'
				when "1000"=> seven_seg_out <="0000000";  -- '8'
				when "1001"=> seven_seg_out <="0011000";  -- '9'
				when others=> seven_seg_out <="1111111";  -- If bcd is greater than 9 turns off display
			end case;
		end if;
	end process;
end beh;