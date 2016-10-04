`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:02 09/30/2016 
// Design Name: 
// Module Name:    LecturaCrono 
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
module LecturaCrono(
	 input clock,
	 input reset,
	 input chs,
	 output reg [7:0] ADout,
    output reg ad,
    output reg wr,
    output reg rd,
    output reg cs
	 
    );
reg [5:0]cont;
reg [1:0]contadd;
reg [7:0]dir;
reg chsref;

always @(posedge clock)
begin
	if (reset)
	begin
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h1;
	cs<=1'h1;
	ADout<=8'hff;
	cont<=0;
	contadd<=0;
	chsref<=0;	
	dir<=8'h0f;
	end
	
	else if (chs>chsref) chsref<=chs;
	
	else if (chsref==1) 
	begin
	if (cont==0)
	begin
	case (contadd)
		2'b00:dir<=8'h43;
		2'b01:dir<=8'h42;
		2'b10:dir<=8'h41; 
		2'b11:dir<=8'hf2;
		default dir<=8'h43;
	endcase
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
		ADout<=dir;
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
	else if (cont==21)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==22)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==23)
		begin
		case (contadd)
		2'b00:ADout<=8'h00;
		2'b01:ADout<=8'h00;
		2'b10:ADout<=8'h00; 
		2'b11:ADout<=8'hff;
		default ADout<=8'h00;
	endcase
		cont<=cont+1'b1;
		end
	else if (cont==28)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==29)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==31)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (contadd==3&&cont==40)
		begin
		contadd<=0;
		cont<=0;
		chsref<=0;
		end
	else if (cont==40)
		begin
		cont<=0;
		contadd<=contadd+1'b1;
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
