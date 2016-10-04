`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:20:15 09/30/2016
// Design Name:   ControlRTC
// Module Name:   C:/Users/Administrator/FPGA/Proy_3_Digitales_11/tbpvss.v
// Project Name:  Proy_3_Digitales_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlRTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbpvss;

	// Inputs
	reg rst;
	reg clk;
	reg Switch1;
	reg Switch2;
	reg Switch3;
	reg Switch4;
	reg Switch5;
	reg Up;
	reg Down;
	reg Left;
	reg Right;
	reg [7:0] ADin;

	// Outputs
	wire [7:0] ADout;
	wire AD;
	wire WR;
	wire CS;
	wire RD;
	wire AMPM;
	wire [7:0] hora;
	wire [7:0] min;
	wire [7:0] seg;
	wire [7:0] d;
	wire [7:0] me;
	wire [7:0] y;
	wire [7:0] horacr;
	wire [7:0] mincr;
	wire [7:0] segcr;
	wire [7:0] horapr;
	wire [7:0] minpr;
	wire [7:0] segpr;
	wire [2:0] cursgcrono;
	wire [2:0] cursghora;
	wire [2:0] cursgfecha;
	wire [1:0] Smuxdt;
	wire Pullup;
	wire tim;
	wire formato;

	// Instantiate the Unit Under Test (UUT)
	ControlRTC uut (
		.rst(rst), 
		.clk(clk), 
		.Switch1(Switch1), 
		.Switch2(Switch2), 
		.Switch3(Switch3), 
		.Switch4(Switch4), 
		.Switch5(Switch5), 
		.Up(Up), 
		.Down(Down), 
		.Left(Left), 
		.Right(Right), 
		.ADin(ADin), 
		.ADout(ADout), 
		.AD(AD), 
		.WR(WR), 
		.CS(CS), 
		.RD(RD), 
		.AMPM(AMPM), 
		.hora(hora), 
		.min(min), 
		.seg(seg), 
		.d(d), 
		.me(me), 
		.y(y), 
		.horacr(horacr), 
		.mincr(mincr), 
		.segcr(segcr), 
		.horapr(horapr), 
		.minpr(minpr), 
		.segpr(segpr), 
		.cursgcrono(cursgcrono), 
		.cursghora(cursghora), 
		.cursgfecha(cursgfecha), 
		.Smuxdt(Smuxdt), 
		.Pullup(Pullup), 
		.tim(tim), 
		.formato(formato)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;
		Switch1 = 0;
		Switch2 = 0;
		Switch3 = 0;
		Switch4 = 0;
		Switch5 = 0;
		Up = 0;
		Down = 0;
		Left = 0;
		Right = 0;
		ADin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

