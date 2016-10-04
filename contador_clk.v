`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:49 09/18/2016 
// Design Name: 
// Module Name:    contador_clk 
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
module contador_clk(
    input CLK_NX,
	 input reset,
	 output reg pixel_rate,
	 output reg clk_RING
	 );
	 
//Se realiza un contador para dividir la frecuencia del clk de la Nexys de 100 MHz a 25 MHz

	reg [0:0] cont;
	reg [23:0] divisor;
	 always @(posedge CLK_NX, posedge reset)
	 begin
		if (reset)
		begin
			pixel_rate=0;
			cont=0;
			divisor=24'h0000;
			clk_RING=0;
			
			
		end
		
		else
		begin
			if(cont==1'd1)
			begin
				cont=1'd0;
				pixel_rate=~pixel_rate;
			end
			else cont=cont+1'd1;
			//Se realiza un reloj de alarma para el cronometro
			if(divisor==24'd12499999)
			begin
				divisor=24'd0;
				clk_RING=~clk_RING;
			end
			else divisor=divisor+24'd1;
			
			
		end
	 end
endmodule
