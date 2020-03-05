`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/21 10:39:49
// Design Name: 
// Module Name: hit_wall_tank
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


module hit_wall_tank(
        main_position_ver,
        main_position_hor,
        sub_position_ver,
        sub_position_hor,
        tank_up_valid,
        tank_down_valid,
        tank_right_valid,
        tank_left_valid
    );
    input [9:0]main_position_ver;
    input [9:0]main_position_hor;
    input [9:0]sub_position_ver;
    input [9:0]sub_position_hor;
    output tank_up_valid;
    output tank_down_valid;
    output tank_right_valid;
    output tank_left_valid;
    reg tank_up_valid;
    reg tank_down_valid;
    reg tank_right_valid;
    reg tank_left_valid;
    wire [9:0]up_bound;
    wire [9:0]down_bound;
    wire [9:0]left_bound;
    wire [9:0]right_bound;

    assign up_bound = main_position_ver + 1;
    assign down_bound = main_position_ver + 31;
    assign left_bound = main_position_hor + 1;
    assign right_bound = main_position_hor + 31;

    always @* begin
        // up
        if (up_bound >= 76 && up_bound <= 107 && right_bound > 94 && left_bound < 357)
            tank_up_valid = 0;
        else if (up_bound >= 127 && up_bound <= 153 && right_bound > 193 && left_bound < 262)
            tank_up_valid = 0;
        else if (up_bound >= 199 && up_bound <= 226 && right_bound > 131 && left_bound < 198)
            tank_up_valid = 0;
        else if (up_bound >= 199 && up_bound <= 226 && right_bound > 253 && left_bound < 322)
            tank_up_valid = 0;
        else if (up_bound >= 305 && up_bound <= 332 && right_bound > 91 && left_bound < 353)
            tank_up_valid = 0;
        else if (up_bound >= 369 && up_bound <= 412 && right_bound > 190 && left_bound < 255)
            tank_up_valid = 0;
        else if (up_bound >= 119 && up_bound <= 284 && right_bound > 427 && left_bound < 458)
            tank_up_valid = 0;
        else if (up_bound >= 186 && up_bound <= 216 && right_bound > 410 && left_bound < 478)
            tank_up_valid = 0;
        else if (up_bound >= 79 && up_bound <= 138 && right_bound > 506 && left_bound < 572)
            tank_up_valid = 0;
        else if (up_bound >= 332 && up_bound <= 392 && right_bound > 439 && left_bound < 504)
            tank_up_valid = 0;
        else if (up_bound <= (sub_position_ver + 32) && up_bound >= sub_position_ver && right_bound > sub_position_hor && left_bound < (sub_position_hor + 32))
            tank_up_valid = 0;
        else tank_up_valid = 1;
        // down
        if (down_bound >= 76 && down_bound <= 107 && right_bound > 94 && left_bound < 357)
            tank_down_valid = 0;
        else if (down_bound >= 127 && down_bound <= 153 && right_bound > 193 && left_bound < 262)
            tank_down_valid = 0;
        else if (down_bound >= 199 && down_bound <= 226 && right_bound > 131 && left_bound < 198)
            tank_down_valid = 0;
        else if (down_bound >= 199 && down_bound <= 226 && right_bound > 253 && left_bound < 322)
            tank_down_valid = 0;
        else if (down_bound >= 305 && down_bound <= 332 && right_bound > 91 && left_bound < 353)
            tank_down_valid = 0;
        else if (down_bound >= 369 && down_bound <= 412 && right_bound > 190 && left_bound < 255)
            tank_down_valid = 0;
        else if (down_bound >= 119 && down_bound <= 284 && right_bound > 427 && left_bound < 458)
            tank_down_valid = 0;
        else if (down_bound >= 186 && down_bound <= 216 && right_bound > 410 && left_bound < 478)
            tank_down_valid = 0;
        else if (down_bound >= 79 && down_bound <= 138 && right_bound > 506 && left_bound < 572)
            tank_down_valid = 0;
        else if (down_bound >= 332 && down_bound <= 392 && right_bound > 439 && left_bound < 504)
            tank_down_valid = 0;
        else if (down_bound <= (sub_position_ver + 32) && down_bound >= sub_position_ver && right_bound > sub_position_hor && left_bound < (sub_position_hor + 32))
            tank_down_valid = 0;
        else tank_down_valid = 1;
        // left
        if (down_bound > 76 && up_bound < 107 && left_bound >= 107 && left_bound <= 357)
            tank_left_valid = 0;
        else if (down_bound > 127 && up_bound < 153 && left_bound >= 193 && left_bound <= 262)
            tank_left_valid = 0;
        else if (down_bound > 199 && up_bound < 226 && left_bound >= 131 && left_bound <= 198)
            tank_left_valid = 0;
        else if (down_bound > 199 && up_bound < 226 && left_bound >= 253 && left_bound <= 322)
            tank_left_valid = 0;
        else if (down_bound > 305 && up_bound < 332 && left_bound >= 91 && left_bound <= 353)
            tank_left_valid = 0;
        else if (down_bound > 369 && up_bound < 412 && left_bound >= 190 && left_bound <= 255)
            tank_left_valid = 0;
        else if (down_bound > 119 && up_bound < 284 && left_bound >= 427 && left_bound <= 458)
            tank_left_valid = 0;
        else if (down_bound > 186 && up_bound < 216 && left_bound >= 410 && left_bound <= 478)
            tank_left_valid = 0;
        else if (down_bound > 79 && up_bound < 138 && left_bound >= 506 && left_bound <= 572)
            tank_left_valid = 0;
        else if (down_bound > 332 && up_bound < 392 && left_bound >= 439 && left_bound <= 504)
            tank_left_valid = 0;
        else if (up_bound < (sub_position_ver + 32) && down_bound > sub_position_ver && left_bound >= sub_position_hor && left_bound <= (sub_position_hor + 32))
            tank_left_valid = 0;
        else tank_left_valid = 1;
        // right
        if (down_bound > 76 && up_bound < 107 && right_bound >= 94 && right_bound <= 357)
            tank_right_valid = 0;
        else if (down_bound > 127 && up_bound < 153 && right_bound >= 193 && right_bound <= 262)
            tank_right_valid = 0;
        else if (down_bound > 199 && up_bound < 226 && right_bound >= 131 && right_bound <= 198)
            tank_right_valid = 0;
        else if (down_bound > 199 && up_bound < 226 && right_bound >= 253 && right_bound <= 322)
            tank_right_valid = 0;
        else if (down_bound > 305 && up_bound < 332 && right_bound >= 91 && right_bound <= 353)
            tank_right_valid = 0;
        else if (down_bound > 369 && up_bound < 412 && right_bound >= 190 && right_bound <= 255)
            tank_right_valid = 0;
        else if (down_bound > 119 && up_bound < 284 && right_bound >= 427 && right_bound <= 458)
            tank_right_valid = 0;
        else if (down_bound > 186 && up_bound < 216 && right_bound >= 410 && right_bound <= 478)
            tank_right_valid = 0;
        else if (down_bound > 79 && up_bound < 138 && right_bound >= 506 && right_bound <= 572)
            tank_right_valid = 0;
        else if (down_bound > 332 && up_bound < 392 && right_bound >= 439 && right_bound <= 504)
            tank_right_valid = 0;
        else if (up_bound < (sub_position_ver + 32) && down_bound > sub_position_ver && right_bound >= sub_position_hor && right_bound <= (sub_position_hor + 32))
            tank_right_valid = 0;
        else tank_right_valid = 1;
    end

endmodule