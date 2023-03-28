library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Immediate_gen is
    Port ( instruction : in  std_logic_vector(31 downto 0);
           imm_out    : out std_logic_vector(31 downto 0));
end Immediate_gen;

architecture Behavioral of Immediate_gen is
begin
    process (instruction)
    begin
        case instruction(6 downto 0) is
            when "0010011" | "0000011" => -- addi,lw
                if instruction(31) = '0' then
                    imm_out <= std_logic_vector((31 downto 12 => '0') & signed(instruction(31 downto 20)));
                else
                    imm_out <= std_logic_vector((31 downto 12 => '1') & signed(instruction(31 downto 20)));
                end if;
            when "1100011"  => -- beq
                if instruction(31) = '0' then
                    imm_out <= std_logic_vector((31 downto 13 => '0') & instruction(31) & instruction(7) & signed(instruction(30 downto 25)) & signed(instruction(11 downto 8)) &'0');
                else
                    imm_out <= std_logic_vector((31 downto 13 => '1') & instruction(31) & instruction(7) & signed(instruction(30 downto 25)) & signed(instruction(11 downto 8)) &'0' );
                end if;
            when  "0100011" => -- sw
                if instruction(31) = '0' then
                    imm_out <= std_logic_vector((31 downto 12 => '0') &  signed(instruction(31 downto 25) )& signed(instruction(12 downto 8)));
                else
                    imm_out <= std_logic_vector((31 downto 12 => '1') &  signed(instruction(31 downto 25)) & signed(instruction(12 downto 8) ));
                end if;
            when others =>
                imm_out <= (others => '0');
                
        end case;
    end process;
end Behavioral;

