library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
    port (
        opcode : in std_logic_vector(6 downto 0);
        funct3 : in std_logic_vector(2 downto 0);
        alu_op : out std_logic_vector(1 downto 0);
        reg_write : out std_logic;
        mem_read : out std_logic;
        mem_write : out std_logic;
        branch : out std_logic;
        mem_to_reg : out std_logic;
        alu_src : out std_logic
    );
end entity control_unit;

architecture rtl of control_unit is
begin
    process (opcode, funct3)
    begin
        case opcode is
            when "0110011" => -- R-type instructions
                alu_op <= "01";
                reg_write <= '1';
                mem_read <= '0';
                mem_write <= '0';
                branch <= '0';
                mem_to_reg <= '0';
                alu_src <= '0';
            when "0010011" => -- I-type instructions addi
                alu_op <= "00";
                reg_write <= '1';
                mem_read <= '0';
                mem_write <= '0';
                branch <= '0';
                mem_to_reg <= '0';
                alu_src <= '1';
            when "0000011"  => -- I-type instructions lw
                alu_op <= "00";
                reg_write <= '1';
                mem_read <= '1';
                mem_write <= '0';
                branch <= '0';
                mem_to_reg <= '1';
                alu_src <= '1';
            when "0100011" => -- S-type sw instruction
                alu_op <= "11";
                reg_write <= '0';
                mem_read <= '0';
                mem_write <= '1';
                branch <= '0';
                mem_to_reg <= '0';
                alu_src <= '1';
            when "1100011" => -- SB-type beq instruction
                alu_op <= "10";
                reg_write <= '0';
                mem_read <= '0';
                mem_write <= '0';
                branch <= '1';
                mem_to_reg <= '0';
                alu_src <= '0';
            when others  => 
                alu_op <= "10";
                reg_write <= '0';
                mem_read <= '0';
                mem_write <= '0';
                branch <= '1';
                mem_to_reg <= '0';
                alu_src <= '0';
        end case;
    end process;
end architecture rtl;
