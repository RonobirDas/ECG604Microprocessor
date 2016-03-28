// -------------------------------------------------------------------
//  COPYRIGHT (C) 2016, University of Nevada, Las Vegas                                  
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE      
//  EXPRESSED WRITTEN CONSENT OF RONOBIR DAS, JONATHAN YOUNG, AND EMMA REGENTOVA
//  Name:                 University of Nevada, Las Vegas         
//  university_address1   4505 S. Maryland Parkway, Las Vegas, NV, 89154               
//  unlv_address2         ece.unlv.edu                                     
// -------------------------------------------------------------------
//  Title       : datapth.v
//  Author      : RONOBIR DAS and JONATHAN YOUNG
//  Description : This is the general data path, which is controlled by
//  the control unit. This performs all data manipulation operations.
// -------------------------------------------------------------------

`timescale 1ns / 1ps								//Used for simulation purposes.
module datapath (input			clk, reset,
				 input 			memtoreg, pcsrc,
				 input 			alusrc, regdst,
				 input 			regwrite, 
				 input	[3:0]	jump,				//Jump signal operation.
				 input	[3:0]	alucontrol,			//Allows 4-bits for operation of ALU.
				 output 		zero,
				 output	[31:0]	pc,
				 input	[31:0]	instr,
				 output	[31:0]	aluout, writedata,
				 input	[31:0]	readdata);

//Registry and bus lines.
wire [4:0] writereg;
wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
wire [31:0] signimm, signimmsh;
wire [31:0] srca, srcb;
wire [31:0] result;
wire [4:0] wra3;									//Write address lines for Address Port in Register File. Changed from 32-bits to 5-bits.
wire [31:0] wrd3;									//wire for data write port WD3 
wire [31:0] wj; 

//Design Instantiations - next PC logic
flopr #(32) pcreg(clk, reset, pcnext, pc);
adder pcadd1 (pc, 32'b100, pcplus4);
sl2 immsh(signimm, signimmsh); 
adder pcadd2(pcplus4, signimmsh, pcbranch);
mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
mux2 #(32) jumpmux({pcplus4[31:28], instr[25:0], 2'b00}, writedata, jump[1], wj); 
mux2 #(32) pcmux(pcnextbr, wj,jump[0], pcnext);

//Register file logic, which controls memory.
mux2 #(5) jaladdressmux(writereg, 5'd31 ,jump[2],wra3);//Corrected issue with wra3 here, by changed #(32) to #(5).
mux2 #(32) jalwritedatamux(result, pcplus4 ,jump[3],wrd3);
regfile rf(clk, regwrite, instr[25:21],
		   instr[20:16], wra3, wrd3, srca, writedata);//Corrected issue with wra3 here.
mux2 #(5) wrmux(instr[20:16], instr[15:11],regdst, writereg);
mux2 #(32) resmux(aluout, readdata, memtoreg, result);
signext se(instr[15:0], signimm);

//ALU Logic
mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
alu alu(srca, srcb, alucontrol,instr[10:6], aluout, zero);

endmodule