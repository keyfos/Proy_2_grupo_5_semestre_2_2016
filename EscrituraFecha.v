`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:59:36 09/29/2016 
// Design Name: 
// Module Name:    EscrituraFecha 
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
module EscrituraFecha(
    input [7:0] dia,
    input [7:0] mes,
    input [7:0] year,
	 input EN,
    input BTup,
    input BTdown,
    input BTl,
    input BTr,
	 input clk,
	 input reset,
    output reg [7:0] diaC,
    output reg [7:0] mesC,
    output reg [7:0] yearC,
	 output reg [2:0]contador
    );
	 
	 reg [2:0]step;
	 reg BTupref;
	 reg BTdownref;
	 reg BTlref;
	 reg BTrref;
	 reg [3:0] varin;
	 reg [3:0] varout;
	 
always @(posedge clk)
begin
	if (reset)
	begin
		contador<=0;
		step<=0;
		BTupref<=0;
		BTdownref<=0;
	   BTlref<=0;
	   BTrref<=0;
		diaC<=0;
		mesC<=0;
		yearC<=0;
		varout<=0;
		varin<=0;
		
		
	end
	else if (EN)
	begin
		
	if (step==0)
	begin
		diaC<=dia;
		mesC<=mes;
		yearC<=year;
		step<=step+1'b1;
	end
		
	else if (step==1)
		begin
		if (BTr>BTrref)
		begin
			if (contador==5)
			contador<=0;
			else contador<=contador+1'b1;
			BTrref<=BTr;
			
		end
		
		
		if (BTl>BTlref)
		begin
			if (contador==0)
			contador<=5;
			else contador<=contador-1'b1;
			BTlref<=BTl;
			
		end
		
		step<=step+1'b1;
		end
		
		else if (step==2)
			begin
			case (contador)
			3'b000: varin<=diaC[7:4];
			3'b001: varin<=diaC[3:0];
			3'b010: varin<=mesC[7:4];
			3'b011: varin<=mesC[3:0];
			3'b100: varin<=yearC[7:4];
			3'b101: varin<=yearC[3:0];
			default varin<=diaC[7:4];
			endcase
			step<=step+1'b1;
			end
		else if (step==3)
		begin
		if (BTdown==BTdownref && BTup==BTupref)
		varout<=varin;
		
		if (BTup>BTupref)
		begin
			if (varin==3 && contador==0)varout<=0;
			else if (varin==1&&contador==1&&diaC[7:4]==3)varout<=0;
			else if(varin==1 && contador==2)varout<=0;
			else if (varin==2 &&contador==3&&mesC[7:4]==1)varout<=0;
			else if (varin==9)
				begin
				if (contador==1&&diaC[7:4]==0)varout<=1;
				else if (contador==3&&mesC[7:4]==0)varout<=1;
				else if (contador==5&&yearC[7:4]==0)varout<=1;
				else varout<=0;
				end
			else if (varin==2 && mesC==2 && contador==0) varout<=0;
			else if ((mesC==4 || mesC==6 || mesC==9 || mesC==11)&&varin==0&&contador==1&&diaC[7:4]==3)varout<=0;
			else if (varin==2&&contador==0)
				begin
				varout<=3;
				diaC[3:0]<=0;
				end
			else if(varin==0 && contador==2)
				begin
				varout<=1;
				mesC[3:0]<=0;
				end
			else varout<=varin+1'b1;
			BTupref<=BTup;
		end
		
		
		if (BTdown>BTdownref)
		begin
			if (varin==0)
			begin
			if (contador==1&&diaC[7:4]==3&&(mesC==4 || mesC==6 || mesC==9 || mesC==11))varout<=0;
			else if (contador==1&&diaC[7:4]==3)varout<=1;
			else if(contador==0&&mesC==2)varout<=2;
			else if (contador==2)
				begin
				varout<=1;
				mesC<=0;
				end
			else if (contador==3&&mesC[7:4]==1)varout<=2;
			else if (contador==0)
				begin
				varout<=3;
				diaC[3:0]<=0;
				end
			else varout<=9;
			end
			else if (varin==1)
				begin
				if (contador==1&&diaC[7:4]==0)varout<=9;
				else if (contador==3&&mesC[7:4]==0)varout<=9;
				else if (contador==5&&yearC[7:4]==0)varout<=9;
				else if (contador==1&&diaC[7:4]!=0)varout<=0;
				else varout<=0;
				end
			else varout<=varin-1'b1;
			BTdownref<=BTdown;
			
		end
		step<=step+1'b1;
		end
		
		else if (step==4)
		begin
		case (contador)
			3'b000: diaC[7:4]<=varout;
			3'b001: diaC[3:0]<=varout;
			3'b010: mesC[7:4]<=varout;
			3'b011: mesC[3:0]<=varout;
			3'b100: yearC[7:4]<=varout;
			3'b101: yearC[3:0]<=varout;
			default diaC[7:4]<=varout;
		endcase
		step<=1;
		end
		
		if (BTup<BTupref)
			BTupref<=BTup;
		if (BTdown<BTdownref)
			BTdownref<=BTdown;
		if (BTr<BTrref)
			BTrref<=BTr;
		if (BTl<BTlref)
			BTlref<=BTl;
		
		
	end
	else 
	begin
	step<=0;
	contador<=0;
	end
end
endmodule

