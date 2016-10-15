`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:31:49 09/30/2016 
// Design Name: 
// Module Name:    EscrituraCrono 
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
module EscrituraCrono(
	 input EN,
    input UP,
    input DOWN,
    input LEFT,
    input RIGHT,
	 input clk,
	 input reset,
    output reg [7:0] HCcr,
    output reg [7:0] MCcr,
    output reg [7:0] SCcr,
	 output reg [2:0]contador
    );
	 
	 reg [2:0]cont2;
	 reg U;
	 reg D;
	 reg L;
	 reg R;
	 reg [3:0] varin;
	 reg [3:0] varout;
	 
always @(posedge clk)
begin
	if (reset)
	begin
		contador<=0;
		cont2<=0;
		U<=0;
		D<=0;
	   L<=0;
		R<=0;
		
		HCcr<=0;
		MCcr<=0;
		SCcr<=8'h01;
		
		
	end
	else if (EN)
	begin
	if (cont2==0)
	begin
		cont2<=cont2+1'b1;
	end
	else if (cont2==1)//paso 1
		begin
		if (RIGHT>R)
		begin
			if (contador==5)
			contador<=0;
			else contador<=contador+1'b1;
			R<=RIGHT;
		end
		else if (RIGHT<R)
			R<=RIGHT;
		
		if (LEFT>L)
		begin
			if (contador==0)
			contador<=5;
			else contador<=contador-1'b1;
			L<=LEFT;
		end
		
		cont2<=cont2+1'b1;
		end
		
// Determina el cambio en las decenas y unidades de hora, minuto y segundo del cronómetro	
		else if (cont2==2)
			begin
			case (contador)
			3'b000: varin<=HCcr[7:4];
			3'b001: varin<=HCcr[3:0];
			3'b010: varin<=MCcr[7:4];
			3'b011: varin<=MCcr[3:0];
			3'b100: varin<=SCcr[7:4];
			3'b101: varin<=SCcr[3:0];
			default varin<=HCcr[7:4];
			endcase
			
			cont2<=cont2+1'b1;
			end
		
		else if (cont2==3)
		begin
		if (DOWN==D && UP==U)
		varout<=varin;

		if (UP>U)
		begin
		//
			if (varin==5&&(contador==2||contador==4))
				varout<=0;
			else if (varin==9&&(contador==3||contador==5))
				varout<=0;
			else if (contador==0&&varin==1)
				begin
				varout<=2;
				HCcr[3:0]<=0;
				end
			else if (varin==2 && contador==0)varout<=0;
			else if (varin==4 && contador==1 && HCcr==2)varout<=0;
			else if (varin==9 && contador==1)varout<=0;
			else varout<=varin+1'b1;
			U<=UP;
		end
		
		
		if (DOWN>D)
		begin
			if (varin==0)
			begin
				if (contador==0)
					begin
					varout<=2;
					HCcr<=0;
					end
				else if (contador==1&&HCcr[7:4]==2)varout<=4;
				else if (contador==1)varout<=9;
				else if (contador==2||contador==4)varout<=5;
				else if (contador==3||contador==5)varout<=9;
			end
			else varout<=varin-1'b1;
			D<=DOWN;
		end
		
		cont2<=cont2+1'b1;
		end
		
		else if (cont2==4)
		begin
		case (contador)
			3'b000: HCcr[7:4]<=varout;
			3'b001: HCcr[3:0]<=varout;
			3'b010: MCcr[7:4]<=varout;
			3'b011: MCcr[3:0]<=varout;
			3'b100: SCcr[7:4]<=varout;
			3'b101: SCcr[3:0]<=varout;
			default HCcr[7:4]<=varout;
		endcase
		cont2<=1;
		end
		if (LEFT<L)
			L<=LEFT;
		if (RIGHT<R)
			R<=RIGHT;
		if (UP<U)
			U<=UP;
		if (DOWN<D)
			D<=DOWN;
	end
	else 
	begin
	cont2<=0;
	contador<=0;
	end
end
endmodule
