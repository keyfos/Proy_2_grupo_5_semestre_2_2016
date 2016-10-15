`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:19:48 09/29/2016 
// Design Name: 
// Module Name:    FFs 
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
module FFs(
    input wire up,
    input wire down,
	 input wire left,
	 input wire right,
	 input wire format,
    input wire ph,
	 input wire pf,
	 input wire pc,
	 input wire ic,
	 input wire clk,
	 input reset,
    output reg au,
    output reg dis,
    output reg l,
	 output reg r,
	 output reg f,
	 output reg prh,
	 output reg prf,
	 output reg prc,
	 output reg icr
    );
reg [8:0]pas1;
reg [8:0]pas2;
reg [8:0]pas3;
reg [8:0]pas4;
reg [8:0]pas5;
reg [8:0]pas6;
reg [9:0]delay;

always @(posedge clk)
if (reset)
	begin
	pas1<=9'b0;
	pas2<=9'b0;
	pas3<=9'b0;
	pas4<=9'b0;
	pas5<=9'b0;
	pas6<=9'b0;
	au<=1'b0;
	dis<=1'b0;
	l<=1'b0;
	r<=1'b0;
	f<=1'b0;
	prh<=1'b0;
	prf<=1'b0;
	prc<=1'b0;
	icr<=1'b0;
	delay<=0;
	end
else if (delay==0)
	begin
	pas1[0]<=up;
	pas1[1]<=down;
	pas1[2]<=left;
	pas1[3]<=right;
	pas1[4]<=format;
	pas1[5]<=ph;
	pas1[6]<=pf;
	pas1[7]<=pc;
	pas1[8]<=ic;
	pas2[0]<=pas1[0];
	pas2[1]<=pas1[1];
	pas2[2]<=pas1[2];
	pas2[3]<=pas1[3];
	pas2[4]<=pas1[4];
	pas2[5]<=pas1[5];
	pas2[6]<=pas1[6];
	pas2[7]<=pas1[7];
	pas2[8]<=pas1[8];
	
	pas3[0]<=pas2[0];
	pas3[1]<=pas2[1];
	pas3[2]<=pas2[2];
	pas3[3]<=pas2[3];
	pas3[4]<=pas2[4];
	pas3[5]<=pas2[5];
	pas3[6]<=pas2[6];
	pas3[7]<=pas2[7];
	pas3[8]<=pas2[8];
	
	pas4[0]<=pas3[0];
	pas4[1]<=pas3[1];
	pas4[2]<=pas3[2];
	pas4[3]<=pas3[3];
	pas4[4]<=pas3[4];
	pas4[5]<=pas3[5];
	pas4[6]<=pas3[6];
	pas4[7]<=pas3[7];
	pas4[8]<=pas3[8];
	
	pas5[0]<=pas4[0];
	pas5[1]<=pas4[1];
	pas5[2]<=pas4[2];
	pas5[3]<=pas4[3];
	pas5[4]<=pas4[4];
	pas5[5]<=pas4[5];
	pas5[6]<=pas4[6];
	pas5[7]<=pas4[7];
	pas5[8]<=pas4[8];
	
	pas6[0]<=pas5[0];
	pas6[1]<=pas5[1];
	pas6[2]<=pas5[2];
	pas6[3]<=pas5[3];
	pas6[4]<=pas5[4];
	pas6[5]<=pas5[5];
	pas6[6]<=pas5[6];
	pas6[7]<=pas5[7];
	pas6[8]<=pas5[8];
	if (pas1[0]==pas2[0]&&pas1[0]==pas3[0]&&pas1[0]==pas4[0]&&pas1[0]==pas5[0]&&pas1[0]==pas6[0])
		au<=pas6[0];
	if (pas1[1]==pas2[1]&&pas1[1]==pas3[1]&&pas1[1]==pas4[1]&&pas1[1]==pas5[1]&&pas1[1]==pas6[1])
		dis<=pas6[1];
	if (pas1[2]==pas2[2]&&pas1[2]==pas3[2]&&pas1[2]==pas4[2]&&pas1[2]==pas5[2]&&pas1[2]==pas6[2])
		l<=pas6[2];
	if (pas1[3]==pas2[3]&&pas1[3]==pas3[3]&&pas1[3]==pas4[3]&&pas1[3]==pas5[3]&&pas1[3]==pas6[3])
		r<=pas6[3];
	if (pas1[4]==pas2[4]&&pas1[4]==pas3[4]&&pas1[4]==pas4[4]&&pas1[4]==pas5[4]&&pas1[4]==pas6[4])
		f<=pas6[4];
	if (pas1[5]==pas2[5]&&pas1[5]==pas3[5]&&pas1[5]==pas4[5]&&pas1[5]==pas5[5]&&pas1[5]==pas6[5])
		prh<=pas6[5];
	if (pas1[6]==pas2[6]&&pas1[6]==pas3[6]&&pas1[6]==pas4[6]&&pas1[6]==pas5[6]&&pas1[6]==pas6[6])
		prf<=pas6[6];
	if (pas1[7]==pas2[7]&&pas1[7]==pas3[7]&&pas1[7]==pas4[7]&&pas1[7]==pas5[7]&&pas1[7]==pas6[7])
		prc<=pas6[7];
	if (pas1[8]==pas2[8]&&pas1[8]==pas3[8]&&pas1[8]==pas4[8]&&pas1[8]==pas5[8]&&pas1[8]==pas6[8])
		icr<=pas6[8];
		delay<=delay+1'b1;
	end
	else if(delay==2000)delay<=0;
	else 	delay<=delay+1'b1;
endmodule
