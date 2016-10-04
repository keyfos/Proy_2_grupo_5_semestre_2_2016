`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:12 09/18/2016 
// Design Name: 
// Module Name:    mux_colores 
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
module mux_colores(
    input video_on,
	 input [11:0] color,
	 output reg [11:0] RGB
	 );
	 always @*
	 begin
	 if (video_on)
		RGB=color;
	 else
		RGB=12'h000;
	end
endmodule
