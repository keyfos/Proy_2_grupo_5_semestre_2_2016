`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:38 09/29/2016 
// Design Name: 
// Module Name:    clk_ring 
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
module clk_ring(
input wire clk, 
output reg clk_RING
    );


reg [23:0] m; //Necesito 26 digitos binarios para contar hasta 50 millones

initial m = 0;

always @ (posedge (clk)) begin
 if (m<25000000)
  m <= m + 1'b1;
 else   
  m <= 0;
end

always @ (m) begin
 if (m<12500000)
  clk_RING <= 1;
 else
  clk_RING <= 0;
end
  

endmodule
