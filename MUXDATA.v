`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:33:25 09/30/2016 
// Design Name: 
// Module Name:    MUXDATA 
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
module MUXDATA(
    input [23:0] datos11,
    input [23:0] datos12,
	 input [23:0] datos21,
    input [23:0] datos22,
	 input ap1,
	 input ap2,
	 input [1:0]seleccion,
    output reg [7:0] hora,
	 output reg [7:0] min,
    output reg [7:0] seg,
    output reg [7:0] dia,
	 output reg [7:0] mes,
	 output reg [7:0] year,
	 output reg ampm
    );
always @*
	begin
	case(seleccion)
		2'b00:begin
			hora<=datos11[23:16];
			min<=datos11[15:8];
			seg<=datos11[7:0];
			dia<=datos12[23:16];
			mes<=datos12[15:8];
			year<=datos12[7:0];
			ampm<=ap1;
			end
		2'b01:begin
			hora<=datos21[23:16];
			min<=datos21[15:8];
			seg<=datos21[7:0];
			dia<=datos12[23:16];
			mes<=datos12[15:8];
			year<=datos12[7:0];
			ampm<=ap2;
			end
		2'b10:begin
			hora<=datos11[23:16];
			min<=datos11[15:8];
			seg<=datos11[7:0];
			dia<=datos22[23:16];
			mes<=datos22[15:8];
			year<=datos22[7:0];
			ampm<=ap1;
			end
		default:begin
			hora<=datos11[23:16];
			min<=datos11[15:8];
			seg<=datos11[7:0];
			dia<=datos12[23:16];
			mes<=datos12[15:8];
			year<=datos12[7:0];
			ampm<=ap1;
			end
	endcase 
	end

endmodule
