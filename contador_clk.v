`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:44:02 09/13/2016 
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
	 input clk_nexys,
	 input rst, //reset
	 output reg pixel_rate,
	 output reg clk_alarma
    );
	 localparam cont_alarma= 24'd12499999;
	 reg [0:0] cont;
	 reg [23:0] divisor;
	 
	 //El módulo se encarga de realizar un timer para dividir la frecuencia del clk de la Nexys a 25 MHz
	 //Se realiza un contador para controlar la alarma del sistema
	 always @(posedge clk_nexys, posedge rst)
	 begin
		if (reset)
		begin
			pixel_rate=0;
			cont=0;
			divisor=24'd0;
			clk_alarma=0;
		end
	else
	begin
		if(cont==1'd1)
			begin
				cont=1'd0;
				pixel_rate=~pixel_rate;
			end
			else cont=cont+1'd1;
			
			if(divisor==cont_alarma)
			begin
				divisor=24'd0;
				clk_alarma=~clk_alarma;
			end
			else divisor=divisor+24'd1;
			
			
		end
	 end

endmodule



