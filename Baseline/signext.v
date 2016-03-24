// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : signext.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the sign extender used for PC branching.
// -------------------------------------------------------------------
module signext (input [15:0] a,
	output [31:0] y);
assign y = {{16{a[15]}}, a};
endmodule