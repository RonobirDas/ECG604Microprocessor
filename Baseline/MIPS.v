// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : MIPS.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This module combines the data path and the controller.
// -------------------------------------------------------------------

`timescale 1ns / 1ps								//Used for simulation purposes.
module mips (input clk, reset,
	output [31:0] pc,
	input [31:0] instr,
	output memwrite,
	output [31:0] aluout,
	writedata,
	input [31:0] readdata,
	output byte_enable
);

//wire and reg definitions.
wire memtoreg; 
wire [1:0] branch; 
wire alusrc, regdst, regwrite, zero, pcsrc;
wire [3:0]jump;
wire [3:0] alucontrol;

//module instantiations
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