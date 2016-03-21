//-------------------------------------------------------------------
//                                                                 
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas
//                                                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, EMMA REGENTOVA
//                                                                  
//  Name:                    University of Nevada, Las Vegas         
//  university_address1:     4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2:           ece.unlv.edu                                     
//-------------------------------------------------------------------
// Title       : dmem.v
// Author      : RONOBIR DAS & JONATHAN YOUNG
// Description : Data Memory for the MIPS Processor. Modification of H&H text code to include byte handling
//               
// $Id$ 
//------------------------------------------------------------------- 
`timescale 1ns / 1ps
//Inputs and Outputs
module datapath (input clk, reset,
input memtoreg, pcsrc,
input alusrc, regdst,
input regwrite, 
input [3:0] jump, //jump signal now controls 3 muxes
input [3:0] alucontrol, //modified, used to be 3 bits, now 4
output zero,
output [31:0] pc,
input [31:0] instr,
output [31:0] aluout, writedata,
input [31:0] readdata);
//Wires and Regs
wire [4:0] writereg;
wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
wire [31:0] signimm, signimmsh;
wire [31:0] srca, srcb;
wire [31:0] result;
//new wires for the two jump muxes for JAL 
wire [31:0] wra3; //wire for address port A3 on regfile
wire [31:0] wrd3; //wire for data write port WD3 
wire [31:0] wj; 

//Design Instantiations
// next PC logic
flopr #(32) pcreg(clk, reset, pcnext, pc);
adder pcadd1 (pc, 32'b100, pcplus4);
sl2 immsh(signimm, signimmsh); 
adder pcadd2(pcplus4, signimmsh, pcbranch);
mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
mux2 #(32) jumpmux({pcplus4[31:28], instr[25:0], 2'b00}, writedata, jump[1], wj); 
mux2 #(32) pcmux(pcnextbr, wj,jump[0], pcnext); //- now a mux4 or 2 mux 2s

// register file logic
// register file is now muxed twice over, so need two new wires, for address and others. 
mux2 #(32) jaladdressmux(writereg, 5'd31 ,jump[2],wra3); // selection between register 31 for $rs and regular writereg
mux2 #(32) jalwritedatamux(result, pcplus4 ,jump[3],wrd3); //selection between pcplus4 and result from the write data line. 
regfile rf(clk, regwrite, instr[25:21],
instr[20:16], wra3, wrd3, srca, writedata);
mux2 #(5) wrmux(instr[20:16], instr[15:11],regdst, writereg);
mux2 #(32) resmux(aluout, readdata, memtoreg, result);
signext se(instr[15:0], signimm);
// ALU logic
mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
alu alu(srca, srcb, alucontrol,instr[10:6], aluout, zero); // modified, added in the shamt line
endmodule