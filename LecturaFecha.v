`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:59:53 09/29/2016 
// Design Name: 
// Module Name:    LecturaFecha 
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
module LecturaFecha(
	 input swcr,
	 input form,
    input [7:0] dia,
	 input [7:0] mes,
	 input [7:0] year,
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
reg [2:0]contadd;
reg [7:0]dir;
reg chsref;

always @(posedge clock)
begin
	if (reset)
	begin
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h0;
	cs<=1'h1;
	ADout<=8'hff;
	cont<=0;
	contadd<=0;
	chsref<=0;
	dir<=8'hff;
	
	end
	
	else if (chs>chsref) chsref<=chs;
	
	else if (chsref) 
	begin
	if (cont==0)
	begin
	case (contadd)
		3'b000:dir<=8'h24;
		3'b001:dir<=8'h25;
		3'b010:dir<=8'h26;
		3'b011:dir<=8'h00;
		3'b100:dir<=8'hf1;
		default dir<=8'h24;
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
		3'b000:ADout<=dia;
		3'b001:ADout<=mes;
		3'b010:ADout<=year;
		3'b011:begin
					ADout[7:5]<=0;
					ADout[4]<=form;
					ADout[3]<=swcr;
					ADout[2:0]<=0;
				end
		3'b100:ADout<=8'hff;
		default ADout<=dia;
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
	else if (cont==40&&contadd==4)
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