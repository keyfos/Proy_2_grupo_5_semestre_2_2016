`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:20:56 09/28/2016
// Design Name:   alarma
// Module Name:   F:/Proy_3_Digitales_11/alarma_Tb.v
// Project Name:  Proy_3_Digitales_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alarma
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alarma_Tb;

	// Inputs
	reg CLK_Ring;
	reg reset;
	reg fin_crono;

	// Outputs
	wire band_parp;

	// Instantiate the Unit Under Test (UUT)
	alarma uut (
		.CLK_Ring(CLK_Ring), 
		.reset(reset), 
		.fin_crono(fin_crono), 
		.band_parp(band_parp)
	);

		initial begin
		// Initialize Inputs
		
		fin_crono = 0;

	end
	localparam T=0.02;
	always
begin
	CLK_Ring<=1'b1;
	#(T/2);
	CLK_Ring<=1'b0;
	#(T/2);
end


initial
begin
	reset<=1'b1; 
	@(negedge CLK_Ring); 
	#(T);
	reset<=1'b0; 
end

initial
begin
	@(negedge reset);
	@(posedge CLK_Ring); 
	repeat(840000) @(posedge CLK_Ring);
	$stop;
end 
      
endmodule

