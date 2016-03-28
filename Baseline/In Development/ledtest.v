// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : ledtest.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : In progress....
// -------------------------------------------------------------------
module ledtest(); 
reg [5:0] A; 
wire [3:0] B; 
ledcount u1(A, B); 
integer i; 
initial begin 
for (i = 0; i <= 44; i = i + 4)
begin 
A = i; 
end 
$finish;
end  
endmodule 
