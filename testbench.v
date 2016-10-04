`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:11:51 09/18/2016
// Design Name:   Control_VGA
// Module Name:   C:/Users/User/Documents/ISE/Proy_3_Digitales_1/testbench.v
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

module testbench;
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
	wire video_on;

	// Instantiate the Unit Under Test (UUT)
	Control_VGA uut (
		.reloj_nexys(reloj_nexys), 
		.reset_total(reset_total), 
		.direc_prog(direc_prog), 
		.prog_crono(prog_crono), 
		.prog_fecha(prog_fecha), 
		.prog_hora(prog_hora), 
		.finale(finale), 
		.tempo(tempo), 
		.formatto(formatto), 
		.handshake(handshake), 
		.color_salida(color_salida), 
		.hsincro(hsincro), 
		.vsincro(vsincro)
	);

always #5 clk=~clk;
	integer i;
	integer j;

	initial begin
		// Initialize Inputs
		clk = 0;
		clk_alarma = 0;
		dir_prog = 0;
		p_crono = 0;
		p_fecha = 0;
		p_hora = 0;
		crono_end = 0;
		am_pm = 0;
		formato = 0;
		hora = 0;
		min = 0;
		seg = 0;
		dia = 0;
		mes = 0;
		year = 0;
		hcrono = 0;
		mcrono = 0;
		scrono = 0;
		pixel_x = 0;
		pixel_y = 0;


always #5 clk=~clk;
	integer i;
	integer j;

	initial begin
		// Initialize Inputs
		clk = 0;
		clk_alarma = 0;
		dir_prog = 0;
		p_crono = 0;
		p_fecha = 0;
		p_hora = 0;
		crono_end = 0;
		am_pm = 0;
		formato = 0;
		hora = 0;
		min = 0;
		seg = 0;
		dia = 0;
		mes = 0;
		year = 0;
		hcrono = 0;
		mcrono = 0;
		scrono = 0;
		pixel_x = 0;
		pixel_y = 0;




		rst=1;
		#10
		rst=0;
#10
		    rst = 1;
		    j=0;
			 hcrono = 0;
		mcrono = 1;
		scrono = 1;
		hora = 1;
		min = 1;
		seg = 1;
		dia = 1;
		mes = 1;
		year = 1;
		    #50
			 
		rst = 0;
		hcrono = 3;
		mcrono = 2;
		scrono = 1;
		hora = 7;
		min = 7;
		seg = 7;
		dia = 5;
		mes = 5;
		year = 5;
		

		    //archivo txt para observar los bits, simulando una pantalla

		    i = $fopen("pruebapantalla.txt","w");
		    for(j=0;j<383520;j=j+1) begin
		      #40
		      if(pixel_x) begin
		        $fwrite(i,"%h",color);
		      end
		      else if(pixel_x==641)
		        $fwrite(i,"\n");
		    end


		    #16800000


		    rst=0;
		    $fclose(i);
		    $stop;
		end



		rst=1;
		#10
		rst=0;
#10
		    rst = 1;
		    j=0;
			 hcrono = 0;
		mcrono = 1;
		scrono = 1;
		hora = 1;
		min = 1;
		seg = 1;
		dia = 1;
		mes = 1;
		year = 1;
		    #50
			 
		rst = 0;
		hcrono = 3;
		mcrono = 2;
		scrono = 1;
		hora = 7;
		min = 7;
		seg = 7;
		dia = 5;
		mes = 5;
		year = 5;
		

		    //archivo txt para observar los bits, simulando una pantalla

		    i = $fopen("pruebapantalla.txt","w");
		    for(j=0;j<383520;j=j+1) begin
		      #40
		      if(pixel_x) begin
		        $fwrite(i,"%h",color);
		      end
		      else if(pixel_x==641)
		        $fwrite(i,"\n");
		    end


		    #16800000


		    rst=0;
		    $fclose(i);
		    $stop;
		end


endmodule

