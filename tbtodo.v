`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:45:13 09/28/2016
// Design Name:   Control_VGA
// Module Name:   F:/Proy_3_Digitales_11/tbtodo.v
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

module tbtodo;

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

	// Outputs
	wire [11:0] color_salida;
	wire hsync;
	wire vsync;

	// Instantiate the Unit Under Test (UUT)
	Control_VGA uut (
		.reloj_nexys(reloj_nexys), 
		.reset_total(reset_total), 
		.direc_prog(direc_prog), 
		.prog_crono(prog_crono), 
		.prog_fecha(prog_fecha), 
		.prog_hora(prog_hora), 
		.crono_final(crono_final), 
		.tiempo(tiempo), 
		.formato(formato), 
		.color_salida(color_salida), 
		.hsync(hsync), 
		.vsync(vsync)
	);

	initial begin
		// Initialize Inputs
		
	
		prog_crono = 0;
		prog_fecha = 0;
		prog_hora = 0;
		crono_final = 0;
		tiempo = 0;
		formato = 0;

		// Wait 100 ns for global reset to finish
		#100;
	
		prog_crono = 0;
		prog_fecha = 3'b001;
		prog_hora = 0;
		crono_final = 0;
		tiempo = 0;
		formato = 0;
        
		// Add stimulus here

	end
     localparam T=2;
	always
begin
	reloj_nexys<=1'b1;
	#(T/2);
	reloj_nexys<=1'b0;
	#(T/2);
end


initial
begin
	reset_total<=1'b1; 
	@(negedge reloj_nexys); 
	#(T);
	reset_total<=1'b0; 
end

initial
begin
	@(negedge reset_total);
	@(posedge reloj_nexys); 
	repeat(840000) @(posedge reloj_nexys);
	$stop;
end  
endmodule

