// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : adder.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is an adder module, which just adds two numbers together.
// -------------------------------------------------------------------
module adder (input [31:0] a, b, output [31:0] y);
	assign y = a + b;
endmodule
