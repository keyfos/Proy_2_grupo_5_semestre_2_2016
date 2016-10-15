`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:43 09/29/2016 
// Design Name: 
// Module Name:    ModuloPrincipal 
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
module ModuloPrincipal(
	 // Reloj de la Nexys
    input clk_100MHz,
	 // Switches de interacción con el usuario (El bit más significativo se utiliza como reset de todos los módulos) 
	 input [5:0] Switch,
	 // Botones de interacción con el usuario
	 input [3:0] Button,
	 // Entrada de datos
	 input [7:0] ADin,
	 // Salida de datos
	 output [7:0] ADout,
	 // Salida de pigmentación
	 output [11:0] Color,
	 // Salidas de Sincronización de la VGA
	 output hsync, vsync, 
	 // Salidas de selección hacia el RTC 
	 output R_D, C_S, W_R, A_D, 
	 // LED's
	 //output [5:0] LED,
	 // Clock
	 output clknex
	 );
	 
	 
	 wire [7:0] hora_x, min_x, seg_x, day, month, year;
	 wire [7:0] pr_hora, pr_minuto, pr_segundo, Hcr, Mcr, Scr;
	 wire final_cronom, am_pm_bandera, formato_hora;
	 
	 wire [1:0] lugar_program;
	 wire [2:0] cursor_crono, cursor_fecha, cursor_hora;
	 wire PUP;
	 wire [7:0]ADOUT;
	 wire r_lent;
	 
	Control_VGA Control_VG (
		.reloj_nexys(clk_100MHz), 
		.reset_total(Switch[5]), 
		.direc_prog(lugar_program), 
		.prog_crono(cursor_crono), 
		.prog_fecha(cursor_fecha), 
		.prog_hora(cursor_hora), 
		.crono_final(final_cronom), 
		.tiempo(am_pm_bandera), 
		.formato(formato_hora), 
		.hora_x(hora_x),
		.min_x(min_x), 
		.seg_x(seg_x), 
		.dia_x(day), 
		.mes_x(month), 
		.year_x(year),
		.hora_crono(pr_hora),
		.min_crono(pr_minuto),
		.seg_crono(pr_segundo),			
//		.hora_crono(Hcr), 
//		.min_crono(Mcr), 
//		.seg_crono(Scr),
		.h_run(Hcr), 
		.m_run(Mcr), 
		.s_run(Scr),
		.color_salida(Color),		
		.hsync(hsync), 
		.vsync(vsync)
	);
	 
	 

	 
	 ControlRTC ControlRT(
		.rst(Switch[5]), 
		.clk(clk_100MHz), 
		.Switch1(Switch[4]), 
		.Switch2(Switch[3]), 
		.Switch3(Switch[2]), 
		.Switch4(Switch[1]), 
		.Switch5(Switch[0]), 
		.Up(Button[3]), 
		.Down(Button[2]), 
		.Left(Button[1]), 
		.Right(Button[0]), 
		.ADin(ADin), 
		.ADout(ADOUT), 
		.AD(A_D), 
		.WR(W_R), 
		.CS(C_S), 
		.RD(R_D), 
		.AMPM(am_pm_bandera), 
		.hora(hora_x), 
		.min(min_x), 
		.seg(seg_x), 
		.d(day), 
		.me(month), 
		.y(year), 
		.horacr(Hcr), 
		.mincr(Mcr), 
		.segcr(Scr), 
		.horapr(pr_hora), 
		.minpr(pr_minuto), 
		.segpr(pr_segundo), 
		.cursgcrono(cursor_crono), 
		.cursghora(cursor_hora), 
		.cursgfecha(cursor_fecha), 
		.Smuxdt(lugar_program), 
		.Pullup(PUP), 
		.tim(final_cronom), 
		.formato(formato_hora)
	 
	 );
	 
	 

assign ADout = (~PUP) ? ADOUT : 8'hzz;
//assign LED=Int_LED;
assign clknex=clk_100MHz;
endmodule
