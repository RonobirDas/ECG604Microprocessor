// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : dmem.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the data memory module. It stores all the 
//  data used from memory and is manipulated using the instruction
//  memory operations from the control unit.
// -------------------------------------------------------------------

`timescale 1ns / 1ps								//Used for simulation purposes.
module dmem (
	input clk, 
	input we, 
	input byte_enable,
	input [31:0] a, wd,
	output reg [31:0] rd 							//Why is reg here?
	);
	reg [31:0] RAM[63:0];

	//combinational logic - Read Out lines (good for LEDs or physical monitoring)
	always @ (a)
		if (byte_enable == 1)
		/*
		* Compound statement, involving multidimensional bit indexing, bit concatenation, byte alignment and high order bit padding
		* First: we only need the low order bits, byte aligned
		* Second: load byte is signed, so you need to pad the rest of the bits
		{} is the bus select and concatenation operator. Putting 24 in front of it replicates the bit selected 24 times to the high order 24 bits
		[][], first is the address selection, the second is the bit selection of the resulting register.*/
			rd = {{24{RAM[a[31:2]][7]}}, RAM[a[31:2]][7:0]};
		else
			rd = RAM[a[31:2]];								//Load Word - where's load byte?

	//Sequential Logic - Data Write In
	always @ (posedge clk)
		if (we == 1)
		begin
			if(byte_enable == 1)
				RAM[a[31:0]] <= wd;							//Store Byte
			else
				RAM[a[31:2]] <= wd;							//Store Word
		end
endmodule