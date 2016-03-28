// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : aludec.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the decoded for the Arithmetic Logic Unit
//	functionality. It will decode all instructions pasted to it to
//  perform passed operations. Reference this code in the report for
//  more detailed information.
// -------------------------------------------------------------------
`timescale 1ns / 1ps								//Used for simulation purposes.
module aludec (input [5:0] funct,
			   input [1:0] aluop,
			   output reg [3:0] alucontrol);		//alucontrol modified to support 4 bits vs old 3 bits. 
	always @ (*)
		case (aluop)
		2'b00: alucontrol <= 4'b0010;				//This is for (LW, SW, and ADDI)
		2'b01: alucontrol <= 4'b0110;				//Subtraction operation (for BEQ).
		default: case(funct)						//RTYPE Instructions
			6'b100000: alucontrol <= 4'b0010;		//Addition operation.
			6'b100010: alucontrol <= 4'b0110;		//Subtraction operation.
			6'b100100: alucontrol <= 4'b0000;		//AND operation.
			6'b100101: alucontrol <= 4'b0001;		//OR operation.
			6'b101010: alucontrol <= 4'b0111;		//Set on less than operation.
			6'b000000: alucontrol <= 4'b0011;		//Shift logical left operation.
			6'b000010: alucontrol <= 4'b0101;		//Shift logical right operation.
			6'b100111: alucontrol <= 4'b0100;		//NOR operation.
			6'b100110: alucontrol <= 4'b1000;		//XOR operation.
			6'b000011: alucontrol <= 4'b1001;		//SRA Operation.
			6'b000111: alucontrol <= 4'b1010;		//SRAV Operation.
			6'b000110: alucontrol <= 4'b1011;		//SRLV Operation.
			6'b000100: alucontrol <= 4'b1100;		//SLLV Operation.
			default:   alucontrol <= 4'bxxxx;		//???
		endcase
	endcase
endmodule