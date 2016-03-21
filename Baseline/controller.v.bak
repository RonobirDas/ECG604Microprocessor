//-------------------------------------------------------------------
//                                                                 
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas
//                                                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, EMMA REGENTOVA
//                                                                  
//  Name:                   University of Nevada, Las Vegas         
//  university_address1          4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
//-------------------------------------------------------------------
// Title       : dmem.v
// Author      : RONOBIR DAS & JONATHAN YOUNG
// Description : Data Memory for the MIPS Processor. Modification of H&H text code to include byte handling
//               
// $Id$ 
//------------------------------------------------------------------- 
`timescale 1ns / 1ps
module controller (input [5:0] op, funct,
input zero,
output memtoreg, memwrite,
output reg pcsrc, 
output alusrc,
output regdst, regwrite,
output [4:0]jump,
output [3:0] alucontrol, output byte_enable); //modified for 4 bits
wire [1:0] aluop;
wire [1:0]branch;
wire [5:0] funct_wire;
maindec md(op, funct,
memtoreg, 
memwrite, 
branch,
alusrc, 
regdst, 
regwrite, 
jump,
aluop, byte_enable, funct_wire);
aludec ad (funct_wire, 
aluop, 
alucontrol);
//branch for pcsrc selection
always @ (branch)
if (branch[1] == 0) // BEQ
pcsrc = branch[0] & zero;
else if(branch[1] == 1) //BNE
pcsrc = branch[0] & (~zero); 
endmodule