library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use ieee.std_logic_textio.all;
use std.textio.all;

entity data_mem is
    port (
		pcout : in std_logic_vector(31 downto 0);
        addr: in std_logic_vector(31 downto 0);  -- address input
        data_in: in std_logic_vector(31 downto 0);  -- data input
        mem_write: in std_logic;  -- write enable input
        mem_read: in std_logic;  -- read enable input
        mem_to_reg: in std_logic;  -- memory to register input
        data_out: out std_logic_vector(31 downto 0)  -- data output
    );
end data_mem;

architecture Behavioral of data_mem is
file dm_file : text open write_mode is "dm_data.txt";
      type Memory is array (0 to 47) of STD_LOGIC_VECTOR(31 downto 0);
	signal mem : Memory := (
		X"00000055",
		X"000000AA",
		X"00000011",
		X"00000033",
		X"00000022",
		X"00000044",
		X"00000055",
		X"00000066",
		X"00000077",
		X"00000088",
		X"00000099",
		X"000000bb",
		X"000000cc",
		X"000000dd",
		X"000000ee",
		X"00000100",
		X"00000200",
		X"00000300",
		X"00000400",
		X"00000500",
		X"00000600",
		X"00000700",
		X"00000800",
		X"00000900",
		X"00000a00",
		X"00000b00",
		X"00000c00",
		X"00000d00",
		X"00000e00",
		X"00000110",
		X"00000220",
		X"00000320",
		X"00000420",
		X"00000520",
		X"00000620",
		X"00000720",
		X"00000820",
		X"00000920",
		X"00000a20",
		X"00000b20",
		X"00000c20",
		X"00000d20",
		X"00000e20",
		X"00000f20",
		X"00000330",
		X"00000340",
		X"00000350",
		X"00000360"
	);
begin
    process (addr, data_in, mem_write, mem_read)
	variable row          : line;
    begin
        if mem_write = '1' then  -- write operation
            mem(to_integer(unsigned(addr))) <= data_in;
		end if;
        -- if mem_read = '1' then  -- read operation
            if mem_to_reg = '1' then
                data_out <= mem(to_integer(unsigned(addr)));
            else 
                data_out <= addr;
            end if;
        -- end if;
	hwrite(row,pcout, right, 15);
	
	writeline(dm_file,row);
	for i in 0 to 47 loop
		write(row,i, right, 15);
      
		hwrite(row,mem(i), right, 15);
		
		writeline(dm_file,row);
	end loop;
    end process;
end Behavioral;
