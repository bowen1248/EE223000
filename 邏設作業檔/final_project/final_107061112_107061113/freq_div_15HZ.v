`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/23 00:19:06
// Design Name: 
// Module Name: freq_div_15HZ
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

`define FREQ_DIV_BIT 27
module freq_div_15HZ(
    clk_out, // divided clock output
    clk_ctl, // divided clock output for scan freq
    clk, // global clock input
    rst_n // active low reset
    );
    output clk_out; // divided output
    output [1:0]clk_ctl; // divided output for scan freq
    input clk; // global clock input
    input rst_n; // active low reset
    
    reg clk_out_tmp;
    reg clk_out; // clk output (in always block)
    reg [1:0] clk_ctl; // clk output (in always block)
    reg [14:0] cnt_l; // temp buf of the counter
    reg [8:0] cnt_h; // temp buf of the counter
    reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input to dff (in always block)


// Combinational Logic
always @*
if ({cnt_h, clk_ctl, cnt_l} == 26'd3333333)
begin
    cnt_tmp = {clk_out, 26'b0};
    clk_out_tmp = ~clk_out;
end
else
begin
    cnt_tmp = {clk_out,cnt_h,clk_ctl,cnt_l} + 1'b1;
    clk_out_tmp = clk_out;
end

// Counter flip flops
always @(posedge clk or posedge rst_n)
if (rst_n)
begin
    {cnt_h,clk_ctl,cnt_l} <= 26'b0;
    clk_out <= 1'b0;
end
else
begin
    {clk_out,cnt_h,clk_ctl,cnt_l} <= cnt_tmp;
    clk_out <= clk_out_tmp;
end
endmodule
