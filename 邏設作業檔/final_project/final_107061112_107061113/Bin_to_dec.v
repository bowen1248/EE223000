`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 16:15:00
// Design Name: 
// Module Name: Bin_to_dec
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


module Bin_to_dec(
    output reg [3:0]BCD3,
    output reg [3:0]BCD2,
    output reg [3:0]BCD1,
    output reg [3:0]BCD0,
    input [8:0]ans
    );

    always @*
    begin
        BCD3 = ans / 14'd1000;
        BCD2 = (ans / 14'd100) - (BCD3 *14'd10);
        BCD1 = (ans / 14'd10) - (BCD3 * 14'd100) - (BCD2 * 14'd10);
        BCD0 = ans % 14'd10;
    end
endmodule

