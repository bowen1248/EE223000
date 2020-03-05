`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 19:27:01
// Design Name: 
// Module Name: game_play_fsm
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
`define STATE_START_INTERFACE   2'b00
`define STATE_GAME_START        2'b01
`define STATE_GAME_PAUSE        2'b10
`define STATE_GAME_STOP         2'b11
module game_play_fsm(
    input clk_100MHZ,
    input clk_20HZ,
    input rst,
    input p1_death,
    input p2_death,
    input start_en,
    input stop,
    output reg start_sound_en,
    output reg count_en,
    output reg end_en,
    output reg death_en,
    output reg map_reset,
    output reg [1:0]state
);
    reg [1:0]next_state;
    reg [5:0] death_cnt, death_cnt_next;
    always @*
        case(state)
            `STATE_START_INTERFACE: 
            begin
                if (start_en == 1'b1)
                begin
                    death_cnt_next = death_cnt;
                    count_en = 1'b1;
                    end_en = 1'b0;
                    death_en = 1'b0;
                    start_sound_en = 1'b0;
                    map_reset = 1'b0;
                    next_state = `STATE_GAME_START;
                end
                else
                begin
                    death_cnt_next = death_cnt;
                    count_en = 1'b0;
                    end_en = 1'b0;
                    death_en = 1'b0;
                    map_reset = 1'b0;
                    start_sound_en = 1'b1;
                    next_state = `STATE_START_INTERFACE;
                end
            end
            `STATE_GAME_START:
            begin   
                if (p1_death == `STATE_DEAD || p2_death == `STATE_DEAD)
                begin
                    death_cnt_next = 6'b0;
                    count_en = 1'b0;
                    end_en = 1'b0;
                    death_en = 1'b1;
                    map_reset = 1'b0;
                    start_sound_en = 1'b0;
                    next_state = `STATE_GAME_PAUSE;
                end
                else if (stop)
                begin
                    death_cnt_next = 6'b0;
                    count_en = 1'b0;
                    end_en = 1'b1;
                    death_en = 1'b0;
                    map_reset = 1'b0;
                    start_sound_en = 1'b0;
                    next_state = `STATE_GAME_STOP;
                end
                else
                begin
                    death_cnt_next = 6'b0;
                    count_en = 1'b1;
                    end_en = 1'b0;
                    death_en = 1'b0;
                    map_reset = 1'b0;
                    start_sound_en = 1'b0;
                    next_state = `STATE_GAME_START;
                end
            end
            `STATE_GAME_PAUSE:
            begin
                if (death_cnt == 6'd44)
                begin
                    death_cnt_next = 6'd0;
                    count_en = 1'b1;
                    end_en = 1'b0;
                    death_en = 1'b0;
                    map_reset = 1'b1;
                    start_sound_en = 1'b0;
                    next_state = `STATE_GAME_START;
                end
                else if (stop)
                begin
                    death_cnt_next = 6'd0;
                    count_en = 1'b0;
                    end_en = 1'b1;
                    death_en = 1'b0;
                    map_reset = 1'b0;
                    start_sound_en = 1'b0;
                    next_state = `STATE_GAME_STOP;
                end
                else 
                begin
                    death_cnt_next = death_cnt + 6'b1;
                    count_en = 1'b0;
                    end_en = 1'b0;
                    death_en = 1'b1;
                    map_reset = 1'b0;
                    start_sound_en = 1'b0;
                    next_state = `STATE_GAME_PAUSE;
                end
            end
            `STATE_GAME_STOP:
            begin
                death_cnt_next = 6'b0;
                count_en = 1'b0;
                end_en = 1'b1;
                death_en = 1'b0;
                map_reset = 1'b0;
                start_sound_en = 1'b0;
                next_state = `STATE_GAME_STOP;
            end   
            default:
            begin
                death_cnt_next = 6'b0;
                count_en = 1'b0;
                end_en = 1'b0;
                death_en = 1'b0;
                start_sound_en = 1'b0;
                map_reset = 1'b0;
            end
        endcase

    always @(posedge clk_100MHZ or posedge rst)
        if(rst)
            state <= `STATE_START_INTERFACE;
        else
            state <= next_state;
    always @(posedge clk_20HZ or posedge rst)
        if (rst)
            death_cnt <= 2'b0;
        else
            death_cnt <= death_cnt_next;
endmodule
