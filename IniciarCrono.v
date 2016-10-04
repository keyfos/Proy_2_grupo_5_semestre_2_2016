`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:28:01 09/30/2016 
// Design Name: 
// Module Name:    IniciarCrono 
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
module IniciarCrono(
	 input clock,
    input reset,
	 input enc,
	 input inic,
	 input format,
	 input lock,
	 input fin,
    output reg ad,
    output reg wr,
    output reg cs,
    output reg rd,
    output reg [7:0] ADout
    );
reg [5:0]cont;
reg encr;
always @(posedge clock)
begin
	if (reset)
	begin
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h1;
	cs<=1'h1;
	encr<=0;
	ADout<=8'hff;
	cont<=0;
	end
	else if (enc>encr)encr<=enc;
	else if (encr==1)
	begin
	if (cont==0)
	begin
	ad<=1;
	wr<=1;
	rd<=1;
	cs<=1;
	cont<=cont+1'b1;
	end
		
	else if (cont==1)
	begin
		
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==2)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==3)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==4)
		begin
		ADout<=8'h00;
		cont<=cont+1'b1;
		end
	else if (cont==9)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==10)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==11)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==13)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==22)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==23)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==24)
		begin
		ADout[0]<=0;
		ADout[1]<=0;
		ADout[2]<=0;
		if (fin==1)ADout[3]<=0;
		else ADout[3]<=inic;
		ADout[4]<=format;
		ADout[5]<=lock;
		ADout[6]<=0;
		ADout[7]<=0;
		cont<=cont+1'b1;
		end
	else if (cont==29)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==30)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==32)
		begin
		cont<=0;
		encr<=0;
		ADout<=8'hff;
		ad<=1'h1;
		wr<=1'h1;
		rd<=1'h1;
		cs<=1'h1;
		end
	else cont<=cont+1'b1;
	
	end
	
	
	else
	begin
	ADout<=8'hff;
	cs<=1'h1;
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h1;
	end
	
end


endmodule
