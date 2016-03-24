// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : alu.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the Arithmetic Logic Unit (ALU), which performs
//  all of the functions passed to it by the ALU Decoder.
// -------------------------------------------------------------------

`timescale 1ns / 1ps								//Used for simulation purposes.
module alu (
	input [31:0] a,b,
	input [3:0] sel,
	input [4:0] shamt,
	output reg [31:0] out,
	output reg zero
	);

initial
begin
	out  = 0;
	zero = 1'b0;
end
always @ (*) 
begin 
case(sel) 
default:
begin
out = 0; 
zero = 1'b0; 
end
4'b0000:										//AND Operation.
begin
out=a & b; 
if (out == 0)
zero = 1;  
else
zero = 0;
end                   
4'b0001:										//OR Operation.
begin
out= a | b; 
if (out == 0)
zero = 1;  
else
zero = 0; 
end		
4'b0110:										//Subtraction Operation.
begin
out=a-b;  
if (out == 0)
zero = 1;  
else
zero = 0;
end              
4'b0010:										//Addition Operation.
begin
out=a+b;  
if (out == 0)
zero = 1;  
else
zero = 0;
end         
4'b0111:										//Set Less Than Operation.
begin
if ( a < b)
out = 1;  
else
out=0;
end 
 4'b0011:										//Shift Logical Left Operation.
 begin
 out = b << shamt;
 if (out == 0)
 zero = 1;  
 else
 zero = 0; 
 end 
 4'b0101:										//Shift Logical Right Operation.
 begin
 out = b >> shamt;
 if (out == 0)
 zero = 1;  
 else
 zero = 0;
 end
 4'b0100:										//NOR Operation.
 begin
 out= ~(a | b); 
 if (out == 0)
 zero = 1;  
 else
 zero = 0;
 end 
4'b1000:										//XOR Operation
begin
out= a ^ b; 
if (out == 0)
zero = 1;  
else
zero = 0;
end 
endcase
end
endmodule