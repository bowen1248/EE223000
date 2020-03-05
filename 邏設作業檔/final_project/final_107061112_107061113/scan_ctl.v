`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 15:51:45
// Design Name: 
// Module Name: scan_ctl
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


module scan_ctl(
    in0, 
    in1, 
    in2, 
    in3,
    intossd, 
    lightctl,
    sel
);
output reg [3:0]intossd; // this will later go in the ssd
output reg [3:0]lightctl; // control which light
input [1:0]sel;   // scan clock ctl
input [3:0]in0, in1, in2, in3;  // attached to q's


always @*
    case(sel)
        2'b00:
        begin
            lightctl = 4'b1110; // low active
            intossd = in0;
        end
        2'b01:
        begin
            lightctl = 4'b1101;
            intossd = in1;
        end
        2'b10:
        begin
            lightctl = 4'b1011;
            intossd = in2;
        end
        2'b11:
        begin
            lightctl = 4'b0111; // low active
            intossd = in3;
        end
        default:
        begin
            lightctl = 4'b1111;
            intossd = 4'b0;
        end
    endcase
endmodule