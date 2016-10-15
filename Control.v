`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:38:08 09/20/2016 
// Design Name: 
// Module Name:    Control 
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
module FMSPrincipal(
	 input fin,
    input clock,
    input reset,
	 input Phora,
	 input Pfecha,
	 input Pcrono,
	 input cronoini,
	 input format,
    output reg ENchora,
    output reg ENcfecha,
    output reg ENccrono,
    output reg ENghora,
    output reg ENgfecha,
    output reg ENgcrono,
    output reg ENedatos,
	 output reg ENcinic,
	 output reg ENcompa,
	 output reg lock,
	 output reg [1:0]selmuxdt,
	 output reg [2:0]selmuxctr
	
    );
reg [11:0]contador;
reg crini;
reg form;
reg [3:0]contEdatos;
reg finref;
always @(posedge clock)
	begin
	if (reset)
	begin

		finref<=0;
		ENchora<=0;
		ENcfecha<=0;
		ENccrono<=0;
		ENghora<=0;
		ENgfecha<=0;
		ENgcrono<=0;
		ENedatos<=0;
		ENcompa<=0;
		contador<=0;
		crini<=0;
		form<=0;
		ENcinic<=0;
		lock<=0;
		selmuxdt<=0;
		selmuxctr<=0;
		contEdatos<=0;
	end
	else
	begin
	if (contador==170)
		begin
		ENgcrono<=1;
		selmuxctr<=5;
		contador<=contador+1'b1;
		end
	if (contador==176)
		begin
		ENgcrono<=0;
		contador<=contador+1'b1;
		end
	else if (contador==370) 
		begin
		if (contEdatos==0)
			begin 
			ENedatos<=1;
			selmuxctr<=2;
			if (ENccrono==0)selmuxdt<=0;
			contador<=contador+1'b1;
			end
		else contador<=820;
		contEdatos<=contEdatos+1'b1;
		end
		
		else if(contador==372)
		begin
		ENedatos<=0;
		contador<=contador+1'b1;
		end
	
	else if (contador==820)
		begin
		ENcompa<=1;
		if (cronoini!=crini||finref<fin)
		begin
			ENcinic<=1;
			selmuxctr<=1;
			crini<=cronoini;
			finref<=fin;
			contador<=contador+1'b1;
		end
		else if ((Phora==1||Pfecha==1)&&lock==0)
		begin
		selmuxctr<=1;
		ENcinic<=1;
		lock<=1;
		contador<=contador+1'b1;
		end
		else if (format!=form)
		begin 
			ENcinic<=1;
			selmuxctr<=1;
			form<=format;
			contador<=contador+1'b1;
		end
		else contador<=864;
		end
		
		else if (contador==824)
		begin
		ENcinic<=0;
		contador<=contador+1'b1;
		end
		
		
		else if (contador==863)
			begin
			if (selmuxctr==1)
				begin
				contador<=370;
				contEdatos<=0;
				end
			else contador<=contador+1'b1;
			end
			
		else if (contador==864)
			begin
			if(fin==1&&cronoini==0)
				begin
				contador<=170;
				contEdatos<=0;
				end
			else contador<=1024;
			end
		
		else if(contador==1024)
		begin
			if (Phora==1&&lock==1)
				begin
				ENchora<=1;
				ENccrono<=0;
				selmuxdt<=1;
				contador<=contador+1'b1;
				end
			else if (Pfecha==1&&lock==1)
				begin
				ENcfecha<=1;
				ENccrono<=0;
				selmuxdt<=2;
				contador<=contador+1'b1;
				end
			else if (Pcrono==1)
				begin
				ENccrono<=1;
				selmuxdt<=3;
				contador<=370;
				end
			else contador<=370;
			
		end
			
		else if (contador==1026)
		begin
		if (Phora==0&&selmuxdt==1)
			begin
			ENchora<=0;
			ENghora<=1;
			selmuxctr<=3;
			contador<=contador+1'b1;
			end
		else if(Pfecha==0&&selmuxdt==2)
			begin
			ENcfecha<=0;
			ENgfecha<=1;
			selmuxctr<=4;
			contador<=contador+1'b1;
			end
		
		end
		
		else if (contador==1028)
		begin
			ENghora<=0;
			ENgfecha<=0;
			contador<=contador+1'b1;
		end
		else if (contador==1230)
			begin
			lock<=0;
			contador<=370;
			contEdatos<=0;
			end
		
		else contador<=contador+1'b1;
		if (contEdatos==10)
			contEdatos<=0;
		if(Pcrono==0)
			ENccrono<=0;
		
	end
	
	end

endmodule
