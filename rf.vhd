library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File is
  port (
    RegDst   : in  std_logic;
    WriteReg : in  std_logic_vector(4 downto 0);
    WriteData: in  std_logic_vector(31 downto 0);
    ReadReg1 : in  std_logic_vector(4 downto 0);
    ReadReg2 : in  std_logic_vector(4 downto 0);
    ReadData1: out std_logic_vector(31 downto 0);
    ReadData2: out std_logic_vector(31 downto 0)
  );
end Register_File;

architecture Behavioral of Register_File is
  type Memory is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	signal RF : Memory := (
		X"00000000", --$zero - x0
		X"00000002", --$at - x1
		X"00000003", --$v0 - x2
		X"00000004", --$v1 - x3
		X"00000005", --$a0 - x4 
		X"00000006", --$a1 - x5
		X"00000007", --$a2 - x6
		X"00000008", --$a3 - x7
		X"00000009", --$t0 - x8
		X"0000000a", --$t1 - x9
		X"0000000b", --$t2 - x10
		X"0000000c", --$t3 - x11
		X"0000000d", --$t4 - x12
		X"0000000e", --$t5 - x13
		X"00000010", --$t6 - x14
		X"00000011", --$t7 - x15
		X"00000012", --$s0 - x16
		X"00000000", --$s1 - x17
		X"00000001", --$s2 - x18
		X"00000002", --$s3 - x19
		X"00000000", --$s4 - x20
		X"00008000", --$s5 - x21
		X"000000ff", --$s6 - x22
		X"00000000", --$s7 - x23
		X"00000000", --$t8 - x24
		X"0000aaaa", --$t9 - x25
		X"00000000", --$k0 - x26
		X"00000009", --$k1 - x27
		X"00000000", --$global pointer - x28
		X"00000000", --$stack pointer - x29
		X"00000004", --$frame pointer - x30
		X"0000aaba"  --$return address - x31
	);

begin

  process (WriteData, WriteReg, RegDst, ReadReg1, ReadReg2)
  begin
    if RegDst = '1' then -- Write to Register x[rd]
      RF(to_integer(unsigned(WriteReg))) <= WriteData;
    end if;
	
	if ReadReg1 = "00000" then
		ReadData1 <= x"00000000";
	else
		ReadData1 <= RF(to_integer(unsigned(ReadReg1)));
	end if;

	if ReadReg2 = "00000" then
		ReadData2 <= x"00000000";
	else
		ReadData2 <= RF(to_integer(unsigned(ReadReg2)));
	end if;
  	
  end process;
  
end Behavioral;
