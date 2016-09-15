`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:30 09/13/2016 
// Design Name: 
// Module Name:    VGA_Display 
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
module VGA_Display(
	 input clk_alarma, clk, clk_vga, rst,
	 input [9:0] pixel_x, pixel_y,
	 input [7:0] hora, min, seg, dia, mes, year, hcrono, mcrono, scrono, hcrono_rtc, mcrono_rtc, scrono_rtc,
	 input fin_crono, 
	 input am_pm, hformato,
	 input [2:0] dir_cursor,			//indica la posición del cursor en la programación
	 input [7:0] progra_lugar,					//indica que cosa el usuario desea programar o si no desea programar nada
	 output reg [7:0] color
    );
	 localparam imagenhoraTot = 12'd3800;
	 localparam imagenhorax = 7'd95;
	 localparam imagenhoray = 6'd40;
	 localparam x_hora = 7'd85;
	 localparam y_hora = 6'd48;
	 
	 localparam imagencronoTot = 14'd10080;
	 localparam imagencronox = 8'd252;
	 localparam imagencronoy = 6'd40;
	 localparam x_crono = 8'd194;
	 localparam y_crono = 8'd192;
	 
	 localparam imagenfechaTot = 12'd3844;
	 localparam imagenfechax = 7'd124;
	 localparam imagenfechay = 6'd31;
	 localparam x_fecha = 9'd434;
	 localparam y_fecha = 6'd50;
	 
	 localparam imageninstruccionTot = 15'd6885; //instrucciones
	 localparam imageninstruccionx = 8'd255;
	 localparam imageninstrucciony = 8'170; //170
	 localparam x_instruccion = 5'd30;	
	 localparam y_instruccion = 9'd330;
	
	 localparam imagenteclasTot = 11'd1764;//teclas
	 localparam imagenteclasx = 6'd63;
	 localparam imagenteclasy = 5'd28;
	 localparam x_teclas = 10'd522;
	 localparam y_teclas = 9'd410;
	 
	 localparam cuenta = 24'd16666666;

	 //Indicaciones y arreglos para las imagenes cargadas
	 
	 wire [11:0] hora_est;
	 wire [13:0] crono_est;
	 wire [11:0] fecha_est;
	 wire [12:0] instruccion_est;
	 wire [11:0] teclas_est;
	 
	 reg [7:0] color_hora [0:imagenhoraTot-1];
 	 reg [7:0] color_crono [0:imagencronoTot-1];
	 reg [7:0] color_fecha [0:imagenfechaTot-1];
	 reg [7:0] color_instruccion [0:imageninstruccionTot-1];
	 reg [7:0] color_teclas [0:imagenteclasTot-1];
	 
	 //Registros para la memoria ROM
	 wire [11:0] dir_memoria;		
	 wire [15:0] palabra;
	 wire fuente_bit;
	 
	 wire hora, formato_hora;
	 wire fecha, formato_fecha;
	 wire crono_set, crono_run, alarma;
	 
	 
	 //Señales de direccion en x y en y
	 reg [3:0] dir_bit;
	 wire [3:0] db_hora, db_formato_hora;
	 wire [3:0] db_fecha, db_formato_fecha;
	 wire [3:0] db_crono_set, db_crono_run, db_alarma;
	 reg [4:0] dir_fila;
	 wire [4:0] df_hora, df_formato_hora;
	 wire [4:0] df_fecha, df_formato_fecha;
	 wire [4:0] df_crono_set, df_crono_run, df_alarma;
	 
	 //Registros para los caracteres
	 reg [6:0] caracter;
	 reg [6:0] caracter_hora, caracter_formato_hora;
	 reg [6:0] caracter_fecha, caracter_formato_fecha;
	 reg [6:0] caracter_crono_set, caracter_crono_run, caracter_alarma;	 
	 
	 //Registros para generar la alarma
	 reg [23:0] contador;
	 reg estado;
	 reg estado_sig;
	 reg clk_parp, bandera;
	 reg [5:0] totalcont;	 
	 endmodule
