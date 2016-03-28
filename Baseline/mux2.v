// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : mux2.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is 2-to-1 multiplexor. This code was taken from
//  the Harris and Harris text.
// -------------------------------------------------------------------

`timescale 1ns / 1ps								//Used for simulation purposes.
module mux2 # (parameter WIDTH = 8)
			  (input [WIDTH-1:0]	d0, d1,
			   input				s,
			   output [WIDTH-1:0]	y);
			  
	assign y = s ? d1 : d0;
endmodule