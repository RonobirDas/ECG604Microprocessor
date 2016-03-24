// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : testbench.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the main testbench file for design verification
//  of the MIPs processor. It will verify functionality by loading a test
//  file with various instructions to ensure it matches the expected values.

// IN PROGRESS

// -------------------------------------------------------------------

module testbench();
reg clk;
reg reset;
wire [31:0] writedata, dataadr;
wire memwrite;
// instantiate device to be tested
top dut (clk, reset, writedata, dataadr, memwrite);
// initialize test
initial
begin
reset <= 1; # 22; reset <= 0;
end
// generate clock to sequence tests
always
begin
clk <= 1;
 # 5; 
 clk <= 0;
 # 5; // clock duration
end
// check results
always @ (negedge clk)
begin
if (memwrite) begin
if (dataadr === 84 & writedata === 7) begin
$display ("Simulation succeeded");
$stop;
end else if (dataadr !== 80) begin
$display ("Simulation failed");
$stop;
end
end
end
endmodule
