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
//Inputs and Outputs
module top (input clk, reset,output [31:0] writedata, dataadr,output memwrite);

//Wires and  REGs

wire [31:0] pc, instr, readdata;
wire byte_enable;

// instantiate processor and memories

mips mips (clk, reset, pc, instr, memwrite, dataadr,
writedata, readdata, byte_enable);
imem imem (pc[7:2], instr);
dmem dmem (clk, memwrite, byte_enable, dataadr, writedata,readdata);
endmodule