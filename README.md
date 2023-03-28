# Single-Cycle-Processor

Single Cycle Processor for MIPS using VHDL for following bloack diagram:

Analyze the files:

````
ghdl -a --ieee=synopsys pc.vhd
ghdl -a --ieee=synopsys im.vhd
ghdl -a --ieee=synopsys rf.vhd
ghdl -a --ieee=synopsys alu.vhd
ghdl -a --ieee=synopsys alu_ctl.vhd
ghdl -a --ieee=synopsys imm_gen.vhd
ghdl -a --ieee=synopsys dm.vhd
ghdl -a --ieee=synopsys clu.vhd
ghdl -a --ieee=synopsys main.vhd
````


Analyze, Elaborate and run the testbench:

````
ghdl -a --ieee=synopsys tb.vhd
ghdl -e --ieee=synopsys tb_MIPSProcessor
ghdl -r --ieee=synopsys tb_MIPSProcessor --stop-time=200ns  --fst=demo.fst
````
