// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : top.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the top level instantiation of the MIPS
//  architecture. The only two changes from Harris & Harris were the
//  timescale for simulation (added) and the addition of byte_enable.
// -------------------------------------------------------------------
`timescale 1ns / 1ps								//Used for simulation purposes.
module top (input clk, reset,output [31:0] writedata, dataadr,output memwrite);

	//Wires and  REGs
	wire [31:0] pc, instr, readdata;
	wire byte_enable;

	//Instantiate MIPs processor and memory files.
	mips mips (clk, reset, pc, instr, memwrite, dataadr,
			   writedata, readdata, byte_enable);
	imem imem (pc[7:2], instr);
	dmem dmem (clk, memwrite, byte_enable, dataadr, writedata,readdata);

endmodule