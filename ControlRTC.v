`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:22:32 09/20/2016 
// Design Name: 
// Module Name:    ControlRTC 
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
module ControlRTC( 
	 input rst,clk,
    input Switch1,Switch2,Switch3,Switch4,Switch5,
	 input Up,Down,Left,Right,
	 input [7:0]ADin,
	 output [7:0]ADout,
	 output AD,WR,CS,RD,AMPM, 
    output [7:0]hora,min,seg,d,me,y,horacr,mincr,segcr,horapr,minpr,segpr,
	 output [2:0]cursgcrono,cursghora,cursgfecha,
	 output [1:0]Smuxdt,
	 output Pullup,tim,
	 output formato
    );
wire ENch,ENcf,ENcc,ENgh,ENgf,ENgc,ENed,ENci,ENcomp,lck;
wire ap1,ap2;
wire arriba,abajo,izq,der,fmt,ph,pf,pc,ic;
wire [11:0]M1,M2,M3,M4,M5,M6;
wire [23:0]dt11,dt12,dt21,dt22;
wire final;
wire [2:0]Smuxctr;

//Inicializacion Inicializacio(
//		.clock(clk),
//		.reset(rst),
//		.cs(M1[9]),
//		.ad(M1[11]),
//		.rd(M1[10]),
//		.wr(M1[8]),
//		.ADout(M1[7:0])
//);
//
Inicio Inici(
		.clki(clk),
		.rst(rst),
		.CS(M1[9]),
		.AD(M1[11]),
		.RD(M1[10]),
		.WR(M1[8]),
		.ADout(M1[7:0])
);
//
FFs FF(
		.up(Up),
		.down(Down),
		.left(Left),
		.right(Right),
		.ph(Switch1),
		.pf(Switch2),
		.pc(Switch3),
		.ic(Switch4),
		.format(Switch5),
		.clk(clk),
		.reset(rst),
		.au(arriba),
		.dis(abajo),
		.l(izq),
		.r(der),
		.f(fmt),
		.prh(ph),
		.prf(pf),
		.prc(pc),
		.icr(ic)
);
//
FMSPrincipal FMSPrincipa(
		.fin(final),
		.clock(clk),
		.reset(rst),
		.Phora(ph),
		.Pfecha(pf),
		.Pcrono(pc),
		.cronoini(ic),
		.format(fmt),
		.ENchora(ENch),
		.ENcfecha(ENcf),
		.ENccrono(ENcc),
		.ENghora(ENgh),
		.ENgfecha(ENgf),
		.ENgcrono(ENgc),
		.ENedatos(ENed),
		.ENcinic(ENci),
		.ENcompa(ENcomp),
		.lock(lck),
		.selmuxdt(Smuxdt),
		.selmuxctr(Smuxctr)
);
//
LecturaRTC LecturaRT(
		.ADin(ADin),
		.clock(clk),
		.reset(rst),
		.chs(ENed),
		.format(fmt),
		.ADout(M3[7:0]),
		.ad(M3[11]),
		.wr(M3[8]),
		.rd(M3[10]),
		.cs(M3[9]),
		.hora(dt11[23:16]),
		.min(dt11[15:8]),
		.seg(dt11[7:0]),
		.dia(dt12[23:16]),
		.mes(dt12[15:8]),
		.year(dt12[7:0]),
		.horacrono(horacr),
		.mincrono(mincr),
		.segcrono(segcr),
		.AmPm(ap1),
		.Pup(Pullup)
);
//
EscrituraCrono EscrituraCron(
		.EN(ENcc),
		.UP(arriba),
		.DOWN(abajo),
		.LEFT(izq),
		.RIGHT(der),
		.clk(clk),
		.reset(rst),
		.HCcr(horapr),
		.MCcr(minpr),
		.SCcr(segpr),
		.contador(cursgcrono)
);
//						
EscrituraFecha EscrituraFech(
		.dia(dt12[23:16]),
		.mes(dt12[15:8]),
		.year(dt12[7:0]),
		.EN(ENcf),
		.BTup(arriba),
		.BTdown(abajo),
		.BTl(izq),
		.BTr(der),
		.clk(clk),
		.reset(rst),
		.diaC(dt22[23:16]),
		.mesC(dt22[15:8]),
		.yearC(dt22[7:0]),
		.contador(cursgfecha)
);
//
EscrituraHora EscrituraHor(
		.clk(clk),
		.reset(rst),
		.ampm(ap1),
		.Formato(fmt),
		.EN(ENch),
		.UP(arriba),
		.DOWN(abajo),
		.LEFT(izq),
		.RIGHT(der),
		.H(dt11[23:16]),
		.M(dt11[15:8]),
		.S(dt11[7:0]),
		.HC(dt21[23:16]),
		.MC(dt21[15:8]),
		.SC(dt21[7:0]),
		.AmPm(ap2),
		.Contador(cursghora)
);
//
LecturaCrono LecturaCron(
		.clock(clk),
		.reset(rst),
		.chs(ENgc),
		.ADout(M6[7:0]),
		.ad(M6[11]),
		.wr(M6[8]),
		.rd(M6[10]),
		.cs(M6[9])
);
//					
LecturaFecha LecturaFech(
		.swcr(ic),
		.form(fmt),
		.dia(dt22[23:16]),
		.mes(dt22[15:8]),
		.year(dt22[7:0]),
		.clock(clk),
		.reset(rst),
		.chs(ENgf),
		.ADout(M5[7:0]),
		.ad(M5[11]),
		.wr(M5[8]),
		.rd(M5[10]),
		.cs(M5[9])
);
//
LecturaHora LecturaHor(
		.swcr(ic),
		.form(fmt),
		.hora(dt21[22:16]),
		.min(dt21[15:8]),
		.seg(dt21[7:0]),
		.AmPm(ap2),
		.clock(clk),
		.reset(rst),
		.chs(ENgh),
		.ADout(M4[7:0]),
		.ad(M4[11]),
		.wr(M4[8]),
		.rd(M4[10]),
		.cs(M4[9])
);
//
MUXRTC MUXRT(
		.SMUX1(M1),
		.SMUX2(M2),
		.SMUX3(M3),
		.SMUX4(M4),
		.SMUX5(M5),
		.SMUX6(M6),
		.Select(Smuxctr),
		.AD(AD),
		.RD(RD),
		.CS(CS),
		.WR(WR),
		.ADout(ADout)
);
//
MUXDATA MUXDAT(
		.datos11(dt11),
		.datos12(dt12),
		.datos21(dt21),
		.datos22(dt22),
		.ap1(ap1),
		.ap2(ap2),
		.seleccion(Smuxdt),
		.hora(hora),
		.min(min),
		.seg(seg),
		.dia(d),
		.mes(me),
		.year(y),
		.ampm(AMPM)
);
//
Comparador Comparado(
		.CprogH(horapr),
		.CprogM(minpr),
		.CprogS(segpr),
		.CcountH(horacr),
		.CcountM(mincr),
		.CcountS(segcr),
		.en(ENcomp),
		.reset(rst),
		.clock(clk),
		.fin(final)
);
//
IniciarCrono IniciarCron(
		.clock(clk),
		.reset(rst),
		.enc(ENci),
		.inic(Switch4),
		.format(Switch5),
		.lock(lck),
		.fin(final),
		.ad(M2[11]),
		.wr(M2[8]),
		.cs(M2[9]),
		.rd(M2[10]),
		.ADout(M2[7:0])
);

assign tim=final;
assign formato=fmt;

endmodule
