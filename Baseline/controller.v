// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : controller.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the control unit for the MIPS architecture.
//  This was modified from the Harris & Harris text, referenced in
//  written report.
// ------------------------------------------------------------------- 

`timescale 1ns / 1ps								//Used for simulation purposes.
module controller (input [5:0] op, funct,
	input zero,
	output memtoreg, memwrite,
	output reg pcsrc, 
	output alusrc,
	output regdst, regwrite,
	output [3:0]jump,
	output [3:0] alucontrol, output byte_enable);	//Modified contents for 4-bits.

wire [1:0] aluop;
wire [1:0] branch;
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

//This is the branch implementation for the PCSRC selection.
always @ (branch or zero) begin						//Change made here to adjust for always construct.
	if (branch[1] == 0)	begin						//Branch if equal.
		pcsrc = branch[0] & zero;
	end else if(branch[1] == 1) begin				//Branch if not equal.
		pcsrc = branch[0] & (~zero);
		end
	end
endmodule