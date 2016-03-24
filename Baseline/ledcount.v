// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : ledcount.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This unit is responsible for taking 5 input lines
//  which will be assigned to 4 LEDs on the SOCkit.
// -------------------------------------------------------------------
module ledcount (input [5:0] A, output [3:0] B);
assign B = A / 4; 
endmodule  
 
