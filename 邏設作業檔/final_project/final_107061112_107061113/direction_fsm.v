`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/20 10:30:07
// Design Name: 
// Module Name: direction_fsm
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

`include "global.v"
`define UP      2'b00
`define DOWN    2'b01
`define RIGHT   2'b10
`define LEFT    2'b11

module direction_fsm(
    clk,
    rst,
    key_down,
    p1_dir,         // player 1 direction
    p2_dir         // player 2 direction
);
    input clk;
    input rst;
    input [511:0]key_down;
    output reg [1:0]p1_dir, p2_dir;
    
    reg [1:0]p1_dir_next, p2_dir_next;
    // player 1
    always @*
        if (key_down[`KEY_UP])
            p1_dir_next = `UP;
        else if (key_down[`KEY_DOWN])
            p1_dir_next = `DOWN;
        else if (key_down[`KEY_LEFT])
            p1_dir_next = `LEFT;
        else if (key_down[`KEY_RIGHT])
            p1_dir_next = `RIGHT;
        else
            p1_dir_next = p1_dir;
    // player 2
    always @*
        if (key_down[`KEY_W])
            p2_dir_next = `UP;
        else if (key_down[`KEY_S])
            p2_dir_next = `DOWN;
        else if (key_down[`KEY_A])
            p2_dir_next = `LEFT;
        else if (key_down[`KEY_D])
            p2_dir_next = `RIGHT;
        else
            p2_dir_next = p2_dir;

    always @(posedge clk or negedge rst)
        if (rst)
        begin
            p1_dir <= `UP;
            p2_dir <= `UP; 
        end
        else
        begin
            p1_dir <= p1_dir_next;
            p2_dir <= p2_dir_next;
        end
endmodule
