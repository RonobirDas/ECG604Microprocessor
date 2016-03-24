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
module dmem (
input clk, 
input we, 
input byte_enable,
input [31:0] a, wd,
output reg [31:0] rd
);
reg [31:0] RAM[63:0];


//assign rd = RAM[a[31:2]]; // word aligned -- This has been deprecated

//combinational logic - read out

always @ (a) // we can pretty much monitor anything so we can use * but I'll set it to monitor a

if (byte_enable == 1)

/*
* Compound statement, involving multidimensional bit indexing, bit concatentation, byte alignment and high order bit padding
* First: we only need the low order bits, byte aligned
*Second: load byte is signed, so you need to pad the rest of the bits  
*/
// {} is the bus select and concatenation operator. Putting 24 infront of it replicates the bit selected 24 times to the high order 24 bits
// [][], first is the address selection, the second is the bit selection of the resulting register
rd = {{24{RAM[a[31:2]][7]}}, RAM[a[31:2]][7:0]};

else 
//load word
rd = RAM[a[31:2]]; //word aligned


//sequential logic - write in

always @ (posedge clk)
if (we == 1)
begin
// store byte
if(byte_enable == 1)
RAM[a[31:0]] <= wd;
else
// store word 
begin
RAM[a[31:2]] <= wd;
end
end

endmodule