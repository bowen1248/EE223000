`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/23 09:54:14
// Design Name: 
// Module Name: one_pulse
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

module one_pulse(
    clk, // clock input
    rst_n, // active low reset
    in_trig, // input trigger
    out_pulse // output one pulse
);

    input clk;
    input rst_n;
    input in_trig;

    output out_pulse;
    reg out_pulse;

    // Declare internal nodes
    reg in_trig_delay;
    reg one_pulse_next;

    //Buffer input, to generate a delay signal
    always @(posedge clk or posedge rst_n)
        if (rst_n)
            in_trig_delay <= 0;
        else
            in_trig_delay <= in_trig;

    // generate one pulse
    always @*
        one_pulse_next = in_trig & (~in_trig_delay);

    always @(posedge clk or posedge rst_n)
        if (rst_n)
            out_pulse <= 0;
        else 
            out_pulse <= one_pulse_next;
endmodule