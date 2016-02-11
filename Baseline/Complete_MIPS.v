module Complete_MIPS (CLK, RST, A_out, D_out); 

input CLK; 

input RST; 

output [31:0] A_out; 

output [31:0] D_out; 

wire CS, WE; 

wire [31:0] ADDR, Mem_Bus;

assign A_out = ADDR;

assign D_out = Mem_Bus;

MIPS CPU (CLK, RST, CS, WE, ADDR, Mem_Bus);

Memory MEM (CS, WE, CLK, ADDR, Mem_Bus);

endmodule
