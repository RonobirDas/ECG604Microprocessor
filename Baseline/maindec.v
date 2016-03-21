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
// Description : Please refer to the appropriate page of the documentation notes
//               
// $Id$ 
//------------------------------------------------------------------- 
`timescale 1ns / 1ps
module maindec (input [5:0] op, 
input [5:0] funct_pass, 
output memtoreg, memwrite, 
output [1:0] branch, 
output alusrc,
output regdst, regwrite, 
output [3:0]jump, 
output [1:0] aluop, 
output byte_enable, 
output reg [5:0] funct);

reg [14:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop , byte_enable}  = controls;

always @ (funct_pass)
case(op)
6'b001101: funct = 6'b100101; //ori
6'b001110: funct = 6'b100110; //xori
6'b001100: funct = 6'b100100; //andi
default: funct = funct_pass; 
endcase

always @ (*)
 case(op)
6'b000000 :
begin  
if(funct_pass == 6'b001000)
begin
controls <= 15'b000000000110010 ; //jr
end
else if(funct_pass == 6'b001001)
begin
controls <= 15'b100000000111110 ; //jalr
end 
else
controls <= 15'b110000010000000 ; 		//Rtype, non-jump
end
//Load & Store Instructions 
6'b100011 :  controls <= 15'b101000100000000; 		//LW
6'b101011 :  controls <= 15'b001001000000000 ; 		//SW
6'b100000 : controls <= 15'b101000100000001 ; //LB
6'b101000 : controls <= 15'b001001000000001 ; //SB
//Branching Instructions
6'b000100 :  controls <= 15'b000010001000000 ; 		//BEQ
6'b000101 : controls <= 15'b000110001000000 ; //bne
// Immediate Instructions
6'b001000 :  controls <= 15'b101000000000000; 		//ADDI OPCode: 00100 or 8 
6'b001100 :  controls <= 15'b101000010000000 ; 		//ANDI						
6'b001101 :  controls <= 15'b101000010000000 ; 		//ORI
6'b001110:  controls  <= 15'b101000010000000 ; // XORI

//Jump Type 
6'b000010 :  controls <= 15'b000000000000010 ; 		//J

default:  controls <= 15'bX ; 		//???
endcase
endmodule



