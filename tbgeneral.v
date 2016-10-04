`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:27:14 09/30/2016
// Design Name:   ModuloPrincipal
// Module Name:   C:/Users/Administrator/FPGA/Proy_3_Digitales_11/tbgeneral.v
// Project Name:  Proy_3_Digitales_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ModuloPrincipal
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbgeneral;

	// Inputs
	reg clk_100MHz;
	reg [5:0] Switch;
	reg [3:0] Button;
	reg [7:0] ADin;

	// Outputs
	wire [7:0] ADout;
	wire [11:0] Color;
	wire hsync;
	wire vsync;
	wire R_D;
	wire C_S;
	wire W_R;
	wire A_D;
	wire clknex;

	// Instantiate the Unit Under Test (UUT)
	ModuloPrincipal uut (
		.clk_100MHz(clk_100MHz), 
		.Switch(Switch), 
		.Button(Button), 
		.ADin(ADin), 
		.ADout(ADout), 
		.Color(Color), 
		.hsync(hsync), 
		.vsync(vsync), 
		.R_D(R_D), 
		.C_S(C_S), 
		.W_R(W_R), 
		.A_D(A_D), 
		.clknex(clknex)
	);

	initial begin
		// Initialize Inputs
		clk_100MHz = 0;
		Switch = 0;
		Button = 0;
		ADin = 8'h12;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here


	end
	always 
	begin
		#5 clk_100MHz=!clk_100MHz;
	end
      
	initial
	begin
		Switch[5]=1;
		#30
		Switch[5]=0;
		#2000
		Switch[4]=1;
		#25000
		Button[3]=1;
		#25000
		Button[3]=1;
		#25000
		Switch[4]=0;
		
	end
      
endmodule

