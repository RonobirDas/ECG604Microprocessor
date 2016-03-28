// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : imem.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the instruction memory module. Reference the
//  report for more information. This module is important for loading
//  programs operations.
// -------------------------------------------------------------------
module imem (input [5:0] a, output [31:0] rd);
	reg [31:0] RAM[63:0];
	initial
		begin
			$readmemh ("memfile.dat",RAM);
		end

	assign rd = RAM[a];							//Word alligned memory.
endmodule