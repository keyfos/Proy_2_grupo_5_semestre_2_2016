`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:19:32 09/22/2016 
// Design Name: 
// Module Name:    MUXRTC 
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
module MUXRTC(
    input [11:0]SMUX1,
    input [11:0]SMUX2,
    input [11:0]SMUX3,
    input [11:0]SMUX4,
	 input [11:0]SMUX5,
	 input [11:0]SMUX6,
	 input [2:0]Select,
    output reg AD,
    output reg RD,
    output reg CS,
    output reg WR,
    output reg [7:0] ADout
    );
	 
always @*
	begin
	case(Select)
	3'b000:begin
			 AD<=SMUX1[11];
			 RD<=SMUX1[10];
			 CS<=SMUX1[9];
			 WR<=SMUX1[8];
			 ADout<=SMUX1[7:0];
			 end
	3'b001:begin
			 AD<=SMUX2[11];
			 RD<=SMUX2[10];
			 CS<=SMUX2[9];
			 WR<=SMUX2[8];
			 ADout<=SMUX2[7:0];
			 end
	3'b010:begin
			 AD<=SMUX3[11];
			 RD<=SMUX3[10];
			 CS<=SMUX3[9];
			 WR<=SMUX3[8];
			 ADout<=SMUX3[7:0];
			 end
	3'b011:begin
			 AD<=SMUX4[11];
			 RD<=SMUX4[10];
			 CS<=SMUX4[9];
			 WR<=SMUX4[8];
			 ADout<=SMUX4[7:0];
			 end
	3'b100:begin
			 AD<=SMUX5[11];
			 RD<=SMUX5[10];
			 CS<=SMUX5[9];
			 WR<=SMUX5[8];
			 ADout<=SMUX5[7:0];
			 end
	3'b101:begin
			 AD<=SMUX6[11];
			 RD<=SMUX6[10];
			 CS<=SMUX6[9];
			 WR<=SMUX6[8];
			 ADout<=SMUX6[7:0];
			 end
	default:begin
			AD<=SMUX1[11];
			RD<=SMUX1[10];
			CS<=SMUX1[9];
			WR<=SMUX1[8];
			ADout<=SMUX1[7:0];
			end
	endcase
	end
endmodule
