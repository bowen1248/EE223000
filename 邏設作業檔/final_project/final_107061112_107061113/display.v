`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 15:51:45
// Design Name: 
// Module Name: display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// define seven segment 
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001

module display(i, D);
input [3:0]i;
output [7:0]D;

reg [7:0]D;

always @*
    case (i)
        4'b0000: D = `SS_0;
        4'b0001: D = `SS_1;
        4'b0010: D = `SS_2;
        4'b0011: D = `SS_3;
        4'b0100: D = `SS_4;
        4'b0101: D = `SS_5;
        4'b0110: D = `SS_6;
        4'b0111: D = `SS_7;
        4'b1000: D = `SS_8;
        4'b1001: D = `SS_9;
        default: D = `SS_9;
    endcase
endmodule