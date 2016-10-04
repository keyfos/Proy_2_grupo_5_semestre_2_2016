`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:24:25 09/28/2016
// Design Name:   mux_colores
// Module Name:   F:/Proy_3_Digitales_11/muxtb.v
// Project Name:  Proy_3_Digitales_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_colores
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module muxtb;

	// Inputs
	reg video_on;
	reg [11:0] color;

	// Outputs
	wire [11:0] RGB;

	// Instantiate the Unit Under Test (UUT)
	mux_colores uut (
		.video_on(video_on), 
		.color(color), 
		.RGB(RGB)
	);
initial begin
		// Initialize Inputs
		video_on = 0;
		color = 0;

		// Wait 100 ns for global reset to finish
		#100;
		video_on =1;
		color = 12'hccc;
        
		// Add stimulus here

	end
      
endmodule

