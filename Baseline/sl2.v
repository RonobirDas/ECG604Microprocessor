// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : sl2.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This unit is dedicated to shifting left by 2. The code
//  is provided from Harris and Harris text.
// -------------------------------------------------------------------
module sl2 (input [31:0] a, output [31:0] y);
	//Shift left by 2.
	assign y = {a[29:01], 2'b00};
endmodule 