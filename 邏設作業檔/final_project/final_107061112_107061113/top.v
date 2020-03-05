`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/19 15:39:22
// Design Name: 
// Module Name: top
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


module top(
    clk,
	rst,
    display,
    dis_mode,
    lightctl_out,
    vgaRed,
    vgaGreen,
    vgaBlue,
    hsync,
    vsync,
	PS2_CLK,
	PS2_DATA,    
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck,  // serial clock
    audio_sdin  // serial audio data input
);
    input clk;
    input rst;
    input dis_mode;
    // for vga display
    output [3:0] vgaRed;
    output [3:0] vgaGreen;
    output [3:0] vgaBlue;
    output hsync;
    output vsync; 
    // speaker
    output audio_mclk;  // master clock
    output audio_lrck;  // left-right clock
    output audio_sck;   // serial clock
    output audio_sdin;  // serial audio data input
    // keyboard
	inout PS2_CLK;
	inout PS2_DATA;
    // ssd
    output [7:0]display;
    output reg [3:0]lightctl_out;
    // internal node
    // keyboard
    wire key_valid;
    wire [511:0]key_down;
	wire [8:0]last_change;
    // vga
	wire [9:0]v_cnt;
	wire [9:0]h_cnt;
    wire valid;
    wire clk_25MHz;
    wire clk_22;
    wire clk_19;
    wire [16:0]pixel_addr;
	wire [11:0]data;
    wire [11:0]pixel0;
    // speaker
    wire death_en;
    wire end_en;
    wire start_sound_en;
    wire [21:0]note_in_start_1, note_in_start_2, note_in_start_3;
    wire [21:0]note_in_death_1, note_in_death_2, note_in_death_3;
    wire [21:0]note_in_shoot;
    wire [21:0]note_in_end_1, note_in_end_2, note_in_end_3;
    wire [15:0]audio_in_start_1, audio_in_start_2, audio_in_start_3;
    wire [15:0]audio_in_death_1, audio_in_death_2, audio_in_death_3;
    wire [15:0]audio_in_shoot;
    wire [15:0]audio_in_end_1, audio_in_end_2, audio_in_end_3;
    wire [15:0]audio_in_left, audio_in_right;
    wire clk_20HZ;       // divided clock
    wire clk_15HZ;
    // dirction
    wire map_reset;
    wire [1:0]p1_dir, p2_dir;
    // scores
    wire [8:0]p1_score, p2_score;
    wire [3:0]p1s0, p1s1, p1s2, p1s3;
    wire [3:0]p2s0, p2s1, p2s2, p2s3; 
    wire p1_death, p2_death;
    wire [1:0]state;        // fsm current game state
    // seven segment display
    wire clk_1HZ;
    wire [1:0]clk_ctl;
    wire [3:0]val0, val1, val2, val3;
    reg [3:0]intossd;
    wire [3:0]intossd_time;
    wire [3:0]lightctl_out_time;
    wire [3:0]intossd_score;
    wire [3:0]lightctl_out_score;
    // timer
    wire [3:0]time0, time1, time2, time3;
    wire count_en;
    wire stop;

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
    KeyboardDecoder U0(
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(key_valid),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
		);
		
	vga_clk U1(
		.clk(clk),
	    .clk1(clk_25MHz),
        .clk19(clk_19),
	    .clk22(clk_22)
		);
    buzzer_ctrl U2_track1_death(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_death_1), // div for note generation
        .audio(audio_in_death_1) // left sound audio
    );
    buzzer_ctrl U2_track2_death(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_death_2), // div for note generation
        .audio(audio_in_death_2) // right sound audio
    );
    buzzer_ctrl U2_track3_death(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_death_3), // div for note generation
        .audio(audio_in_death_3) // right sound audio
    );
    buzzer_ctrl U2_track4_shoot(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_shoot), // div for note generation
        .audio(audio_in_shoot) // right sound audio
    );
    buzzer_ctrl U2_track5_end(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_end_1), // div for note generation
        .audio(audio_in_end_1) // left sound audio
    );
    buzzer_ctrl U2_track7_start(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_start_1), // div for note generation
        .audio(audio_in_start_1) // right sound audio
    );
    buzzer_ctrl U2_track8_start(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_start_2), // div for note generation
        .audio(audio_in_start_2) // right sound audio
    );
    buzzer_ctrl U2_track9_start(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_start_3), // div for note generation
        .audio(audio_in_start_3) // right sound audio
    );
    buzzer_ctrl U2_track6_end(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_in_end_2), // div for note generation
        .audio(audio_in_end_2) // right sound audio
    );
    assign audio_in_left = audio_in_death_1 + audio_in_death_2 +  audio_in_death_3 + audio_in_shoot
            + audio_in_end_1 + audio_in_end_2 + audio_in_start_1 + audio_in_start_2 + audio_in_start_3;
    assign audio_in_right = audio_in_death_1 + audio_in_death_2 + audio_in_death_3 + audio_in_shoot
            + audio_in_end_1 + audio_in_end_2 + audio_in_start_1 + audio_in_start_2 + audio_in_start_3;
    // Speaker controllor
    speaker_ctrl U3(
        .clk(clk),                          // clock from the crystal
        .rst_n(rst),                      // active low reset
        .audio_left(audio_in_left),      // left channel audio data input
        .audio_right(audio_in_right),    // right channel audio data input
        .audio_mclk(audio_mclk),            // master clock
        .audio_lrck(audio_lrck),            // left-right clock
        .audio_sck(audio_sck),              // serial clock
        .audio_sdin(audio_sdin)             // serial audio data input
    );
    // sound
    freq_div_for_sound U8(
        .clk(clk),
        .rst_n(rst),
        .clk_out(clk_20HZ)
    );
    freq_div_15HZ U15(
        .clk(clk),
        .rst_n(rst),
        .clk_out(clk_15HZ)
    );
    in_note U9(
        .clk_15HZ(clk_15HZ),
        .clk_20HZ(clk_20HZ),
        .rst(rst),
        .death_en(death_en),
        .shoot_en(1'b0),
        .end_en(end_en),
        .start_sound_en(start_sound_en),
        .note_shoot(note_in_shoot),
        .note_death_1(note_in_death_1),
        .note_death_2(note_in_death_2),
        .note_death_3(note_in_death_3),
        .note_end_1(note_in_end_1),
        .note_end_2(note_in_end_2),
        .note_start_1(note_in_start_1),
        .note_start_2(note_in_start_2),
        .note_start_3(note_in_start_3)
    );
	vga U4(
	    .pclk(clk_25MHz),
	    .reset(rst),
	    .hsync(hsync),
	    .vsync(vsync),
	    .valid(valid),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt)
		);
    direction_fsm U5(
        .clk(clk),
        .rst(rst),
        .key_down(key_down),
        .p1_dir(p1_dir),
        .p2_dir(p2_dir)
    );

    mem_addr_gen U6(
        .clk_19(clk_19),
        .clk_22(clk_22),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .key_down(key_down),
        .pixel_addr(pixel_addr),
        .p1_dir(p1_dir),
        .p2_dir(p2_dir),
        .p1_score(p1_score),
        .p2_score(p2_score),
        .p1_death(p1_death),
        .p2_death(p2_death),
        .restart_map(map_reset),
        .state(state)
	);
    blk_mem_gen_0 U7(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel0)
	); 
    freq_div_1HZ U99(
        .clk(clk),
        .clk_out(clk_1HZ),
        .rst_n(rst),
        .clk_ctl(clk_ctl)
    );
    Bin_to_dec U9_p1(
        .ans(p1_score),
        .BCD0(p1s0),
        .BCD1(p1s1),
        .BCD2(p1s2),
        .BCD3(p1s3)
    );
    Bin_to_dec U10_p2(
        .ans(p2_score),
        .BCD0(p2s0),
        .BCD1(p2s1),
        .BCD2(p2s2),
        .BCD3(p2s3)
    );
    
    scan_ctl U11_scan_ctl_time(
        .in0(time0),
        .in1(time1),
        .in2(time2),
        .in3(time3),
        .intossd(intossd_time),
        .lightctl(lightctl_out_time),
        .sel(clk_ctl)
    );
    
    scan_ctl U11_scan_ctl_score(
        .in0(p2s0),
        .in1(p2s1),
        .in2(p1s0),
        .in3(p1s1),
        .intossd(intossd_score),
        .lightctl(lightctl_out_score),
        .sel(clk_ctl)
    );
    display U12_display(
        .i(intossd),
        .D(display)
    );
    game_play_fsm U13(
        .clk_100MHZ(clk),
        .clk_20HZ(clk_20HZ),
        .rst(rst),
        .p1_death(p1_death),
        .p2_death(p2_death),
        .map_reset(map_reset),
        .stop(stop),
        .start_en(key_down[9'h021]),
        .death_en(death_en),
        .count_en(count_en),
        .end_en(end_en),
        .state(state),
        .start_sound_en(start_sound_en)
    );
    timer U14(
        .val0(time0),
        .val1(time1),
        .val2(time2),
        .val3(time3),
        .clk(clk_1HZ),
        .rst_n(rst),
        .stop(stop),
        .en(count_en)
    );
    always @*
        if (dis_mode) begin
            intossd = intossd_time;
            lightctl_out = lightctl_out_time;
        end
        else begin
            intossd = intossd_score;
            lightctl_out = lightctl_out_score;
        end

endmodule
