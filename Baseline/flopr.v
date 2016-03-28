// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : flopr.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is a resettable Flip-Flop from Harris and Harris.
// -------------------------------------------------------------------
module flopr #	(parameter WIDTH = 8)
				(input clk, reset,
				 input [WIDTH-1:0] d,
				 output reg [WIDTH-1:0] q);

	always @ (posedge clk, posedge reset)
		if (reset) q <= 0;
		else 	   q <= d;
endmodule