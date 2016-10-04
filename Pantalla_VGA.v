`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:56:51 09/18/2016 
// Design Name: 
// Module Name:    Pantalla_VGA 
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
module Pantalla_VGA(
	input clk, clk_alarma, 
	input [1:0] dir_prog,
	 input [2:0] p_crono, p_fecha, p_hora,
	 input crono_end, am_pm, formato,
	 input [7:0] hora, min, seg, dia, mes, year, hcrono, mcrono, scrono,
    input [9:0] pixel_x,
	 input [9:0] pixel_y,
	 output reg [11:0] color
	);
	
	 wire [7:0] palabra;
	 wire fuente_bit;
	 wire [10:0] dir_memo;
	 wire hour_a, hour_b,     hour_g;
	 wire cron_a, cron_b, cron_c;
	 wire prog_a, prog_b, prog_c, prog_d, prog_e;
	 wire flec_u, flec_d, flec_r, flec_l;
	 wire divisor_pant;


	//Señales asignadas para la dirección de los bits que tendrán los caracteres en la VGA
	 wire [2:0] db_f_a, db_f_b; 
	 wire [2:0] db_h_a, db_h_b,  db_h_f, db_h_g;
	 wire [2:0] db_c_a, db_c_b, db_c_c; 
	 wire [2:0] db_p_a, db_p_b, db_p_c, db_p_d, db_p_e;
	 wire [2:0] db_a_u, db_a_d, db_a_r, db_a_l;
	 wire [2:0] db_d_p;//divisor de pantalla
	 reg [2:0] dir_bit;
	 
	 //Señales asignadas para definir la fila en la cual se pintará los bits (char_address)
	 wire [3:0] df_f_a, df_f_b;
	 wire [3:0] df_h_a, df_h_b,   df_h_f, df_h_g;
	 wire [3:0] df_c_a, df_c_b, df_c_c; 
	 wire [3:0] df_p_a, df_p_b, df_p_c, df_p_d, df_p_e;
	 wire [3:0] df_d;
	 wire [3:0] df_a_u, df_a_d, df_a_r, df_a_l;
	 wire [3:0] df_d_p;
	 wire [3:0] df_b_u,  df_b_l, df_b_r;
	 wire [3:0] df_c_u_l, df_c_d_l, df_c_u_r, df_c_d_r;
	 reg [3:0] dir_fila;
	 
	 
	 //Señales de registro para los caracteres que se utilizaran tanto para la pantalla estatica como las señales variantes del RTC 
	 reg [6:0] caracter_f_a, caracter_f_b;
	 reg [6:0] caracter_h_a, caracter_h_b,caracter_h_f, caracter_h_g;
	 reg [6:0] caracter_c_a, caracter_c_b, caracter_c_c; 
	 reg [6:0] caracter_p_a, caracter_p_b, caracter_p_c, caracter_p_d, caracter_p_e;
	 reg [6:0] caracter_d;
	 reg [6:0] caracter_a_u, caracter_a_d, caracter_a_r, caracter_a_l;
	 reg [6:0] caracter;
	 reg [6:0] caracter_d_p;
	 reg [6:0] caracter_b_u,  caracter_b_l, caracter_b_r;
	 reg [6:0] caracter_c_u_l, caracter_c_d_l, caracter_c_u_r, caracter_c_d_r;
	 
	 reg [6:0] a_p, m_on, doce_sign, veint_sign, RING, X_next;
	
	//---------------------------instancia de memoria----------------------------------//
	
	memoria_font instancia_memoria_font (.clk(clk), .addr(dir_memo), .data(palabra));
	
	//--------------------------------------------------------------------------------//
	
	
	 assign date_a= (32<=pixel_x) && (pixel_x<208) && (pixel_y[9:5]==5'd2);
	 assign db_f_a=pixel_x[3:1]; 
	 assign df_f_a=pixel_y[4:1];
	 
	 always @*
	 begin
		case (pixel_x[7:4])
			4'h0: caracter_f_a = 7'h00;	//
			4'h1: caracter_f_a = 7'h00;	//
			4'h2: caracter_f_a = 7'h00;	//
			4'h3: caracter_f_a = 7'h00;	//
			4'h4: caracter_f_a = 7'h00;	//
			4'h5: caracter_f_a = 7'h46;	//F
			4'h6: caracter_f_a = 7'h65;	//e
			4'h7: caracter_f_a = 7'h63;	//c
			4'h8: caracter_f_a = 7'h68;	//h
			4'h9: caracter_f_a = 7'h61;	//a
			4'ha: caracter_f_a = 7'h00;	//
			4'hb: caracter_f_a = 7'h00;	//
			4'hc: caracter_f_a = 7'h00;	//
			4'hd: caracter_f_a = 7'h00;	//
			4'he: caracter_f_a = 7'h00;	//
			4'hf: caracter_f_a = 7'h00;	//
			default: caracter_f_a = 7'h00;	//
		endcase
	 end
	 
	 assign date_b= (pixel_y[9:5]==5'd2) && (15<=pixel_x[9:4]) && (pixel_x[9:4]<26);
	 assign db_f_b=pixel_x[3:1];
	 assign df_f_b=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[7:4])
			4'hf: caracter_f_b={3'b011,dia[7:4]};	
			4'h0: caracter_f_b={3'b011,dia[3:0]};	
			4'h1: caracter_f_b=7'h2f;	// '/'
			4'h2: caracter_f_b={3'b011,mes[7:4]};	
			4'h3: caracter_f_b={3'b011,mes[3:0]};	
			4'h4: caracter_f_b=7'h2f;	// '/'
			4'h5: caracter_f_b={3'b011,year[7:4]};	
			4'h6: caracter_f_b={3'b011,year[3:0]};	
			default: caracter_f_b=7'h00;	
		endcase
	 end
	 
	
	 
	 assign hour_a= (pixel_y[9:5]==4) && (6'd2<=pixel_x[9:4]) && (pixel_x[9:4]<6'd13);
	 assign db_h_a=pixel_x[3:1];
	 assign df_h_a=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[7:4])
			4'h5: caracter_h_a=7'h48;	//H
			4'h6: caracter_h_a=7'h6f;	//o
			4'h7: caracter_h_a=7'h72;	//r
			4'h8: caracter_h_a=7'h61;	//a
			default: caracter_h_a=7'h00;	//
		endcase
	 end
	 
	 assign hour_b= (pixel_y[9:5]==5'd4) && (15<=pixel_x[9:4]) && (pixel_x[9:4]<26);
	 assign db_h_b=pixel_x[3:1];
	 assign df_h_b=pixel_y[4:1];
	 always @*
	 begin
		 case (am_pm)
			 1'h0: X_next=7'h61;		
			 1'h1: X_next=7'h70;				
			 default: X_next=7'h61;
		 endcase
		 case (formato)
			1'h0:					
			begin
				m_on=7'h00;
				a_p=7'h00;
			end
			1'h1:					
			begin
				m_on=7'h6d;
				a_p=X_next;
			end
			default: 
			begin
				m_on=7'h00;
				a_p=7'h00;
			end
		endcase

		case (pixel_x[7:4])
			4'hf: caracter_h_b={3'b011,hora[7:4]};	
			4'h0: caracter_h_b={3'b011,hora[3:0]};	
			4'h1: caracter_h_b=7'h3a;					
			4'h2: caracter_h_b={3'b011,min[7:4]};	
			4'h3: caracter_h_b={3'b011,min[3:0]};	
			4'h4: caracter_h_b=7'h3a;					
			4'h5: caracter_h_b={3'b011,seg[7:4]};
			4'h6: caracter_h_b={3'b011,seg[3:0]};	
			4'h7: caracter_h_b=7'h00;					
			4'h8: caracter_h_b=a_p;						
			4'h9: caracter_h_b=m_on;					
			default: caracter_h_b=7'h00;				
		endcase
	 end
	 
	 
	 assign cron_a= (pixel_y[9:5]==5'd6) && (6'd2<=pixel_x[9:4]) && (pixel_x[9:4]<6'd13);
	 assign db_c_a=pixel_x[3:1];
	 assign df_c_a=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[7:4])
			4'h3: caracter_c_a=7'h43;	//C
			4'h4: caracter_c_a=7'h72;	//r
			4'h5: caracter_c_a=7'h6f;	//o
			4'h6: caracter_c_a=7'h6e;	//n
			4'h7: caracter_c_a=7'h1a;	//ó
			4'h8: caracter_c_a=7'h6d;	//m
			4'h9: caracter_c_a=7'h65;	//e
			4'ha: caracter_c_a=7'h74;	//t
			4'hb: caracter_c_a=7'h72;	//r
			4'hc: caracter_c_a=7'h6f;	//o
			default: caracter_c_a=7'h00;	//
		endcase
	 end
	 
	 assign cron_b= (pixel_y[9:5]==5'd6) && (15<=pixel_x[9:4]) && (pixel_x[9:4]<26);
	 assign db_c_b=pixel_x[3:1];
	 assign df_c_b=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[7:4])
			4'hf: caracter_c_b={3'b011,hcrono[7:4]};	
			4'h0: caracter_c_b={3'b011,hcrono[3:0]};	
			4'h1: caracter_c_b=7'h3a;						
			4'h2: caracter_c_b={3'b011,mcrono[7:4]};	
			4'h3: caracter_c_b={3'b011,mcrono[3:0]};	
			4'h4: caracter_c_b=7'h3a;						
			4'h5: caracter_c_b={3'b011,scrono[7:4]};	
			4'h6: caracter_c_b={3'b011,scrono[3:0]};	
			default: caracter_c_b=7'h00;	
		endcase
	 end
	 
	 assign cron_c= (pixel_y[9:6]==4'd3) && (14<=pixel_x[9:5]) && (pixel_x[9:5]<19);
	 assign db_c_c=pixel_x[4:2];
	 assign df_c_c=pixel_y[5:2];
	 always @*
	 begin
		case (crono_end)
			1'h0: RING = 7'h00;
			1'h1: RING = 7'h01;
			default: RING = 7'h00;	
		endcase
		case (pixel_x[8:5])
			4'hf: caracter_c_c=RING;	
			default: caracter_c_c=7'h00;	
		endcase
	 end
	 
	 
	 assign divisor_pant = (pixel_y[9:5]==4'd8) && (1<=pixel_x[9:4]) && (pixel_x[9:4]<39);
	 assign db_d_p=pixel_x[3:1];
	 assign df_d_p=pixel_y[4:1];
	 always @*
	 begin
		case(pixel_x[9:4])
			6'h00: caracter_d_p = 7'h16;			
			default: caracter_d_p = 7'h16;		
		endcase
	 end
	 
	 assign prog_a= (pixel_y[9:5]==5'd10) && (6'd2<=pixel_x[9:4]) && (pixel_x[9:4]<6'd19);
	 assign db_p_a=pixel_x[3:1];
	 assign df_p_a=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[8:4])
			5'h03: caracter_p_a = 7'h50;	//P
			5'h04: caracter_p_a = 7'h72;	//r
			5'h05: caracter_p_a = 7'h6f;	//o
			5'h06: caracter_p_a = 7'h67;	//g
			5'h07: caracter_p_a = 7'h2e;	//.
			5'h08: caracter_p_a = 7'h00;	//
			5'h09: caracter_p_a = 7'h46;	//F
			5'h0a: caracter_p_a = 7'h65;	//e
			5'h0b: caracter_p_a = 7'h63;	//c
			5'h0c: caracter_p_a = 7'h68;	//h
			5'h0d: caracter_p_a = 7'h61;	//a
			5'h0e: caracter_p_a = 7'h00;	//
			5'h0f: caracter_p_a = 7'h00;	//
			5'h10: caracter_p_a = 7'h53;	//S
			5'h11: caracter_p_a = 7'h32;	//1
			default: caracter_p_a=7'h00;	//
		endcase
	 end
	 
	 assign prog_b= (pixel_y[9:5]==5'd9) && (2<=pixel_x[9:4]) && (pixel_x[9:4]<19);
	 assign db_p_b=pixel_x[3:1];
	 assign df_p_b=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[8:4])
			5'h03: caracter_p_b = 7'h50;	//P
			5'h04: caracter_p_b = 7'h72;	//r
			5'h05: caracter_p_b = 7'h6f;	//o
			5'h06: caracter_p_b = 7'h67;	//g
			5'h07: caracter_p_b = 7'h2e;	//.
			5'h08: caracter_p_b = 7'h00;	//
			5'h09: caracter_p_b = 7'h48;	//H
			5'h0a: caracter_p_b = 7'h6f;	//o
			5'h0b: caracter_p_b = 7'h72;	//r
			5'h0c: caracter_p_b = 7'h61;	//a
			5'h0d: caracter_p_b = 7'h00;	//
			5'h0e: caracter_p_b = 7'h00;	//
			5'h0f: caracter_p_b = 7'h00;	//
			5'h10: caracter_p_b = 7'h53;	//S
			5'h11: caracter_p_b = 7'h31;	//2
			default: caracter_p_b=7'h00;	//
		endcase
	 end
	 
	 assign prog_c= (pixel_y[9:5]==5'd11) && (2<=pixel_x[9:4]) && (pixel_x[9:4]<19);
	 assign db_p_c=pixel_x[3:1];
	 assign df_p_c=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[8:4])
			5'h03: caracter_p_c = 7'h50;	//P
			5'h04: caracter_p_c = 7'h72;	//r
			5'h05: caracter_p_c = 7'h6f;	//o
			5'h06: caracter_p_c = 7'h67;	//g
			5'h07: caracter_p_c = 7'h2e;	//.
			5'h08: caracter_p_c = 7'h00;	//
			5'h09: caracter_p_c = 7'h43;	//C
			5'h0a: caracter_p_c = 7'h72;	//r
			5'h0b: caracter_p_c = 7'h6f;	//o
			5'h0c: caracter_p_c = 7'h6e;	//n
			5'h0d: caracter_p_c = 7'h6f;	//o
			5'h0e: caracter_p_c = 7'h00;	//
			5'h0f: caracter_p_c = 7'h00;	//
			5'h10: caracter_p_c = 7'h53;	//S
			5'h11: caracter_p_c = 7'h33;	//3
			default: caracter_p_c=7'h00;	//
		endcase
	 end
	 
	 assign prog_d= (pixel_y[9:5]==5'd12) && (2<=pixel_x[9:4]) && (pixel_x[9:4]<19);
	 assign db_p_d=pixel_x[3:1];
	 assign df_p_d=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[8:4])
			5'h03: caracter_p_d = 7'h49;	//I
			5'h04: caracter_p_d = 7'h6e;	//n
			5'h05: caracter_p_d = 7'h69;	//i
			5'h06: caracter_p_d = 7'h63;	//c
			5'h07: caracter_p_d = 7'h69;	//i
			5'h08: caracter_p_d = 7'h6f;	//o
			5'h09: caracter_p_d = 7'h00;	//
			5'h0a: caracter_p_d = 7'h63;	//c
			5'h0b: caracter_p_d = 7'h72;	//r
			5'h0c: caracter_p_d = 7'h6f;	//o
			5'h0d: caracter_p_d = 7'h6e;	//n
			5'h0e: caracter_p_d = 7'h6f;	//o
			5'h0f: caracter_p_d = 7'h00;	// 
			5'h10: caracter_p_d = 7'h53;	//S
			5'h11: caracter_p_d = 7'h34;	//4
			default: caracter_p_d=7'h00;	//
		endcase
	 end
	 
	 assign prog_e= (pixel_y[9:5]==5'd13) && (2<=pixel_x[9:4]) && (pixel_x[9:4]<19);
	 assign db_p_e=pixel_x[3:1];
	 assign df_p_e=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[8:4])
			5'h03: caracter_p_e = 7'h46;	//F
			5'h04: caracter_p_e = 7'h6f;	//o
			5'h05: caracter_p_e = 7'h72;	//r
			5'h06: caracter_p_e = 7'h6d;	//m
			5'h07: caracter_p_e = 7'h61;	//a
			5'h08: caracter_p_e = 7'h74;	//t
			5'h09: caracter_p_e = 7'h6f;	//o
			5'h0a: caracter_p_e = 7'h00;	//
			5'h0b: caracter_p_e = 7'h68;	//h
			5'h0c: caracter_p_e = 7'h6f;	//o
			5'h0d: caracter_p_e = 7'h72;	//r
			5'h0e: caracter_p_e = 7'h61;	//a
			5'h0f: caracter_p_e = 7'h00;	// 
			5'h10: caracter_p_e = 7'h53;	//S
			5'h11: caracter_p_e = 7'h35;	//5
			default: caracter_p_e=7'h00;	//
		endcase
	 end
	 

	 assign flec_u = (pixel_y[9:5]==10) && (29<=pixel_x[9:4]) && (pixel_x[9:4]<30);	//Flecha hacia arriba
	 assign db_a_u=pixel_x[3:1];
	 assign df_a_u=pixel_y[4:1];
	 always @*
	 begin	 
		case (pixel_x[7:4])
			4'hd: caracter_a_u=7'h18;
			default: caracter_a_u=7'h00;	
		endcase
	 end
	 
	 assign flec_l = (pixel_y[9:5]==11) && (27<=pixel_x[9:4]) && (pixel_x[9:4]<28);	//Flecha hacia izquierda
	 assign db_a_l=pixel_x[3:1];
	 assign df_a_l=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[7:4])
			4'hb: caracter_a_l=7'h1b;
			default: caracter_a_l=7'h00;	//
		endcase
	 end
	 
	 assign flec_r = (pixel_y[9:5]==11) && (31<=pixel_x[9:4]) && (pixel_x[9:4]<32);	//Flecha hacia derecha
	 assign db_a_r=pixel_x[3:1];
	 assign df_a_r=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[7:4])
			4'hf: caracter_a_r=7'h1c;
			default: caracter_a_r=7'h00;	//
		endcase
	 end
	 
	 assign flec_d = (pixel_y[9:5]==12) && (29<=pixel_x[9:4]) && (pixel_x[9:4]<31);	//Flecha hacia abajo
	 assign db_a_d=pixel_x[3:1];
	 assign df_a_d=pixel_y[4:1];
	 always @*
	 begin
		case (pixel_x[7:4])
			4'hd: caracter_a_d=7'h19;
			default: caracter_a_d=7'h00;	
		endcase
	 end
	 
	 
	  always @* 
	 begin
	 dir_bit= pixel_x[3:1];
	 color=12'h099;	//se asigna color de fondo de la VGA (celeste)							
		if (date_a) 
			begin caracter=caracter_f_a; dir_fila= df_f_a; dir_bit=db_f_a; 
				if (fuente_bit) color=12'hfff;				//se asigna color de caracteres mostrados en pantalla (blanco)
			end 
		else if (date_b) 
			begin caracter=caracter_f_b; dir_fila= df_f_b; dir_bit=db_f_b; 
				if (dir_prog==0 && fuente_bit) color=12'hfff;				
				else if (dir_prog==2)
				begin
					if (p_fecha==0 && pixel_x[7:4]==4'hf && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_fecha==0 && pixel_x[7:4]==4'hf && ~clk_alarma) color=12'h099;						
					else if (p_fecha==1 && pixel_x[7:4]==4'h0 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_fecha==1 && pixel_x[7:4]==4'h0 && ~clk_alarma) color=12'h099;					
					else if (p_fecha==2 && pixel_x[7:4]==4'h2 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_fecha==2 && pixel_x[7:4]==4'h2 && ~clk_alarma) color=12'h099;					
					else if (p_fecha==3 && pixel_x[7:4]==4'h3 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_fecha==3 && pixel_x[7:4]==4'h3 && ~clk_alarma) color=12'h099;					
					else if (p_fecha==4 && pixel_x[7:4]==4'h5 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_fecha==4 && pixel_x[7:4]==4'h5 && ~clk_alarma) color=12'h099;					
					else if (p_fecha==5 && pixel_x[7:4]==4'h6 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_fecha==5 && pixel_x[7:4]==4'h6 && ~clk_alarma) color=12'h099;					
					else if (fuente_bit) color=12'hfff;
				end
				else if (fuente_bit) color=12'hfff;
			end 

		
		else if (hour_a)  
			begin caracter=caracter_h_a; dir_fila= df_h_a; dir_bit=db_h_a; 
				if (fuente_bit) color=12'hfff;				
			end 
		else if (hour_b)  
			begin caracter=caracter_h_b; dir_fila= df_h_b; dir_bit=db_h_b; 
				if (dir_prog==0 && fuente_bit) color=12'hfff;				
				else if (dir_prog==1)
				begin
					if (p_hora==0 && pixel_x[7:4]==4'hf && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_hora==0 && pixel_x[7:4]==4'hf && ~clk_alarma) color=12'h099;						
					else if (p_hora==1 && pixel_x[7:4]==4'h0 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_hora==1 && pixel_x[7:4]==4'h0 && ~clk_alarma) color=12'h099;					
					else if (p_hora==2 && pixel_x[7:4]==4'h2 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_hora==2 && pixel_x[7:4]==4'h2 && ~clk_alarma) color=12'h099;					
					else if (p_hora==3 && pixel_x[7:4]==4'h3 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_hora==3 && pixel_x[7:4]==4'h3 && ~clk_alarma) color=12'h099;					
					else if (p_hora==4 && pixel_x[7:4]==4'h5 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_hora==4 && pixel_x[7:4]==4'h5 && ~clk_alarma) color=12'h099;					
					else if (p_hora==5 && pixel_x[7:4]==4'h6 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_hora==5 && pixel_x[7:4]==4'h6 && ~clk_alarma) color=12'h099;					
					else if (fuente_bit) color=12'hfff;
				end
				else if (fuente_bit) color=12'hfff;
			end 

		else if (hour_g) 
			begin caracter=caracter_h_g; dir_fila= df_h_g; dir_fila=db_h_g; 
				if (fuente_bit) color=12'hfff;				
			end
		
		else if (cron_a) 
			begin caracter=caracter_c_a; dir_fila= df_c_a; dir_bit=db_c_a; 
				if (fuente_bit) color=12'hfff;				
			end 
		else if (cron_b) 
			begin caracter=caracter_c_b; dir_fila= df_c_b; dir_bit=db_c_b; 
				if (dir_prog==0 && fuente_bit) color=12'hfff;				
				else if (dir_prog==3)
				begin
					if (p_crono==0 && pixel_x[7:4]==4'hf && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_crono==0 && pixel_x[7:4]==4'hf && ~clk_alarma) color=12'h099;						
					else if (p_crono==1 && pixel_x[7:4]==4'h0 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_crono==1 && pixel_x[7:4]==4'h0 && ~clk_alarma) color=12'h099;					
					else if (p_crono==2 && pixel_x[7:4]==4'h2 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_crono==2 && pixel_x[7:4]==4'h2 && ~clk_alarma) color=12'h099;					
					else if (p_crono==3 && pixel_x[7:4]==4'h3 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_crono==3 && pixel_x[7:4]==4'h3 && ~clk_alarma) color=12'h099;					
					else if (p_crono==4 && pixel_x[7:4]==4'h5 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_crono==4 && pixel_x[7:4]==4'h5 && ~clk_alarma) color=12'h099;					
					else if (p_crono==5 && pixel_x[7:4]==4'h6 && clk_alarma && fuente_bit)  color=12'hfff;				
					else if (p_crono==5 && pixel_x[7:4]==4'h6 && ~clk_alarma) color=12'h099;					
					else if (fuente_bit) color=12'hfff;
				end
				else if (fuente_bit) color=12'hfff;
			end
		else if (cron_c)  
			begin caracter=caracter_c_c; dir_fila= df_c_c; dir_bit=db_c_c; 
				if (fuente_bit) color=12'he00;			
			end

		else if (divisor_pant)
			begin caracter=caracter_d_p; dir_fila= df_d_p; dir_bit=db_d_p; 
				if (fuente_bit) color=12'h643;			//Linea divisoria
			end
		else if (prog_a)  
			begin caracter=caracter_p_a; dir_fila= df_p_a; dir_bit=db_p_a; 
				if (fuente_bit) color=12'hfff;				
			end 
		else if (prog_b)  
			begin caracter=caracter_p_b; dir_fila= df_p_b; dir_bit=db_p_b; 
				if (fuente_bit) color=12'hfff;				
			end 
		else if (prog_c)  
			begin caracter=caracter_p_c; dir_fila= df_p_c; dir_bit=db_p_c; 
				if (fuente_bit) color=12'hfff;				
			end
		else if (prog_d)  
			begin caracter=caracter_p_d; dir_fila= df_p_d; dir_bit=db_p_d; 
				if (fuente_bit) color=12'hfff;				
			end
		else if (prog_e)  
			begin caracter=caracter_p_e; dir_fila= df_p_e; dir_bit=db_p_e; 
				if (fuente_bit) color=12'hfff;				
			end
			
		else if (flec_u)
			begin caracter=caracter_a_u; dir_fila= df_a_u; dir_bit=db_a_u; 
				if (fuente_bit) color=12'hfff;				
			end 
		else if (flec_d)  
			begin caracter=caracter_a_d; dir_fila= df_a_d; dir_bit=db_a_d; 
				if (fuente_bit) color=12'hfff;				
			end 
		else if (flec_r) 
			begin caracter=caracter_a_r; dir_fila= df_a_r; dir_bit=db_a_r; 
				if (fuente_bit) color=12'hfff;				
			end 
		else if (flec_l) 
			begin caracter=caracter_a_l; dir_fila= df_a_l; dir_bit=db_a_l; 
				if (fuente_bit) color=12'hfff;				
			end
		else begin caracter=7'h00; 
				dir_bit=pixel_x[3:1]; 
				dir_fila=pixel_y[4:1]; 
				color=12'h099; 
			end
	 end
	 
	 assign dir_memo={caracter,dir_fila};
	 assign fuente_bit=palabra[~dir_bit];
endmodule 