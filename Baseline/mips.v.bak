//-------------------------------------------------------------------
//                                                                 
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas
//                                                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, EMMA REGENTOVA
//                                                                  
//  Name:                   University of Nevada, Las Vegas         
//  university_address1     4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2           ece.unlv.edu                                     
//-------------------------------------------------------------------
// Title       : dmem.v
// Original Author: Dr. Sarah Harris and Dr. David Harris
// Author      : RONOBIR DAS & JONATHAN YOUNG
// Description : Data Memory for the MIPS Processor. Modification of H&H text code to include byte handling
//               
// $Id$ 
//------------------------------------------------------------------- 
`timescale 1ns / 1ps
//Inputs and Outputs, module definitions 
module mips (input clk, reset,
output [31:0] pc,
input [31:0] instr,
output memwrite,
output [31:0] aluout,
writedata,
input [31:0] readdata,
output byte_enable
); //assign the output of byte_enable to the output of the control unit's byte_enable line. Should work. Forgetting if it will. 

//wire and reg definitions
wire memtoreg; 
wire [1:0] branch; 
wire alusrc, regdst, regwrite, zero, pcsrc;
wire [4:0]jump;
wire [3:0] alucontrol;

//module instantions
controller c(instr[31:26], 
instr[5:0], 
zero,
memtoreg, 
memwrite, 
pcsrc,
alusrc, 
regdst, 
regwrite, 
jump, 
alucontrol,
byte_enable);


datapath dp(clk, 
reset, 
memtoreg, 
pcsrc,
alusrc, 
regdst, 
regwrite, 
jump,
alucontrol,
zero, 
pc, 
instr,
aluout, 
writedata, 
readdata);

endmodule