`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/21 10:39:49
// Design Name: 
// Module Name: hit_wall_bullet
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

`define UP      2'b00
`define DOWN    2'b01
`define RIGHT   2'b10
`define LEFT    2'b11
module hit_wall_bullet(
    enemy_position_ver,
    enemy_position_hor,
    bul_direction,
    position_ver,
    position_hor,
    bullet_valid
    );

    input [1:0]bul_direction;
    input [9:0]position_ver;
    input [9:0]position_hor;
    input [9:0]enemy_position_ver;
    input [9:0]enemy_position_hor;
    output bullet_valid;
    reg bullet_valid;
    reg [9:0]up_bound;
    reg [9:0]down_bound;
    reg [9:0]left_bound;
    reg [9:0]right_bound;

    always @*
        if (bul_direction == `UP || bul_direction == `DOWN) begin
            up_bound = position_ver;
            down_bound = position_ver + 14;
            left_bound = position_hor;
            right_bound = position_hor + 7;
        end
        else begin
            up_bound = position_ver;
            down_bound = position_ver + 7;
            left_bound = position_hor;
            right_bound = position_hor + 14;
        end
    
        always @* 
            if (down_bound >= 76 && up_bound <= 107 && right_bound >= 94 && left_bound <= 357)
                bullet_valid = 0;
        	else if (down_bound >= 127 && up_bound <= 153 && right_bound >= 193 && left_bound <= 262)
                bullet_valid = 0;
            else if (down_bound >= 199 && up_bound <= 226 && right_bound >= 131 && left_bound <= 198)
                bullet_valid = 0;
            else if (down_bound >= 199 && up_bound <= 226 && right_bound >= 253 && left_bound <= 322)
                bullet_valid = 0;
            else if (down_bound >= 305 && up_bound <= 332 && right_bound >= 91 && left_bound <= 353)
                bullet_valid = 0;
            else if (down_bound >= 369 && up_bound <= 412 && right_bound >= 190 && left_bound <= 255)
                bullet_valid = 0;
            else if (down_bound >= 119 && up_bound <= 284 && right_bound >= 427 && left_bound <= 458)
                bullet_valid = 0;
            else if (down_bound >= 186 && up_bound <= 216 && right_bound >= 410 && left_bound <= 478)
                bullet_valid = 0;
            else if (down_bound >= 79 && up_bound <= 138 && right_bound >= 506 && left_bound <= 572)
                bullet_valid = 0;
            else if (down_bound >= 332 && up_bound <= 392 && right_bound >= 439 && left_bound <= 504)
                bullet_valid = 0;
            else if (up_bound < (enemy_position_ver + 30) && down_bound > (enemy_position_ver + 2) && right_bound > (enemy_position_hor + 2) && left_bound < (enemy_position_hor + 30))
                bullet_valid = 0;
            else bullet_valid = 1;
endmodule
