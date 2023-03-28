
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Program_Counter is
    Port ( 
            CLK    : in STD_LOGIC;
		    Reset  : in STD_LOGIC;
           PCin : in std_logic_vector(31 downto 0);
           PCout : out std_logic_vector(31 downto 0);
           imm_out    : in std_logic_vector(31 downto 0);
           Branch : in std_logic;
           Zero : in std_logic
         );
end Program_Counter;

architecture Behavioral of Program_Counter is


begin
    process (CLK, Reset)
		begin
			if (Reset = '1') then
				PCout <= X"00000000";
			elsif (RISING_EDGE(CLK)) then
                
				if Branch='1' and Zero='1' then
                    PCout <= PCin + imm_out;
                else
                    PCout <= PCin + 4;
                end if;
			end if;
		end process;

end Behavioral;
