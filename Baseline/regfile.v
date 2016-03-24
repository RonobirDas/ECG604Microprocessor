// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : regfile.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the register file, which has two read ports
//  and a third port for writing on the rising edge of the block.
// -------------------------------------------------------------------
module regfile (input clk, input we3,
	input [4:0] ra1, ra2, wa3,
	input [31:0] wd3,
	output [31:0] rd1, rd2);
reg [31:0] rf[31:0];
always @ (posedge clk)
if (we3) rf[wa3] <= wd3;
assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule