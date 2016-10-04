`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:10:54 09/30/2016 
// Design Name: 
// Module Name:    Comparador 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Comparador(
    input [7:0] CprogH,
	 input [7:0] CprogM,
	 input [7:0] CprogS,
    input [7:0] CcountH,
	 input [7:0] CcountM,
	 input [7:0] CcountS,
    input en,
    input reset,
	 input clock,
    output reg fin
    );
always @(posedge clock)
	begin
	if (reset)fin<=0;
	else if (en)
		begin
		if(CprogH==CcountH&&CprogM==CcountM&&CprogS==CcountS&&(CprogH!=0||CprogM!=0||CprogS!=0))
		fin<=1;
		else
		fin<=0;
		end
	end
endmodule
