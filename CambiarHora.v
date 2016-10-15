`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:55:04 09/22/2016 
// Design Name: 
// Module Name:    CambiarHora 
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
module EscrituraHora(
    input clk,
	 input reset,
// Habilitador
	 input EN,
	 
// Botones
    input UP,
    input DOWN,
    input LEFT,
    input RIGHT,
	
// Variables
	 input ampm,
	 input Formato,
	 input [7:0] H,
    input [7:0] M,
    input [7:0] S,

// Variables regionales
    output reg [7:0] HC,
    output reg [7:0] MC,
    output reg [7:0] SC,
	 output reg AmPm,
    output reg [2:0]Contador
    );
	 
reg [2:0]step;
reg F;
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
		Contador<=0;
		step<=0;
		U<=0;
		D<=0;
	   L<=0;
	   R<=0;
		varout<=0;
		varin<=0;
		HC<=0;
		MC<=0;
		SC<=0;
		AmPm<=0;
		F<=0;
		
	end
	else if (EN)
	begin

	if (step==0)
		begin
		HC<=H;
		MC<=M;
		SC<=S;
		AmPm<=ampm;
		F<=Formato;
		step<=step+1'b1;
		end

	else if (step==1)//paso 1
		begin
		if (RIGHT>R)
		begin
			if (Contador==5)
			Contador<=0;
			else Contador<=Contador+1'b1;
			R<=RIGHT;
		end
		else if (RIGHT<R)
			R<=RIGHT;
		
		if (LEFT>L)
		begin
			if (Contador==0)
			Contador<=5;
			else Contador<=Contador-1'b1;
			L<=LEFT;
		end
		
	step<=step+1'b1;
	end
		
// Cambio de Formato		
	else if (step==2)
	begin
		if (F!=Formato)
		begin
			if (Formato==0)
			begin
				if (AmPm==1)
				begin
				case (HC)
				8'h01:HC<=8'h13;
				8'h02:HC<=8'h14;
				8'h03:HC<=8'h15;
				8'h04:HC<=8'h16;
				8'h05:HC<=8'h17;
				8'h06:HC<=8'h18;
				8'h07:HC<=8'h19;
				8'h08:HC<=8'h20;
				8'h09:HC<=8'h21;
				8'h10:HC<=8'h22;
				8'h11:HC<=8'h23;
				default HC<=HC;
				endcase 
				AmPm<=0;
				end
				
				else if (AmPm==0&&HC==8'h12)
				HC<=8'h00;
				end
				
			if (Formato==1)
			begin
				case (HC)
				8'h00:begin
						HC<=8'h12;
						AmPm<=0;
						end
				8'h12:AmPm<=1;
				8'h13:begin
						HC<=8'h01;
						AmPm<=1;
						end
				8'h14:begin
						HC<=8'h02;
						AmPm<=1;
						end
				8'h15:begin
						HC<=8'h03;
						AmPm<=1;
						end
				8'h16:begin
						HC<=8'h04;
						AmPm<=1;
						end
				8'h17:begin
						HC<=8'h05;
						AmPm<=1;
						end
				8'h18:begin
						HC<=8'h06;
						AmPm<=1;
						end
				8'h19:begin
						HC<=8'h07;
						AmPm<=1;
						end
				8'h20:begin
						HC<=8'h08;
						AmPm<=1;
						end
				8'h21:begin
						HC<=8'h09;
						AmPm<=1;
						end
				8'h22:begin
						HC<=8'h10;
						AmPm<=1;
						end
				8'h23:begin
						HC<=8'h11;
						AmPm<=1;
						end
				default HC<=HC;
				endcase 
				end
				F<=Formato;
			end
			step<=step+1'b1;
			end
				
		else if (step==3)
		begin
			case (Contador)
			3'b000: varin<=HC[7:4];
			3'b001: varin<=HC[3:0];
			3'b010: varin<=MC[7:4];
			3'b011: varin<=MC[3:0];
			3'b100: varin<=SC[7:4];
			3'b101: varin<=SC[3:0];
			default varin<=HC[7:4];
			endcase
			
			step<=step+1'b1;
			end
		
		else if (step==4)
		begin
		
		if (DOWN==D && UP==U)
		varout<=varin;
		
		if (UP>U)
		begin
			if (Contador==1&&HC[7:4]==1&&F==1&&varin==2)
			varout<=0;
			else if (Contador==1&&HC[7:4]==2&&F==0&&varin==3)
			varout<=0;
			else if ((Contador==1||Contador==3||Contador==5)&&varin==9)
			varout<=0;
			else if (Contador==0 && F==1 && varin==1)
				begin
				varout<=0;
				AmPm<=~AmPm;
				end
			else if (varin==2 && Contador==0)
			varout<=0;
			else if ((Contador==2||Contador==4)&&varin==5)
			varout<=0;
			else if (Contador==0 && F==1 && varin==0)
				begin
				varout<=1;
				HC[3:0]<=0;
				end
			else if (Contador==0 && F==0 && varin==1)
				begin
				varout<=2;
				HC[3:0]<=0;
				end
			
			else varout<=varin+1'b1;
			U<=UP;
		end
		
		if (DOWN>D)
		begin
			if (varin==0)
				begin
				if(Contador==0 && F==1)
					begin
					varout<=1;
					HC[3:0]<=0;
					AmPm<=~AmPm;
					end
				else if (Contador==0&&F==0)
					begin
					varout<=2;
					HC[3:0]<=0;
					end
				else if (Contador==1&&HC[7:4]==2&&F==0)varout<=3;
				else if (Contador==1&&HC[7:4]==1&&F==1)varout<=2;
				else if (Contador==1||Contador==3||Contador==5)	varout<=9;
				else if (Contador==2||Contador==4)varout<=5;
				end
			else varout<=varin-1'b1;
			D<=DOWN;
		end
		
		step<=step+1'b1;
		end
		
		else if (step==5)
		begin
		case (Contador)
			3'b000: HC[7:4]<=varout;
			3'b001: HC[3:0]<=varout;
			3'b010: MC[7:4]<=varout;
			3'b011: MC[3:0]<=varout;
			3'b100: SC[7:4]<=varout;
			3'b101: SC[3:0]<=varout;
			default HC[7:4]<=varout;
		endcase
		step<=1;
		end
		
		if (UP<U)
			U<=UP;
		if (DOWN<D)
			D<=DOWN;
		if (LEFT<L)
			L<=LEFT;
		if (RIGHT<R)
			R<=RIGHT;
		
	end
	else 
	begin
	step<=0;
	Contador<=0;
	end
	

end
endmodule
