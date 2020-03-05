`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 13:52:10
// Design Name: 
// Module Name: timer
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

`define BCD_BIT_WIDTH   4
module timer(
    val0,   // value 1
    val1,   // value 2
    val2,   // value 3
    val3,   // value4
    clk,
    rst_n,
    en,  // enable / disable for the stopwatch
    stop
);
    output [`BCD_BIT_WIDTH - 1:0]val0;
    output [`BCD_BIT_WIDTH - 1:0]val1;
    output [`BCD_BIT_WIDTH - 1:0]val2;
    output [`BCD_BIT_WIDTH - 1:0]val3;
    input clk;
    input rst_n;
    input en;

    output stop;

    wire br0, br1, br2, br3;  // wire for the borrow signal of two counters
    wire decrease_enable;   // decrease signal for the lsb to start

    assign stop  = ((val0 == 0) && (val1 == 0) && (val2 == 0) && (val3 ==0));
    assign decrease_enable = 
        en && (~((val0 == 0) && (val1 == 0) && (val2 == 0) && (val3 == 0)));

    downcounter Udc2d0(
        .value(val0), 
        .borrow(br0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(decrease_enable), 
        .init_value(4'd0), 
        .limit(4'd9)
    );

    downcounter Udc2d1(
        .value(val1), 
        .borrow(br1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br0), 
        .init_value(4'd0),
        .limit(4'd5)
    );
    downcounter Udc2d2(
        .value(val2), 
        .borrow(br2), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br1), 
        .init_value(4'd2), 
        .limit(4'd3)
    );
    downcounter Udc2d3(
        .value(val3), 
        .borrow(br3), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br2), 
        .init_value(4'd0), 
        .limit(4'd0)
    );
endmodule