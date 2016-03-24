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
//Takes 5 input lines and assigns it to the 4 leds on the SOCkit
module ledcount (input [5:0] A, output [3:0] B);
assign B = A / 4; 
endmodule  
 
