library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory is

    port (
        Address : in std_logic_vector(31 downto 0);
        Instruction : out std_logic_vector(31 downto 0)
    );
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

    type Memory is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	signal IMem : Memory := (
         X"01390a33",
         X"416a8bb3",
         X"013b7c33",
         X"016ced33",
         X"ffdd8e13",
         X"020f2e83",
         X"03f9a023",
         X"fe0e02e3",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
         X"00000000",
		 X"00000000"
	);

begin

    Instruction <= IMem(to_integer(unsigned(Address))/4);

end Behavioral;
