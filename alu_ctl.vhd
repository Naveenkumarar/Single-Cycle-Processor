library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity alu_control is
    Port ( funct3 : in  STD_LOGIC_VECTOR (2 downto 0);
            funct7 : in  STD_LOGIC_VECTOR (6 downto 0);
           alu_op : in  STD_LOGIC_VECTOR (1 downto 0);
           alu_ctl : out STD_LOGIC_VECTOR (3 downto 0));
end alu_control;

architecture Behavioral of alu_control is

begin
    process(funct7,funct3, alu_op)
    begin

        case alu_op is
            when "00" => --I-type instructions
                alu_ctl <= "0010"; --add
                -- case funct3 is
                --     when "000" => --addi
                --         alu_ctl <= "0000"; --addi
                --     when "010" => --lw
                --         alu_ctl <= "0000"; --lw
                --     when others =>
                --         alu_ctl <= "XXXX"; --invalid instruction
                -- end case;
                
            when "01" => --R-type instructions
                case funct3 is
                    when "000" => --add
                        if funct7 = "0000000" then
                            alu_ctl <= "0010"; --add
                        elsif funct7 = "0100000" then
                            alu_ctl <= "0110"; --sub
                        end if;
                    when "111" => --and
                        alu_ctl <= "0000"; --and
                    when "110" => --or
                        alu_ctl <= "0001"; --or
                        
                    when others =>
                        alu_ctl <= "XXXX"; --invalid instruction
                end case;
            
            when "11" => --S-Type 
                case funct3 is
                    when "010" => --sw
                        alu_ctl <= "0010"; --sw
                    when others =>
                        alu_ctl <= "XXXX"; --invalid instruction
                
                end case;
                
                
            when "10" => --SB-Type
                case funct3 is
                    when "000" => --beq
                        alu_ctl <= "0110"; --beq
                    when others =>
                        alu_ctl <= "XXXX"; --invalid instruction
                
                end case;
                
            when others =>
                alu_ctl <= "XXXX"; --invalid instruction
        end case;
    end process;

end Behavioral;
