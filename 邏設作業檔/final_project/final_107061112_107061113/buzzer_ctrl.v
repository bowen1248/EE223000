`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/19 15:39:22
// Design Name: 
// Module Name: buzzer_ctrl
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


module buzzer_ctrl(
    clk, // clock from crystal
    rst_n, // active low reset
    note_div, // div for note generation
    audio //sound audio
);
// I/O declaration
input clk; // clock from crystal
input rst_n; // active low reset
input [21:0] note_div; // div for note generation

output [15:0] audio; // sound audio

// Declare internal signals
reg [21:0]clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next;
// Note frequency generation
always @(posedge clk or posedge rst_n)
    if (rst_n)
    begin
        clk_cnt <= 22'd0;
        b_clk <= 1'b0;
    end
    else
    begin
        clk_cnt <= clk_cnt_next;
        b_clk <= b_clk_next;
    end
always @*
    if (clk_cnt == note_div)
    begin
        clk_cnt_next = 22'd0;
        b_clk_next = ~b_clk;
    end
    else
    begin
        clk_cnt_next = clk_cnt + 1'b1;
        b_clk_next = b_clk;
    end
// Assign the amplitude of the note
assign audio = (b_clk == 1'b0) ? 16'hF000 : 16'h1000;

endmodule