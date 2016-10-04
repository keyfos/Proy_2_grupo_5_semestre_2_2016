`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:46:24 09/29/2016
// Design Name:   contador_clk
// Module Name:   E:/Proy_3_Digitales_11/contadortb.v
// Project Name:  Proy_3_Digitales_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: contador_clk
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module contadortb;

	// Inputs
	reg CLK_NX;
	reg reset;

	// Outputs
	wire pixel_rate;
	wire clk_RING;

	// Instantiate the Unit Under Test (UUT)
	contador_clk uut (
		.CLK_NX(CLK_NX), 
		.reset(reset), 
		.pixel_rate(pixel_rate), 
		.clk_RING(clk_RING)
	);

	localparam T=20;
	always
begin
	CLK_NX<=1'b1;
	#(T/2);
	CLK_NX<=1'b0;
	#(T/2);
end


initial
begin
	reset<=1'b1; 
	@(negedge CLK_NX); 
	#(T);
	reset<=1'b0; 
end

initial
begin
	@(negedge reset);
	@(posedge CLK_NX); 
	repeat(16800000) @(posedge CLK_NX);
	$stop;

      
	end
      
      
endmodule

