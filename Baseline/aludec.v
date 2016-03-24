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
module aludec (input [5:0] funct,
input [1:0] aluop,
output reg [3:0] alucontrol); //alucontrol modified to support 4 bits vs old 3 bits. 
always @ (*)

case (aluop)
2'b00: alucontrol <= 4'b0010; // ADD
2'b01: alucontrol <= 4'b0110; // SUB
default: case(funct) // RTYPE
6'b100000: alucontrol <= 4'b0010; // ADD
6'b100010: alucontrol <= 4'b0110; // SUB
6'b100100: alucontrol <= 4'b0000; // AND
6'b100101: alucontrol <= 4'b0001; // OR
6'b101010: alucontrol <= 4'b0111; // SLT
6'b0:      alucontrol <= 4'b0011; // SLL
6'b000010: alucontrol <= 4'b0101; // SRL
6'b100111: alucontrol <= 4'b0100; // NOR
6'b100110: alucontrol <= 4'b1000; // XOR
6'b000011: alucontrol <= 4'b1001; // SRA
6'b000111: alucontrol <= 4'b1010; // SRAV
6'b000110: alucontrol <= 4'b1011; // SRLV
6'b000100: alucontrol <= 4'b1100; // SLLV
default: alucontrol <= 4'bxxxx; // ???
endcase
endcase
endmodule