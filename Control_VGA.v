`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:04 09/18/2016 
// Design Name: 
// Module Name:    Control_VGA 
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
module Control_VGA(
   input wire reloj_nexys, reset_total,
	input [1:0] direc_prog,
	input [2:0] prog_crono, prog_fecha, prog_hora,
	input crono_final, tiempo, formato, 
	input wire [7:0] hora_x, min_x, seg_x, dia_x, mes_x, year_x, hora_crono, min_crono, seg_crono,
	output wire [11:0] color_salida,
	output wire hsync, vsync
    );
	 
	 wire ON_VID; 
	 wire [9:0] x_p, y_p;
	 wire PT;
	 wire [11:0] rgb_next;
	 reg [11:0] rgb_reg;
	 wire [11:0] colors;
	 wire medio_seg;
	
	
	 Pantalla_VGA inst_Pantalla_VGA(
		 .clk(reloj_nexys),// 100 MHz
		 .clk_alarma(medio_seg), 
		 .dir_prog(direc_prog),
		 .p_crono(prog_crono),
		 .p_fecha(prog_fecha),
		 .p_hora(prog_hora),
		 .crono_end(parpadeo),
		 .am_pm(tiempo),
		 .formato(formato),
		 .hora(hora_x),
		 .min(min_x),
		 .seg(seg_x),
		 .dia(dia_x),
		 .mes(mes_x),
		 .year(year_x), 
		 .hcrono(hora_crono),
		 .mcrono(min_crono),
		 .scrono(seg_crono),
		 .pixel_x(x_p),
		 .pixel_y(y_p),
		 .color(colors)
	 );
	 
	 contador_clk inst_contador_clk(
		.CLK_NX(reloj_nexys),
		.reset(reset_total),
		.pixel_rate(PT),
	 	.clk_RING(medio_seg)
	 );
	 
	sincronizacion inst_sincronizacion(
		 .reset(reset_total),
		 .CLK_pix_rate(PT),
		 .h_sync(hsync),
		 .v_sync(vsync),
		 .video_on(ON_VID),
		 .pixel_x(x_p),
		 .pixel_y(y_p)
	 );
	 
	 
	 mux_colores inst_mux_colores(
		.video_on(ON_VID),
		.color(colors),
		.RGB(rgb_next)
	);
	 
	 alarma inst_alarma(
		.CLK_Ring(medio_seg),
		.reset(reset_total),
		.fin_crono(crono_final),
		.band_parp(parpadeo)
	 );
	 
	
	 
	 always @(posedge reloj_nexys, posedge reset_total)
		 begin
			 if(reset_total)
				rgb_reg<=12'hfff;
			 else
			 begin
				if (PT)
					rgb_reg<=rgb_next;
			 end
		 end
		 assign color_salida=rgb_reg;
		
	 
	 
endmodule 