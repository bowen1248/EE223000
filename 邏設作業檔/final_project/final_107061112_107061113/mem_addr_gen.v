`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/19 15:39:22
// Design Name: 
// Module Name: mem_addr_gen
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
`define STATE_START_INTERFACE   2'b00
`define STATE_GAME_START        2'b01
`define STATE_GAME_PAUSE        2'b10
`define STATE_GAME_STOP         2'b11
module mem_addr_gen(
    key_down,           // keyboard key_down input
    h_cnt,              // vga
    v_cnt,
    clk_19,             // different clock speed
    clk_22,
    rst,
    pixel_addr,
    p1_dir,             // player 1
    p2_dir,
    p1_score,
    p2_score,
    restart_map,
    p1_death,
    p2_death,
    state               // gameplay fsm state
);
    input clk_19;      // speed for bullet
    input clk_22;      // speed for tank
    input rst;
    input [511:0]key_down;
    input [9:0]v_cnt, h_cnt;
    input [1:0]p1_dir, p2_dir;                          // player 1 and player 2 current orientation
    input [1:0]state;                                   // gameplay current state
    output reg [16:0]pixel_addr;
    output [8:0]p1_score, p2_score;
    reg [9:0]position_p1_hor, position_p1_hor_next;     // player 1 tank horizontal position
    reg [9:0]position_p1_ver, position_p1_ver_next;     // player 1 tank vertical position
    reg [9:0]position_p2_hor, position_p2_hor_next;     // player 2 tank horizontal position
    reg [9:0]position_p2_ver, position_p2_ver_next;     // player 2 tank vertical position
    wire p1_tank_up_valid, p2_tank_up_valid;             // player tank move up
    wire p1_tank_down_valid, p2_tank_down_valid;         // player tank move down
    wire p1_tank_right_valid, p2_tank_left_valid;
    wire p1_tank_left_valid, p2_tank_right_valid;
    // bullets
    reg p1_bullet_en, p2_bullet_en;                     // activating the bullets for player 1 and 2
    reg p1_bullet_en_next, p2_bullet_en_next;
    wire p1_bullet_valid, p2_bullet_valid;
    // bullet positions
    reg [9:0]position_p1_bul_hor, position_p2_bul_hor;  
    reg [9:0]position_p1_bul_ver, position_p2_bul_ver;
    reg [9:0]position_p1_bul_hor_next, position_p2_bul_hor_next;
    reg [9:0]position_p1_bul_ver_next, position_p2_bul_ver_next;
    reg [1:0]p1_bul_direction, p1_bul_direction_next;                               // bullet direction
    reg [1:0]p2_bul_direction, p2_bul_direction_next;                               // bullet direction
    // tank death
    output p1_death, p2_death;
    // restart map
    input restart_map;
    // start screen control
    wire [9:0]h_cnt_small;
    wire [8:0]v_cnt_small;
    reg select_icon_state,select_icon_state_next;

    assign h_cnt_small = (h_cnt >> 1);
    assign v_cnt_small = (v_cnt >> 1);
    hit_wall_tank p1_move (
        .main_position_ver(position_p1_ver),
        .main_position_hor(position_p1_hor),
        .sub_position_ver(position_p2_ver),
        .sub_position_hor(position_p2_hor),
        .tank_up_valid(p1_tank_up_valid),
        .tank_down_valid(p1_tank_down_valid),
        .tank_right_valid(p1_tank_right_valid),
        .tank_left_valid(p1_tank_left_valid)
    );
    hit_wall_tank p2_move (
        .main_position_ver(position_p2_ver),
        .main_position_hor(position_p2_hor),
        .sub_position_ver(position_p1_ver),
        .sub_position_hor(position_p1_hor),
        .tank_up_valid(p2_tank_up_valid),
        .tank_down_valid(p2_tank_down_valid),
        .tank_right_valid(p2_tank_right_valid),
        .tank_left_valid(p2_tank_left_valid)
    );
    hit_wall_bullet p1_bullet (
        .bul_direction(p1_bul_direction),
        .position_ver(position_p1_bul_ver),
        .position_hor(position_p1_bul_hor),
        .enemy_position_ver(position_p2_ver),
        .enemy_position_hor(position_p2_hor),
        .bullet_valid(p1_bullet_valid)
    );
    hit_wall_bullet p2_bullet (
        .bul_direction(p2_bul_direction),
        .position_ver(position_p2_bul_ver),
        .position_hor(position_p2_bul_hor),
        .enemy_position_ver(position_p1_ver),
        .enemy_position_hor(position_p1_hor),
        .bullet_valid(p2_bullet_valid)
    );
    death_sensor death_player (
        .clk_19(clk_19),
        .rst(rst),
        .position_p1_ver(position_p1_ver),
        .position_p1_hor(position_p1_hor),
        .position_p2_ver(position_p2_ver),
        .position_p2_hor(position_p2_hor),
        .p1_bul_direction(p1_bul_direction),
        .p2_bul_direction(p2_bul_direction),
        .position_p1_bul_ver(position_p1_bul_ver),
        .position_p1_bul_hor(position_p1_bul_hor),
        .position_p2_bul_ver(position_p2_bul_ver),
        .position_p2_bul_hor(position_p2_bul_hor),
        .p1_score(p1_score),
        .p2_score(p2_score),
        .p1_death(p1_death),
        .p2_death(p2_death),
        .restart_map(restart_map)
    );

    // FSM panel icon selection
    always @*
        if (key_down[26])
            select_icon_state_next = 1'd0;
        else if (key_down[34]) select_icon_state_next = 1'd1;
        else select_icon_state_next = select_icon_state;
    always @(posedge clk_19 or posedge rst)
        if (rst) select_icon_state <= 1'd0;
        else select_icon_state <= select_icon_state_next;

    always @*
        if (state == `STATE_START_INTERFACE)
        begin
            if (h_cnt_small >= 79 && h_cnt_small < 232                  // battle tank
                && v_cnt_small >= 40 && v_cnt_small < 111)
                    pixel_addr = (v_cnt_small - 40 + 272) * 382 + (h_cnt_small - 79);
            else if (h_cnt_small >= 128 && h_cnt_small < 187           // player
                    && v_cnt_small >= 136 && v_cnt_small < 162)
                    pixel_addr = (v_cnt_small - 136 + 317) * 382 + (h_cnt_small - 128 + 153);
            else if (h_cnt_small >= 96 && h_cnt_small < 217        // name
                    && v_cnt_small >= 188 && v_cnt_small < 231)
                    pixel_addr = (v_cnt_small - 188 + 272) * 382 + (h_cnt_small - 96 + 153);
            else if (h_cnt_small >= 113 && h_cnt_small < 126        // small tank
                    && v_cnt_small >= 134 && v_cnt_small < 150 && ~select_icon_state) 
                        pixel_addr = (v_cnt_small - 134 + 317) * 382 + (h_cnt_small - 113 + 213);
            else if (h_cnt_small >= 113 && h_cnt_small < 126        // small tank
                    && v_cnt_small >= 151 && v_cnt_small < 167 && select_icon_state) 
                        pixel_addr = (v_cnt_small - 151 + 317) * 382 + (h_cnt_small - 113 + 213);
            else if (h_cnt_small >= 232 && h_cnt_small < 315        // credit
                    && v_cnt_small >= 179 && v_cnt_small < 233)
                    pixel_addr = (v_cnt_small - 179 + 272) * 382 + (h_cnt_small - 232 + 274);
            else pixel_addr = 338 * 382 + 3;
        end
        else if (state == `STATE_GAME_STOP)
        begin
            if (v_cnt >= 20 && v_cnt < 260 && h_cnt >= 200 && h_cnt < 440)
                pixel_addr = ((v_cnt >> 2) - 5 + 32) * 382 + (h_cnt  >> 2) - 50 + 320;
            else if (v_cnt >= 320 && v_cnt < 448 && h_cnt >= 256 && h_cnt < 384)
            begin
                if (p1_score < p2_score)
                    pixel_addr = ((v_cnt >> 2) - 80 ) * 382 + (h_cnt  >> 2) - 64 + 160;
                else if (p2_score < p1_score)
                    pixel_addr = ((v_cnt >> 2) - 80 ) * 382 + (h_cnt  >> 2) - 64 + 96;
                else
                    pixel_addr = 17'b0;
            end
            else
                pixel_addr = 17'b0;
        end
        // player 1 displaying
        else if (h_cnt > position_p1_hor && h_cnt < position_p1_hor + 32 
            && v_cnt > position_p1_ver && v_cnt < position_p1_ver + 32)
        begin  
            if (p1_death)
                pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor) + 256;
            else if (key_down[`KEY_UP])
                pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor) + 64;
            else if (key_down[`KEY_DOWN])
                pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor);
            else if (key_down[`KEY_LEFT])
                pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor) + 32;
            else if (key_down[`KEY_RIGHT])
                pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor) + 96;
            else 
            begin
                if (p1_dir == `UP)
                    pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor) + 64;
                else if (p1_dir == `DOWN)
                     pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor);
                else if (p1_dir == `LEFT)
                    pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor) + 32;
                else  
                    pixel_addr = (v_cnt - position_p1_ver) * 382 + (h_cnt - position_p1_hor) + 96;
            end
        end
        // playing 2 displaying
        else if (h_cnt > position_p2_hor && h_cnt < position_p2_hor + 32 
            && v_cnt > position_p2_ver && v_cnt < position_p2_ver + 32)
        begin   
            if (p2_death)
                pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 256;
            else if (key_down[`KEY_W])
                pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 224;
            else if (key_down[`KEY_S])
                pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 192;
            else if (key_down[`KEY_A])
                pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 128;
            else if (key_down[`KEY_D])
                pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 160;
            else
            begin
                if (p2_dir == `UP)
                    pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 224;
                else if (p2_dir == `DOWN)
                    pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 192;
                else if (p2_dir == `LEFT)
                    pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 128;
                else  
                    pixel_addr = (v_cnt - position_p2_ver) * 382 + (h_cnt - position_p2_hor) + 160;
            end
        end
        // p1 bullet displaying
        else if ((p1_bul_direction == `UP || p1_bul_direction == `DOWN) && p1_bullet_en &&
                h_cnt > position_p1_bul_hor && h_cnt < position_p1_bul_hor + 8 &&
                v_cnt > position_p1_bul_ver && v_cnt < position_p1_bul_ver + 15)
        begin
            if (p1_bul_direction == `UP)
                pixel_addr = (v_cnt - position_p1_bul_ver) * 382 + (h_cnt - position_p1_bul_hor) + 326;
            else
                pixel_addr = (v_cnt - position_p1_bul_ver) * 382 + (h_cnt - position_p1_bul_hor) + 303;
        end
        else if ((p1_bul_direction == `LEFT || p1_bul_direction == `RIGHT) && p1_bullet_en &&
                h_cnt > position_p1_bul_hor && h_cnt < position_p1_bul_hor + 15 &&
                v_cnt > position_p1_bul_ver && v_cnt < position_p1_bul_ver + 8)
        begin
            if (p1_bul_direction == `LEFT)
                pixel_addr = (v_cnt - position_p1_bul_ver) * 382 + (h_cnt- position_p1_bul_hor) + 311;
            else 
                pixel_addr = (v_cnt - position_p1_bul_ver) * 382 + (h_cnt- position_p1_bul_hor) + 288;
        end
        // p2 bullet displaying
        else if ((p2_bul_direction == `UP || p2_bul_direction == `DOWN) && p2_bullet_en &&
                h_cnt > position_p2_bul_hor && h_cnt < position_p2_bul_hor + 8 &&
                v_cnt > position_p2_bul_ver && v_cnt < position_p2_bul_ver + 15)
        begin
            if (p2_bul_direction == `UP)
                pixel_addr = (v_cnt - position_p2_bul_ver) * 382 + (h_cnt - position_p2_bul_hor) + 326;
            else
                pixel_addr = (v_cnt - position_p2_bul_ver) * 382 + (h_cnt - position_p2_bul_hor) + 303;
        end
        else if ((p2_bul_direction == `LEFT || p2_bul_direction == `RIGHT) && p2_bullet_en &&
                h_cnt > position_p2_bul_hor && h_cnt < position_p2_bul_hor + 15 &&
                v_cnt > position_p2_bul_ver && v_cnt < position_p2_bul_ver + 8)
        begin
            if (p2_bul_direction == `LEFT)
                pixel_addr = (v_cnt - position_p2_bul_ver) * 382 + (h_cnt- position_p2_bul_hor) + 311;
            else 
                pixel_addr = (v_cnt - position_p2_bul_ver) * 382 + (h_cnt- position_p2_bul_hor) + 288;
        end
        // background displaying
        else
            pixel_addr = ((v_cnt >> 1) + 32) * 382 + (h_cnt >> 1);

    // tank position shifting
    // player 1
    always @*
        // vertical key pressed and inside the boundaries
        if (state == `STATE_GAME_PAUSE || state == `STATE_START_INTERFACE)
        begin
            position_p1_ver_next = position_p1_ver;
            position_p1_hor_next = position_p1_hor;
        end
        else if (key_down[`KEY_UP] && (position_p1_ver > 30) && p1_tank_up_valid) 
            position_p1_ver_next = position_p1_ver - 1;
        else if (key_down[`KEY_DOWN] && (position_p1_ver < 418) && p1_tank_down_valid)
            position_p1_ver_next = position_p1_ver + 1;
        // horizontal key pressed and inside the boundaries
        else if (key_down[`KEY_RIGHT] && (position_p1_hor < 578) && p1_tank_right_valid)
            position_p1_hor_next = position_p1_hor + 1;
        else if (key_down[`KEY_LEFT] && (position_p1_hor > 30) && p1_tank_left_valid)
            position_p1_hor_next = position_p1_hor - 1;
        else 
        begin
            position_p1_ver_next = position_p1_ver;
            position_p1_hor_next = position_p1_hor;
        end
    // player 2
    always @*
        // vertical key pressed and inside the boundaries
        if (state == `STATE_GAME_PAUSE || state == `STATE_START_INTERFACE)
        begin
            position_p2_ver_next = position_p2_ver;
            position_p2_hor_next = position_p2_hor;
        end
        else if (key_down[`KEY_W] && (position_p2_ver > 30) && p2_tank_up_valid) 
            position_p2_ver_next = position_p2_ver - 1;
        else if (key_down[`KEY_S] && (position_p2_ver < 418) && p2_tank_down_valid)
            position_p2_ver_next = position_p2_ver + 1;
        // horizontal key pressed and inside the boundaries
        else if (key_down[`KEY_A] && (position_p2_hor > 30) && p2_tank_left_valid)
            position_p2_hor_next = position_p2_hor - 1;
        else if (key_down[`KEY_D] && (position_p2_hor < 578) && p2_tank_right_valid)
            position_p2_hor_next = position_p2_hor + 1;
        else 
        begin
            position_p2_ver_next = position_p2_ver;
            position_p2_hor_next = position_p2_hor;
        end
    // bullet player 1 enable
    always @*
        // if the bullet hits the boundaries or walls, then enable = 0
        if (state == `STATE_GAME_PAUSE || state == `STATE_START_INTERFACE)
        begin
            p1_bullet_en_next = 1'b0;
            position_p1_bul_hor_next = 10'd0;
            position_p1_bul_ver_next = 10'd0;
        end
        else if ((position_p1_bul_hor >= 20 && position_p1_bul_hor <= 30) || position_p1_bul_hor >= 595 || (position_p1_bul_ver >= 20 && position_p1_bul_ver <= 30) || position_p1_bul_ver >= 435 || (~p1_bullet_valid))
        begin
            p1_bullet_en_next = 1'b0;
            position_p1_bul_hor_next = 10'd0;
            position_p1_bul_ver_next = 10'd0;
        end
        // if shooting key is pressed and the bullet is not enabled previously
        else if (key_down[`KEY_ENTER] && p1_bullet_en == 1'b0)
        begin
            p1_bullet_en_next = 1'b1;
            // assigning the directions respect to current orientation of the tank
            if (p1_dir == `UP)
            begin
                position_p1_bul_hor_next = position_p1_hor + 11;
                position_p1_bul_ver_next = position_p1_ver + 4;
                p1_bul_direction_next = `UP;
            end 
            else if (p1_dir == `DOWN)
            begin   
                position_p1_bul_hor_next = position_p1_hor + 11;
                position_p1_bul_ver_next = position_p1_ver + 28;
                p1_bul_direction_next = `DOWN;
            end
            else if (p1_dir == `LEFT)
            begin
                position_p1_bul_hor_next = position_p1_hor + 4;
                position_p1_bul_ver_next = position_p1_ver + 11;
                p1_bul_direction_next = `LEFT;
            end
            else 
            begin
                position_p1_bul_hor_next = position_p1_hor + 28;
                position_p1_bul_ver_next = position_p1_ver + 11;
                p1_bul_direction_next = `RIGHT;
            end
        end
        // if bullet is enabled
        else if (p1_bullet_en == 1'b1)
        begin   // if the bullet didn't hit the boundaries or walls, then the bullet will keep on shifting
                // also checking the direction foe the bullet to decide which direction to shift
            if (p1_bul_direction == `UP && (position_p1_bul_ver > 30))
            begin
                p1_bul_direction_next = p1_bul_direction;
                p1_bullet_en_next = 1'b1;
                position_p1_bul_hor_next = position_p1_bul_hor;
                position_p1_bul_ver_next = position_p1_bul_ver - 1;
            end
            else if (p1_bul_direction == `DOWN && (position_p1_bul_ver < 435))
            begin
                p1_bul_direction_next = p1_bul_direction;
                p1_bullet_en_next = 1'b1;
                position_p1_bul_hor_next = position_p1_bul_hor;
                position_p1_bul_ver_next = position_p1_bul_ver + 1;
            end
            else if (p1_bul_direction == `LEFT && position_p1_bul_hor > 30)
            begin
                p1_bul_direction_next = p1_bul_direction;
                p1_bullet_en_next = 1'b1;
                position_p1_bul_hor_next = position_p1_bul_hor - 1;
                position_p1_bul_ver_next = position_p1_bul_ver;
            end
            else if (p1_bul_direction == `RIGHT && position_p1_bul_hor < 595)
            begin
                p1_bul_direction_next = p1_bul_direction;
                p1_bullet_en_next = 1'b1;
                position_p1_bul_hor_next = position_p1_bul_hor + 1;
                position_p1_bul_ver_next = position_p1_bul_ver;
            end
            else 
            begin
                p1_bul_direction_next = p1_bul_direction;
                p1_bullet_en_next = p1_bullet_en;
                position_p1_bul_ver_next = position_p1_bul_ver;
                position_p1_bul_hor_next = position_p1_bul_hor;
            end
        end
        else
        begin
            p1_bullet_en_next = p1_bullet_en;
            position_p1_bul_hor_next = position_p1_bul_hor;
            position_p1_bul_ver_next = position_p1_bul_ver;
            p1_bul_direction_next = p1_bul_direction;
        end
    // bullet player 2 enable
    always @*
    // if the bullet hits the boundaries, then enable = 0
        if (state == `STATE_GAME_PAUSE || state == `STATE_START_INTERFACE)
        begin
            p2_bullet_en_next = 1'b0;
            position_p2_bul_hor_next = 10'd0;
            position_p2_bul_ver_next = 10'd0;
        end
        else if ((position_p2_bul_hor >= 20 && position_p2_bul_hor <= 30) || position_p2_bul_hor >= 595 || (position_p2_bul_ver >= 20 && position_p2_bul_ver <= 30) || position_p2_bul_ver >= 435 || (~p2_bullet_valid))
        begin
            p2_bullet_en_next = 1'b0;
            position_p2_bul_hor_next = 10'd0;
            position_p2_bul_ver_next = 10'd0;
        end
        // if shoooting key is pressed and the bullet is not enabled previuosly
        // assigning the directions respect to current orientation of the tank
        else if (key_down[`KEY_SPACE] && p2_bullet_en == 1'b0)
        begin
            if (p2_dir == `UP)
            begin
                position_p2_bul_hor_next = position_p2_hor + 11;
                position_p2_bul_ver_next = position_p2_ver + 4;
                p2_bul_direction_next = `UP;
                p2_bullet_en_next = 1'b1;
            end 
            else if (p2_dir == `DOWN)
            begin   
                position_p2_bul_hor_next = position_p2_hor + 11;
                position_p2_bul_ver_next = position_p2_ver + 28;
                p2_bul_direction_next = `DOWN;
                p2_bullet_en_next = 1'b1;
            end
            else if (p2_dir == `LEFT)
            begin
                position_p2_bul_hor_next = position_p2_hor + 4;
                position_p2_bul_ver_next = position_p2_ver + 11;
                p2_bul_direction_next = `LEFT;
                p2_bullet_en_next = 1'b1;
            end
            else 
            begin
                position_p2_bul_hor_next = position_p2_hor + 28;
                position_p2_bul_ver_next = position_p2_ver + 11;
                p2_bul_direction_next = `RIGHT;
                p2_bullet_en_next = 1'b1;
            end
        end
        // if the bullet didn't hit the boundaries, then the bullet will keep on shifting
        // also checking the direction foe the bullet to decide which direction to shift
        else if (p2_bullet_en == 1'b1)
        begin   
            if (p2_bul_direction == `UP && (position_p2_bul_ver > 30))
            begin
                p2_bul_direction_next = p2_bul_direction;
                p2_bullet_en_next = 1'b1;
                position_p2_bul_hor_next = position_p2_bul_hor;
                position_p2_bul_ver_next = position_p2_bul_ver - 1;
            end
            else if (p2_bul_direction == `DOWN && (position_p2_bul_ver < 435))
            begin
                p2_bul_direction_next = p2_bul_direction;
                p2_bullet_en_next = 1'b1;
                position_p2_bul_hor_next = position_p2_bul_hor;
                position_p2_bul_ver_next = position_p2_bul_ver + 1;
            end
            else if (p2_bul_direction == `LEFT && position_p2_bul_hor > 30)
            begin
                p2_bul_direction_next = p2_bul_direction;
                p2_bullet_en_next = 1'b1;
                position_p2_bul_ver_next = position_p2_bul_ver;
                position_p2_bul_hor_next = position_p2_bul_hor - 1;
            end
            else if (p2_bul_direction == `RIGHT && position_p2_bul_hor < 595)
            begin
                p2_bul_direction_next = p2_bul_direction;
                p2_bullet_en_next = 1'b1;
                position_p2_bul_ver_next = position_p2_bul_ver;
                position_p2_bul_hor_next = position_p2_bul_hor + 1;
            end
            else 
            begin
                p2_bullet_en_next = p2_bullet_en;
                p2_bul_direction_next = p2_bul_direction_next;
                position_p2_bul_ver_next = position_p2_bul_ver;
                position_p2_bul_hor_next = position_p2_bul_hor;
            end
        end
        else
        begin
            p2_bullet_en_next = p2_bullet_en;
            position_p2_bul_hor_next = position_p2_bul_hor;
            position_p2_bul_ver_next = position_p2_bul_ver;
            p2_bul_direction_next = p2_bul_direction;
        end
    // tank position flip flops
    always @(posedge clk_22 or posedge rst or posedge restart_map)
        if (rst || restart_map)
        begin
            position_p1_ver <= 10'd400;  
            position_p1_hor <= 10'd500;
            position_p2_ver <= 10'd50;
            position_p2_hor <= 10'd50;
        end
        else
        begin
            position_p1_ver <= position_p1_ver_next;
            position_p1_hor <= position_p1_hor_next;
            position_p2_ver <= position_p2_ver_next;
            position_p2_hor <= position_p2_hor_next;
        end
    // bullet position flip flops
    always @(posedge clk_19 or posedge rst or posedge restart_map)
    if (rst || restart_map)
        begin
            p1_bul_direction <= 1'b0;
            p2_bul_direction <= 1'b0;
            p1_bullet_en <= 2'b0;
            p2_bullet_en <= 2'b0;
            position_p1_bul_ver <= 10'd0;
            position_p1_bul_hor <= 10'd0;
            position_p2_bul_ver <= 10'd0;
            position_p2_bul_hor <= 10'd0;
        end
        else
        begin
            p1_bul_direction <= p1_bul_direction_next;
            p2_bul_direction <= p2_bul_direction_next;
            p1_bullet_en <= p1_bullet_en_next;
            p2_bullet_en <= p2_bullet_en_next;
            position_p1_bul_ver <= position_p1_bul_ver_next;
            position_p1_bul_hor <= position_p1_bul_hor_next;
            position_p2_bul_ver <= position_p2_bul_ver_next;
            position_p2_bul_hor <= position_p2_bul_hor_next;
        end


endmodule

