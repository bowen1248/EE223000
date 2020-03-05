`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/19 15:39:22
// Design Name: 
// Module Name: speaker_ctrl
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


module speaker_ctrl(
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin,
    audio_left,
    audio_right,
    clk,
    rst_n
    );
    input clk;
    input rst_n;
    input [15:0]audio_left, audio_right;
    output audio_mclk;
    output audio_lrck;
    output audio_sck;

    output reg audio_sdin;
    reg [8:0] cnt;
    wire [8:0] next_cnt;
    
    assign audio_mclk = cnt[1];
    assign audio_sck = cnt[3];
    assign audio_lrck = cnt[8];
    
    always @(posedge clk or posedge rst_n)
    begin
        if(rst_n)
        begin
            cnt <= 9'd0;
        end
        else
        begin
            cnt <= next_cnt;
        end
    end
    
    assign next_cnt = cnt + 9'd1;

    always @*
    begin
        case(cnt[8:4])
            5'd0: audio_sdin = audio_right[0];
            5'd1: audio_sdin = audio_left[15];
            5'd2: audio_sdin = audio_left[14];
            5'd3: audio_sdin = audio_left[13];
            5'd4: audio_sdin = audio_left[12];
            5'd5: audio_sdin = audio_left[11];
            5'd6: audio_sdin = audio_left[10];
            5'd7: audio_sdin = audio_left[9];
            5'd8: audio_sdin = audio_left[8];
            5'd9: audio_sdin = audio_left[7];
            5'd10: audio_sdin = audio_left[6];
            5'd11: audio_sdin = audio_left[5];
            5'd12: audio_sdin = audio_left[4];
            5'd13: audio_sdin = audio_left[3];
            5'd14: audio_sdin = audio_left[2];
            5'd15: audio_sdin = audio_left[1];
            5'd16: audio_sdin = audio_left[0];
            5'd17: audio_sdin = audio_right[15];
            5'd18: audio_sdin = audio_right[14];
            5'd19: audio_sdin = audio_right[13];
            5'd20: audio_sdin = audio_right[12];
            5'd21: audio_sdin = audio_right[11];
            5'd22: audio_sdin = audio_right[10];
            5'd23: audio_sdin = audio_right[9];
            5'd24: audio_sdin = audio_right[8];
            5'd25: audio_sdin = audio_right[7];
            5'd26: audio_sdin = audio_right[6];
            5'd27: audio_sdin = audio_right[5];
            5'd28: audio_sdin = audio_right[4];
            5'd29: audio_sdin = audio_right[3];
            5'd30: audio_sdin = audio_right[2];
            5'd31: audio_sdin = audio_right[1];
            default: audio_sdin = 1'b0;
        endcase
    end

endmodule
