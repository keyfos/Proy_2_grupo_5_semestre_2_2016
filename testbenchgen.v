`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:19:45 09/28/2016
// Design Name:   Control_VGA
// Module Name:   E:/Proy_3_Digitales_1/testbenchgen.v
// Project Name:  Proy_3_Digitales_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Control_VGA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbenchgen;

	// Inputs
	reg reloj_nexys;
	reg reset_total;
	reg [1:0] direc_prog;
	reg [2:0] prog_crono;
	reg [2:0] prog_fecha;
	reg [2:0] prog_hora;
	reg crono_final;
	reg tiempo;
	reg formato;
	reg [7:0] hora_x;
	reg [7:0] min_x;
	reg [7:0] seg_x;
	reg [7:0] dia_x;
	reg [7:0] mes_x;
	reg [7:0] year_x;
	reg [7:0] hora_crono;
	reg [7:0] min_crono;
	reg [7:0] seg_crono;

	// Outputs
	wire [11:0] color_salida;
	wire hsync;
	wire vsync;
	wire ON_VID;
	wire [9:0] x_p;
	wire [9:0] y_p;

	
	always #5 reloj_nexys=~reloj_nexys;
	integer i;
	integer j;


	initial begin
		// Initialize Inputs
		reloj_nexys = 0;
		reset_total = 0;
		hora_crono = 0;
		min_crono= 0;
		seg_crono= 0;
		hora_x = 0;
		min_x = 0;
		seg_x = 0;
		dia_x= 0;
		mes_x= 0;
		year_x= 0;

		// Wait 100 ns for global reset to finish
		#100
		reset_total=1;
		#10
		reset_total=0;
#10
		    reset_total = 1;
		    j=0;
			 hora_crono = 0;
		min_crono = 1;
		seg_crono = 1;
		hora_x = 1;
		min_x = 1;
		seg_x = 1;
		dia_x= 1;
		mes_x= 1;
		year_x= 1;
		    #50
		reset_total = 0;
		hora_crono= 3;
		min_crono = 2;
		seg_crono= 1;
		hora_x = 7;
		min_x = 7;
		seg_x = 7;
		dia_x= 5;
		mes_x= 5;
		year_x= 5;
		end
      
endmodule

