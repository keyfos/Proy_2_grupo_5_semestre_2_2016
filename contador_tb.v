`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:39:21 09/27/2016
// Design Name:   contador_clk
// Module Name:   E:/Proy_3_Digitales_1/contador_tb.v
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

module contador_tb;

	// Inputs
	reg CLK_NX;
	reg reset;

	// Outputs
	wire pixel_rate;
	wire clk_RING;

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

