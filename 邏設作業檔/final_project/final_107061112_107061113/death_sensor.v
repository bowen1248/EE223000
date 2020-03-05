`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 14:18:28
// Design Name: 
// Module Name: death_sensor
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


`define STATE_ALIVE   1'b0
`define STATE_DEAD    1'b1
`define UP      2'b00
`define DOWN    2'b01
`define RIGHT   2'b10
`define LEFT    2'b11
module death_sensor(
    clk_19,
    rst,
    position_p1_ver,
    position_p1_hor,
    position_p2_ver,
    position_p2_hor,
    p1_bul_direction,
    position_p1_bul_ver,
    position_p1_bul_hor,
    p2_bul_direction,
    position_p2_bul_ver,
    position_p2_bul_hor,
    p1_score,
    p2_score,
    p1_death,
    p2_death,
    restart_map
    );
    input clk_19;
    input rst;
    input [9:0]position_p1_ver;
    input [9:0]position_p1_hor;
    input [9:0]position_p2_ver;
    input [9:0]position_p2_hor;
    input [1:0]p1_bul_direction;
    input [9:0]position_p1_bul_ver;
    input [9:0]position_p1_bul_hor;
    input [1:0]p2_bul_direction;
    input [9:0]position_p2_bul_ver;
    input [9:0]position_p2_bul_hor;
    output reg p1_death;    // state of p1
    output reg p2_death;    // state of p2
    output reg [8:0]p1_score;   // score of p1
    output reg [8:0]p2_score;   // score of p2
    input restart_map;     // determine whether the map will stop or not
    reg restart_map_next;
    reg [9:0]p1_up_bound;
    reg [9:0]p1_down_bound;
    reg [9:0]p1_left_bound;
    reg [9:0]p1_right_bound;
    reg [9:0]p2_up_bound;
    reg [9:0]p2_down_bound;
    reg [9:0]p2_left_bound;
    reg [9:0]p2_right_bound;
    reg [9:0]p1_bul_up_bound;
    reg [9:0]p1_bul_down_bound;
    reg [9:0]p1_bul_left_bound;
    reg [9:0]p1_bul_right_bound;
    reg [9:0]p2_bul_up_bound;
    reg [9:0]p2_bul_down_bound;
    reg [9:0]p2_bul_left_bound;
    reg [9:0]p2_bul_right_bound;
    reg [8:0]time_pause;        // deterine the counter will stop or not
    reg [8:0]time_pause_next;
    reg p1_score_pulse;
    reg p2_score_pulse;
    reg [8:0]p1_score_next;
    reg [8:0]p2_score_next;
    reg p1_death_next;
    reg p2_death_next;
    always @*
        if (p1_bul_direction == `UP || p1_bul_direction == `DOWN) begin
            p1_bul_up_bound = position_p1_bul_ver;
            p1_bul_down_bound = position_p1_bul_ver + 14;
            p1_bul_left_bound = position_p1_bul_hor;
            p1_bul_right_bound = position_p1_bul_hor + 7;
        end
        else begin
            p1_bul_up_bound = position_p1_bul_ver;
            p1_bul_down_bound = position_p1_bul_ver + 7;
            p1_bul_left_bound = position_p1_bul_hor;
            p1_bul_right_bound = position_p1_bul_hor + 14;
        end
    always @*
        if (p2_bul_direction == `UP || p2_bul_direction == `DOWN) begin
            p2_bul_up_bound = position_p2_bul_ver;
            p2_bul_down_bound = position_p2_bul_ver + 14;
            p2_bul_left_bound = position_p2_bul_hor;
            p2_bul_right_bound = position_p2_bul_hor + 7;
        end
        else begin
            p2_bul_up_bound = position_p2_bul_ver;
            p2_bul_down_bound = position_p2_bul_ver + 7;
            p2_bul_left_bound = position_p2_bul_hor;
            p2_bul_right_bound = position_p2_bul_hor + 14;
        end
    always @* begin
        p1_up_bound = position_p1_ver + 1;
        p1_down_bound = position_p1_ver + 31;
        p1_left_bound = position_p1_hor + 1;
        p1_right_bound = position_p1_hor + 31;
        p2_up_bound = position_p2_ver + 1;
        p2_down_bound = position_p2_ver + 31;
        p2_left_bound = position_p2_hor + 1;
        p2_right_bound = position_p2_hor + 31;
    end
    
    always @*
        if (p1_death == `STATE_ALIVE && p2_death == `STATE_ALIVE) begin
                if (p2_bul_up_bound < (position_p1_ver + 30) && p2_bul_down_bound > (position_p1_ver + 2) 
                    && p2_bul_right_bound > (position_p1_hor + 2) && p2_bul_left_bound < (position_p1_hor + 30)) begin
                    p1_score_pulse = 0;
                    p2_score_pulse = 1;
                    p1_death_next = `STATE_DEAD;
                    p2_death_next = `STATE_ALIVE;
                end
                else if (p1_bul_up_bound < (position_p2_ver + 30) && p1_bul_down_bound > (position_p2_ver + 2) 
                     && p1_bul_right_bound > (position_p2_hor + 2) && p1_bul_left_bound < (position_p2_hor + 30)) begin
                    p1_score_pulse = 1;
                    p2_score_pulse = 0;
                    p1_death_next = `STATE_ALIVE;
                    p2_death_next = `STATE_DEAD;
                end
                else begin
                    p1_score_pulse = 0;
                    p2_score_pulse = 0;
                    p1_death_next = `STATE_ALIVE;
                    p2_death_next = `STATE_ALIVE;
                end
            end
            // one dead the other alive
            else if (p1_death == `STATE_DEAD && p2_death == `STATE_ALIVE) begin
                p1_score_pulse = 0;
                p2_score_pulse = 0;
                p1_death_next = `STATE_DEAD;
                p2_death_next = `STATE_ALIVE;
            end
            else if (p1_death == `STATE_ALIVE && p2_death == `STATE_DEAD) begin
                p1_score_pulse = 0;
                p2_score_pulse = 0;
                p1_death_next = `STATE_ALIVE;
                p2_death_next = `STATE_DEAD;
            end
            else 
            begin
                p1_score_pulse = 0;
                p2_score_pulse = 0;
                p1_death_next = `STATE_DEAD;
                p2_death_next = `STATE_DEAD;
            end
        // who is dead flip flops
        always @(posedge clk_19 or posedge rst or posedge restart_map)
            if (rst || restart_map) begin
                p1_death <= `STATE_ALIVE;
                p2_death <= `STATE_ALIVE;
            end
            else begin
                p1_death <= p1_death_next;
                p2_death <= p2_death_next;
            end
        // score logics
        // calculating the score, determining tanks state
        always @*
            if (p2_score_pulse)       // calculating the score
            begin
                p1_score_next = p1_score;
                p2_score_next = p2_score + 1;
            end
            else if (p1_score_pulse)
            begin
                p1_score_next = p1_score + 1;
                p2_score_next = p2_score;
            end
            else begin
                p1_score_next = p1_score;
                p2_score_next = p2_score;
            end
        // score flips flops
        always @(posedge clk_19 or posedge rst)
            if (rst) begin
                p1_score <= 0;
                p2_score <= 0;
            end
            else begin
                p1_score <= p1_score_next;
                p2_score <= p2_score_next;
            end
    /*
    // restart map logic
    always @*
        if (p1_death || p2_death)
            restart_map_next = 1;
        else begin
            restart_map_next = 0;
        end
    always @(posedge clk_19 or posedge rst)
        if (rst)
            restart_map <= 0;
        else 
            restart_map <= restart_map_next; */
endmodule
