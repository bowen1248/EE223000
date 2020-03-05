`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/19 15:43:18
// Design Name: 
// Module Name: vga_clk
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


module vga_clk(
    clk,
    clk1, 
    clk19,
    clk22
);
    input clk;
    output clk1;
    output clk19;
    output clk22;
    reg [20:0] num;
    wire [20:0] next_num;

    always @(posedge clk) 
    begin
        num <= next_num;
    end

    assign next_num = num + 1'b1;
    assign clk1 = num[1];
    assign clk19 = num[17];
    assign clk22 = num[19];
endmodule

