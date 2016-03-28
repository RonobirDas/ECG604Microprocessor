// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : maindec.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the main decoder for decoding the OPCODES
//  in the memory file (passed program) to determine CPU functionality.
// -------------------------------------------------------------------

`timescale 1ns / 1ps								//Used for simulation purposes.
module maindec (input	[5:0]	op, 
				input	[5:0]	funct_pass,			//New
				output			memtoreg, memwrite, 
				output	[1:0]	branch, 			//Adjusted
				output			alusrc,
				output			regdst, regwrite, 
				output	[3:0]	jump,				//Adjusted
				output	[1:0]	aluop, 
				output 			byte_enable, 		//New
				output reg [5:0] funct);			//Why is a reg here? New

reg [14:0] controls;								//Adjusted size.

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop , byte_enable}  = controls;

always @ (funct_pass or op)
case(op)
6'b001101: funct = 6'b100101;						//OR Immediate
6'b001110: funct = 6'b100110;						//XOR Immediate
6'b001100: funct = 6'b100100;						//AND Immediate
default: funct = funct_pass; 
endcase

always @ (*)
case(op)
6'b000000:
	begin
	if(funct_pass == 6'b001000)
		begin
		controls <= 15'b000000000110010;			//Jump Register
		end
	else if(funct_pass == 6'b001001)
		begin
		controls <= 15'b100000000111110;			//Jump and Link Register
		end 
	else
		controls <= 15'b110000010000000;			//R-type, non-jump
	end

//Load & Store Instructions
6'b100011:  controls <= 15'b101000100000000; 		//Load Word
6'b101011:  controls <= 15'b001001000000000; 		//Store Word
6'b100000:  controls <= 15'b101000100000001; 		//Load Byte
6'b101000:  controls <= 15'b001001000000001;		//Store Byte

//Branching Instructions
6'b000100:  controls <= 15'b000010001000000; 		//Branch if equal
6'b000101:  controls <= 15'b000110001000000; 		//Branch if not equal

// Immediate Instructions
6'b001000:  controls <= 15'b101000000000000; 		//Add Immediate
6'b001100:  controls <= 15'b101000010000000; 		//And Immediate						
6'b001101:  controls <= 15'b101000010000000; 		//OR Immediate
6'b001110:  controls <= 15'b101000010000000;		//AND Immediate

//Jump Type 
6'b000010:  controls <= 15'b000000000000010; 		//Jump Instruction

default:	controls <= 15'bxxxxxxxxxxxxxxx;		//Illegal Operation.
endcase
endmodule



