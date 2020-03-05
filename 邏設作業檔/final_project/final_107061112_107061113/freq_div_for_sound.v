`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/21 19:31:43
// Design Name: 
// Module Name: freq_div_for_sound
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

`define FREQ_DIV_BIT 26
module freq_div_for_sound(
    clk_out,    // output clock
    clk,    // crystal clock
    rst_n   // low active reset
    );

    output clk_out;
    input clk;
    input rst_n;

    reg clk_out;
    reg clk_out_tmp;    // t-ff, toggle
    reg [21:0]cnt_tmp;
    reg [21:0]cnt;

    // Combinational Logic
    always @*
    if (cnt == 22'd2499999)
    begin
        cnt_tmp = 22'd0;
        clk_out_tmp = ~clk_out;
    end
    else
    begin
        cnt_tmp = cnt + 1;
        clk_out_tmp = clk_out;
    end

    // Sequential Logic
    always @(posedge clk or posedge rst_n)
    if (rst_n)
    begin
        cnt <= 22'b0;
        clk_out <= 1'b0;
    end
    else
    begin
        cnt <= cnt_tmp;
        clk_out <= clk_out_tmp;
    end
endmodule