`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:30:11 09/27/2016
// Design Name:   sincronizacion
// Module Name:   E:/Proy_3_Digitales_1/sincro_tb.v
// Project Name:  Proy_3_Digitales_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sincronizacion
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sincro_tb;

	// Inputs
	reg reset;
	reg CLK_pix_rate;

	// Outputs
	wire h_sync;
	wire v_sync;
	wire video_on;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;

	// Instantiate the Unit Under Test (UUT)
	sincronizacion uut (
		.reset(reset), 
		.CLK_pix_rate(CLK_pix_rate), 
		.h_sync(h_sync), 
		.v_sync(v_sync), 
		.video_on(video_on), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y)
	);
localparam T=20;
	always
begin
	CLK_pix_rate<=1'b1;
	#(T/2);
	CLK_pix_rate<=1'b0;
	#(T/2);
end


initial
begin
	reset<=1'b1; 
	@(negedge CLK_pix_rate); 
	#(T);
	reset<=1'b0; 
end

initial
begin
	@(negedge reset);
	@(posedge CLK_pix_rate); 
	repeat(840000) @(posedge CLK_pix_rate);
	$stop;



      
	end
      
      
endmodule

