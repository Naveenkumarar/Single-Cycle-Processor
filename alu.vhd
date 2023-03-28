library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port (
    Op1     : in  std_logic_vector(31 downto 0);
    Op2     : in  std_logic_vector(31 downto 0);
    ALUControl: in std_logic_vector(3 downto 0);
    imm_out    : in std_logic_vector(31 downto 0);
    AluSrc    : in std_logic;
    Zero    : out std_logic;
    Result  : out std_logic_vector(31 downto 0)
  );
end entity ALU;

architecture Behavioral of ALU is
begin
  process (Op1, Op2, ALUControl)
    variable ResultTmp: std_logic_vector(31 downto 0);
  begin
    if AluSrc = '1' then
      case ALUControl is
        when "0010" => ResultTmp :=STD_LOGIC_VECTOR(UNSIGNED(Op1) + UNSIGNED(imm_out));  -- add
        when "0110" => ResultTmp := STD_LOGIC_VECTOR(UNSIGNED(Op1) - UNSIGNED(imm_out));   -- sub
        when "0000" => ResultTmp := Op1 and imm_out; -- and
        when "0001" => ResultTmp := Op1 or imm_out;  -- or
        when others  => ResultTmp := (others => 'X');
      end case;
    else 
      case ALUControl is
        when "0010" => ResultTmp := STD_LOGIC_VECTOR(UNSIGNED(Op1) + UNSIGNED(Op2));   -- add
        when "0110" => ResultTmp := STD_LOGIC_VECTOR(UNSIGNED(Op1) - UNSIGNED(Op2));   -- sub
        when "0000" => ResultTmp := Op1 and Op2; -- and
        when "0001" => ResultTmp := Op1 or Op2;  -- or
        when others  => ResultTmp := (others => 'X');
      end case;

    end if;

 
      if ResultTmp = X"00000000" then
        Zero <= '1';
      else
        Zero <= '0';
      end if;

    Result <= ResultTmp;
  end process;
end architecture Behavioral;
