`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:40 09/20/2016 
// Design Name: 
// Module Name:    Inicio 
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

// Para el V3023, se debe seguir una serie de pasos para inicializarlo,
// con el objetivo de eliminar errores por cargas incorrectas de datos 
// aleatorios que se presentaban en el RTC al momento de aplicarse por
// primera vez la alimentación.

//Variables necesarias para Escribir/Leer en la memoria del V3023
module Inicio(
    input clki,
    input rst,
	 output reg AD,
    output reg CS,
	 output reg WR,
    output reg RD,
    output reg [7:0] ADout
    );
reg Iniciar;
reg [7:0]Contador;

always @(posedge clki)
begin

// Iniciamos asignando todas las entradas un valor de "1", lo cual 
// por ser lógica negativa, las desactiva
	if (rst==1)
	begin
		AD<=1'h1;
		WR<=1'h1;
		RD<=1'h1;
		CS<=1'h1;
		ADout<=8'hff;
		Contador<=0;
		Iniciar<=1;
	end
	
// Una vez hecho esto, empieza la secuencia de inicialización
// En contador==0 se escribe por default las variables apagadas y el valor de datos en FF Hexadecimal
	else if (Iniciar)
	begin
		if (Contador==0)
		begin
			AD<=1;
			WR<=1;
			RD<=1;
			CS<=1;
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
		
// Se quiere entrar a la dirección de memoria 02 y escribir un "1" lógico en el bit 4 de ésta, para ello se empieza por activar
// la entrada AD a su posición de lectura, la cual es un "0" lógico
		else if (Contador==1)
		begin
			AD<=0;
			//WR<=1; Esto yo pensaba que se hacía así, pero el contador debe esperar otro ciclo de reloj para poder cambiar
			//RD<=1; el valor de chip select (CS), bueno, debe esperar como mínimo 5ns pero el clock va a 50 Hz, es
			//CS<=1; decir, cada periodo dura 20ns, y cada pulso 10ns, entonces de aquí en adelante nada más se debe escribir 
			//ADout<=8'hff; el dato que se va a cambiar y analizar cuántos ciclos se deben esperar del reloj, y con eso el contador
			Contador<=Contador+1'b1;
		end
			
// Chip Select hay que activarlo, es decir ponerlo en "0" Lógico
		else if(Contador==2)
		begin
			//AD<=0;
			//WR<=1;
			//RD<=1;
			CS<=0;
			//ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
			
// Esperamos otro ciclo para modificar el valor de Write, aunque en la hoja dice que se pueden activar el CS y el WR al mismo
// tiempo, pero mejor prevenir problemas de timming
		else if (Contador==3)
		begin
			//AD<=0;
			WR<=0;
			//RD<=1;
			//CS<=0;
			//ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
		
// En esta cuenta, ya se ha esperado 20 ns desde que se activó el WR, tiempo de sobra para poder activar el dato,
// procedemos a escribir 02Hexa(00000010), para poder acceder a esa direccion de memoria		
		else if(Contador==4)
		begin
			//AD<=0;
			//WR<=0;
			//RD<=1;
			//CS<=0;
			ADout<=8'h02;
			Contador<=Contador+1'b1;
		end
	
//	Esperamos 60ns, que esel tiempo para que se escriba la dirección y se estabilice el dato; de inmediato, se procede a
// ir desactivando las señales de forma inversa a como se fueron activando
		else if(Contador==7)
		begin
			//AD<=0;
			WR<=1;
			//RD<=1;
			//CS<=0;
			//ADout<=8'h02;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==8)
		begin
			//AD<=0;
			//WR<=1;
			//RD<=1;
			CS<=1;
			//ADout<=8'h02;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==9)
		begin
			AD<=1;
			//WR<=1;
			//RD<=1;
			//CS<=1;
			//ADout<=8'h02;
			Contador<=Contador+1'b1;
		end
		
// Por último la entrada de datos se vuelve a colocar en FF Hexadecimal
		else if(Contador==11)
		begin
			//AD<=1;
			//WR<=1;
			//RD<=1;
			//CS<=1;
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
		
// El tiempo mínimo de espera entre 2 lecturas/escituras es de 100ns, por esta razón el contador avanza 6 ciclos de 20ns
// en esta secuencia, la cual empieza directamente con el cambio de CS, ya que el AD ya se encuentra en 1 que es su valor
// predeterminado de lectura		
		else if(Contador==16)
		begin
			CS<=0;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==17)
		begin
			WR<=0;
			Contador<=Contador+1'b1;
		end
		
// Se escribe 08 Hexadecimal ya que esto representa (00001000), es decir, un "1" lógico en su 4to bit 
		else if(Contador==18)
		begin
			ADout<=8'h08;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==21)
		begin
			WR<=1;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==22)
		begin
			CS<=1;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==23)
		begin
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
			
// Aquí finaliza la primera etapa, entrar a la dirección de memoria 02 y escribir 08 Hexadecimal, ahora se debe escribir
// 00 Hexadecimal, para realizar correctamente la inicializacion del bit 
		else if (Contador==28)
		begin
			AD<=0;
			Contador<=Contador+1'b1;
		end
			
		else if(Contador==29)
		begin
			CS<=0;
			Contador<=Contador+1'b1;
		end
			
		else if (Contador==30)
		begin
			WR<=0;
			Contador<=Contador+1'b1;
		end
			
		else if (Contador==31)
		begin
			ADout<=8'h02;
			Contador<=Contador+1'b1;
		end
			
		else if (Contador==34)
		begin
			WR<=1;
			Contador<=Contador+1'b1;
		end
			
		else if (Contador==35)
		begin
			CS<=1;
			Contador<=Contador+1'b1;
		end
			
		else if (Contador==36)
		begin
			AD<=1;
			Contador<=Contador+1'b1;
		end
			
		else if (Contador==38)
		begin
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
			
		else if (Contador==43)
		begin
			CS<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==44)
		begin
			WR<=0;
			Contador<=Contador+1'b1;
		end
			
// Aquí se escribe el dato 00 en el bit de inicialización			
		else if (Contador==45)
		begin
			ADout<=8'h0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==48)
		begin
			WR<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==49)
		begin
			CS<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==51)
		begin
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==56)
		begin
			AD<=0;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==57)
		begin
			CS<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==58)
		begin
			WR<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==59)
		begin
			ADout<=8'h10;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==62)
		begin
			WR<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==63)
		begin
			CS<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==64)
		begin
			AD<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==66)
		begin
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
			
// Ahora, según la hoja de datos del RTC V3023, se debe inicializar el registro de "Digital Trimming" 
		else if (Contador==71)
		begin
			CS<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==72)
		begin
			WR<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==73)
		begin
			ADout<=8'hd2;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==76)
		begin
			WR<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==77)
		begin
			CS<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==79)
		begin
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==84)
		begin
			AD<=0;
			Contador<=Contador+1'b1;
		end
		
		else if(Contador==85)
		begin
			CS<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==86)
		begin
			WR<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==91)
		begin
			ADout<=8'h00;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==92)
		begin
			WR<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==93)
		begin
			CS<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==95)
		begin
			AD<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==100)
		begin
			ADout<=8'hff;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==101)
		begin
			CS<=0;
			Contador<=Contador+1'b1;
		end
	
		else if (Contador==102)
		begin
			WR<=0;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==103)
		begin
			ADout<=8'h00;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==106)
		begin
			WR<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==107)
		begin
			CS<=1;
			Contador<=Contador+1'b1;
		end
		
		else if (Contador==109)
		begin
			if (rst==0)
				Iniciar<=0;
				ADout<=8'hff;
				AD<=1'h1;
				WR<=1'h1;
				RD<=1'h1;
				CS<=1'h1;
			end
			
// Contador externo, sigue contando si no se encuentra en alguno de los casos anteriores
		else Contador<=Contador+1'b1;
		end
	
	else
	begin
		ADout<=8'hff;
		CS<=1'h1;
		AD<=1'h1;
		WR<=1'h1;
		RD<=1'h1;
	end
end
endmodule