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
module alu (
    input [31:0] a,b,
    input [3:0] sel,
    input [4:0] shamt,
    output reg [31:0] out,
 output reg zero
  );
  initial
  begin
  out = 0;
  zero =1'b0;
  end
    always @ (*) 
    begin 
        case(sel) 
default:
begin
out = 0; 
zero = 1'b0; 
end
            4'b0000: //AND 0
	begin
		out=a & b; 
		if (out == 0)
		 zero = 1;  
		else
		zero = 0;
          end                   
            4'b0001: // OR 1
	begin
		out= a | b; 
		if (out == 0)
		 zero = 1;  
		else
		zero = 0; 
end		
            4'b0110: // SUB 6
	begin
		out=a-b;  
		if (out == 0)
		 zero = 1;  
		else
		zero = 0;
          end              
            4'b0010: // ADD 2
	begin
		out=a+b;  
		if (out == 0)
		 zero = 1;  
		else
		zero = 0;
          end         
            4'b0111: // SLT 7
           begin
		 if ( a < b)
		 out = 1;  
		else
		out=0;
          end 
 4'b0011:  // SLL 3
           begin
out = b << shamt;
if (out == 0)
		 zero = 1;  
		else
		zero = 0; 
          end 
 4'b0101: // SRL 5
begin
out = b >> shamt;
		if (out == 0)
		 zero = 1;  
		else
		zero = 0;
end
 4'b0100:  // NOR 4
           begin
		out= ~(a | b); 
		if (out == 0)
		 zero = 1;  
		else
		zero = 0;
          end 
4'b1000: // XOR 8 
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