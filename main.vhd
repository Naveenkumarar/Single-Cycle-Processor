library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Main is
	port (
		CLK   : in STD_LOGIC;
		Reset : in STD_LOGIC
	);
end Main;

architecture Behavioral of Main is
	----------------------------------------------------------------------------------
	-- Components
	----------------------------------------------------------------------------------
	component Program_Counter is
		port (
            CLK    : in STD_LOGIC;
		    Reset  : in STD_LOGIC;
			PCin : in std_logic_vector(31 downto 0);
           PCout : out std_logic_vector(31 downto 0);
           imm_out    : in std_logic_vector(31 downto 0);
           Branch : in std_logic;
           Zero : in std_logic
           );
	end component;
	
	component Instruction_Memory is
		port (
			Address     : in STD_LOGIC_VECTOR(31 downto 0);
			Instruction : out STD_LOGIC_VECTOR(31 downto 0)
		);
	end component;
	
	component control_unit is
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
	end component;
	
	
	component Register_File is
		port (
            RegDst   : in  std_logic;
            WriteReg : in  std_logic_vector(4 downto 0);
            WriteData: in  std_logic_vector(31 downto 0);
            ReadReg1 : in  std_logic_vector(4 downto 0);
            ReadReg2 : in  std_logic_vector(4 downto 0);
            ReadData1: out std_logic_vector(31 downto 0);
            ReadData2: out std_logic_vector(31 downto 0)
        );
	end component;
	
	component ALU is
		port (
                Op1     : in  std_logic_vector(31 downto 0);
                Op2     : in  std_logic_vector(31 downto 0);
                ALUControl: in std_logic_vector(3 downto 0);
                imm_out    : in std_logic_vector(31 downto 0);
                AluSrc    : in std_logic;
                Zero    : out std_logic;
                Result  : out std_logic_vector(31 downto 0)
            );
	end component;
	

	
	component alu_control is
		Port ( 
                funct3 : in  STD_LOGIC_VECTOR (2 downto 0);
                funct7 : in  STD_LOGIC_VECTOR (6 downto 0);
                alu_op : in  STD_LOGIC_VECTOR (1 downto 0);
                alu_ctl : out STD_LOGIC_VECTOR (3 downto 0)
            );
	end component;
	
	component data_mem is
		 port (
                addr: in std_logic_vector(31 downto 0);  -- address input
                data_in: in std_logic_vector(31 downto 0);  -- data input
                mem_write: in std_logic;  -- write enable input
                mem_read: in std_logic;  -- read enable input
                mem_to_reg: in std_logic;  -- memory to register input
                data_out: out std_logic_vector(31 downto 0)  -- data output
            );
	end component;

    component Immediate_gen is
		port (
                instruction : in  std_logic_vector(31 downto 0);
                imm_out    : out std_logic_vector(31 downto 0)
            );
	end component;
	
	
	

	
	----------------------------------------------------------------------------------
	-- Signals
    
    -- program counter
    signal pcin : STD_LOGIC_VECTOR(31 downto 0);
	signal pcout : STD_LOGIC_VECTOR(31 downto 0);
	
    --instruction memory
	signal address : STD_LOGIC_VECTOR(31 downto 0);
	signal instruction : STD_LOGIC_VECTOR(31 downto 0);

    --register file
    signal writereg :   STD_LOGIC_VECTOR(4 downto 0);
    signal readreg1 :   STD_LOGIC_VECTOR(4 downto 0);
    signal readreg2 :   STD_LOGIC_VECTOR(4 downto 0);
    signal readdata1:  STD_LOGIC_VECTOR(31 downto 0);
    signal readdata2:  STD_LOGIC_VECTOR(31 downto 0);

    --immedidate gen
    signal immOut : STD_LOGIC_VECTOR(31 downto 0);

    --alu control
    signal f3 : STD_LOGIC_VECTOR(2 downto 0);
    signal f7 : STD_LOGIC_VECTOR(6 downto 0);
    signal aluCtl: STD_LOGIC_VECTOR(3 downto 0);

    --alu
    signal zero : STD_LOGIC;
    signal result : STD_LOGIC_VECTOR(31 downto 0);

    --data memory
    signal dataout : STD_LOGIC_VECTOR(31 downto 0);

    --control unit
    signal opcode :  STD_LOGIC_VECTOR(6 downto 0);
    signal  aluOp :  STD_LOGIC_VECTOR(1 downto 0);
    signal regWrite :  STD_LOGIC;
    signal memRead :  STD_LOGIC;
    signal  memWrite :  STD_LOGIC;
    signal branch :  STD_LOGIC;
    signal memToTeg :  STD_LOGIC;
    signal aluSrc :  STD_LOGIC;

begin

	opcode <= instruction(6 downto 0);
	f3 <= instruction(14 downto 12);
	f7 <= instruction(31 downto 25);
    writereg <= instruction (11 downto 7);
    readreg1 <= instruction (19 downto 15);
    readreg2 <= instruction (24 downto 20);
	----------------------------------------------------------------------------------
	-- Port Map of Components
	----------------------------------------------------------------------------------
	
    PC     	 	: Program_Counter port map (CLK,Reset,pcout, pcout, immOut, branch,zero);
	IM          : Instruction_Memory port map (pcout,instruction);
    RF          : Register_File port map (regWrite,writereg,dataout,readreg1,readreg2,readdata1,readdata2);
    IMG         : Immediate_gen port map (instruction,immOut);
    ALUC        : alu_control port map (f3,f7,aluOp,aluCtl);
    ALUP         : ALU port map (readdata1,readdata2,aluCtl,immOut,aluSrc,zero,result);
    DM          : data_mem port map (result,readdata2,memWrite,memRead,memToTeg,dataout);
    CTL         : control_unit port map (opcode,f3,aluOp,regWrite,memRead,memWrite,branch,memToTeg,aluSrc);
end Behavioral;
