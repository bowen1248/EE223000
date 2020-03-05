`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/21 19:13:53
// Design Name: 
// Module Name: in_note
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
/*
`include "note_global.v"
module in_note(
	clk_15HZ,
	clk_20HZ,
	rst,
	death_en,
	shoot_en,
	end_en,
	note_shoot,
	note_death_1,
	note_death_2, 
	note_death_3,
	note_end_1, 
	note_end_2
    );
	input clk_15HZ;
    input clk_20HZ;
    input rst;
    input death_en;	// if death, enable = 1
    input shoot_en;	// if shooting, enable = 1
	input end_en;
    output reg [21:0]note_shoot;
    output reg [21:0]note_death_1, note_death_2, note_death_3;
	output reg [21:0]note_end_1, note_end_2;
    reg [21:0]note_shoot_next;
    reg [21:0]note_death_1_next, note_death_2_next, note_death_3_next;
	reg [21:0]note_end_1_next, note_end_2_next;
    reg [5:0]cnt_death, cnt_death_next;
    reg [5:0]cnt_shoot, cnt_shoot_next;
	reg [12:0]cnt_end, cnt_end_next;
    always @*
    	if (death_en == 1'b0)
    		cnt_death_next = 6'b0;
    	else if (cnt_death == 6'd43)
    		cnt_death_next = 6'b0;
    	else
    		cnt_death_next = cnt_death + 1'b1;
    always @*
    	if (shoot_en == 1'b0)
    		cnt_shoot_next = 6'b0;
		else if (cnt_shoot == 6'd12)
			cnt_shoot_next = 6'd0;
    	else
    		cnt_shoot_next = cnt_shoot + 1'b1;
	always @*
    	if (end_en == 1'b0)
    		cnt_end_next = 13'b0;
		else if (cnt_end == 13'd82)
			cnt_end_next = 13'd0;
    	else
    		cnt_end_next = cnt_end + 1'b1;

    // death song logic
    always @*
	begin
    	if (death_en == 1'b1)
    	begin
    		case(cnt_death)
    			6'b0:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd1:
    			begin
    				note_death_1_next = `LOWSO;
    			    note_death_2_next = `SO;
					note_death_3_next = `SI;
    			end
    			6'd2:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `SO;
					note_death_3_next = `SI;
    			end
				6'd3:
    			begin
    			   	note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd4:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd5:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd6:
    			begin
    			    note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd7:
    			begin
    			    note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd8:
    			begin
    				note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd9:
    			begin
    			    note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd10:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd11:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd12:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd13:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd14:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd15:
    			begin
	   			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd16:
    			begin
    				note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd17:
    			begin
    			    note_death_1_next = `LOWLA;
    			    note_death_2_next = `HIDO;
					note_death_3_next = `HIMI;
    			end
    			6'd18:
    			begin
    			    note_death_1_next = `LOWLA;
    			    note_death_2_next = `HIDO;
					note_death_3_next = `HIMI;
				end
				6'd19:
				begin
				    note_death_1_next = `LOWLA;
    			    note_death_2_next = `HIDO;
					note_death_3_next = `HIMI;
				end
				6'd20:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd21:
				begin
					note_death_1_next = `LOWSI;
					note_death_2_next = `SI;
					note_death_3_next = `HIRE;
				end
				6'd22:
				begin
					note_death_1_next = `LOWSI;
					note_death_2_next = `SI;
					note_death_3_next = `HIRE;
				end
				6'd23:
				begin
					note_death_1_next = `LOWSI;
					note_death_2_next = `SI;
					note_death_3_next = `HIRE;
				end
				6'd24:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd25:
				begin
					note_death_1_next = `DO;
					note_death_2_next = `SO;
					note_death_3_next = `HIDO;
				end
				6'd26:
				begin
					note_death_1_next = `DO;
					note_death_2_next = `SO;
					note_death_3_next = `HIDO;
				end
				6'd27:
				begin
				    note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd28:
				begin
				   	note_death_1_next = 22'b0;
					note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd29:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd30:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd31:
				begin
				    note_death_1_next = `LOWSO;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd32:
				begin
				    note_death_1_next = `LOWSO;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd33:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd34:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd35:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd36:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd37:
				begin
					note_death_1_next = `LOWDO;
					note_death_2_next = `DO;
					note_death_3_next = 22'b0;
				end
				6'd38:
				begin
				    note_death_1_next = `LOWDO;
					note_death_2_next = `DO;
					note_death_3_next = 22'b0;
				end
				6'd39:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd40:
				begin
	   			    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd41:
				begin
	   			    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd42:
				begin
	   			    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				default: 
				begin
					note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
			endcase
		end
		else
		begin
			note_death_1_next = 22'b0;
			note_death_2_next = 22'b0;
			note_death_3_next = 22'b0;
		end
		// shoot sound effect
		if (shoot_en == 1'b1)
		begin
			case(cnt_shoot)
				6'b0: note_shoot_next = 22'b0;
				6'd1: note_shoot_next = `SI;
				6'd2: note_shoot_next = `SI;
				6'd3: note_shoot_next = `HIMI;
				6'd4: note_shoot_next = `HIMI;
				6'd5: note_shoot_next = `HIMI;
				6'd6: note_shoot_next = `HIMI;
				6'd7: note_shoot_next = 22'b0;
				6'd8: note_shoot_next = 22'b0;
				6'd9: note_shoot_next = 22'b0;
				6'd10: note_shoot_next = 22'b0;
				6'd11: note_shoot_next = 22'b0;
				default: note_shoot_next = 22'b0;
			endcase
		end
		else
			note_shoot_next = 22'b0;
		// end soundeffect
		if (end_en == 1)
		begin
			case(cnt_end)
				13'd0:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd1:
				begin
				    note_end_1_next = `LOWSO;
				    note_end_2_next = 22'd0;
				end
				13'd2:
				begin
				    note_end_1_next = `LOWSO;
				    note_end_2_next = 22'd0;
				end
				13'd3:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMI;
				end
				13'd4:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMI;
				end
				//
				13'd5:
				begin
				    note_end_1_next = `MI;
				    note_end_2_next = `LOWSO;
				end
				13'd6:
				begin
				    note_end_1_next = `MI;
				    note_end_2_next = `LOWSO;
				end
				13'd7:
				begin
				    note_end_1_next = `SO;
				    note_end_2_next = `LOWDO;
				end
				13'd8:
				begin
				    note_end_1_next = `SO;
				    note_end_2_next = `LOWDO;
				end
				//
				13'd9:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd10:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd11:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `LOWSO;
				end
				13'd12:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `LOWSO;
				end
				//
				13'd13:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd14:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd15:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd16:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				//
				13'd17:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd18:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd19:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd20:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				//
				13'd21:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd22:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd23:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd24:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				//
				13'd25:
				begin
				    note_end_1_next = `LOWLAM;
				    note_end_2_next = 22'd0;
				end
				13'd26:
				begin
				    note_end_1_next = `LOWLAM;
				    note_end_2_next = 22'd0;
				end
				13'd27:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMIM;
				end
				13'd28:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMIM;
				end
				//
				13'd29:
				begin
				    note_end_1_next = `MIM;
				    note_end_2_next = `LOWLA;
				end
				13'd30:
				begin
				    note_end_1_next = `MIM;
				    note_end_2_next = `LOWLA;
				end
				13'd31:
				begin
				    note_end_1_next = `LAM;
				    note_end_2_next = `LOWDO;
				end
				13'd32:
				begin
				    note_end_1_next = `LAM;
				    note_end_2_next = `LOWDO;
				end
				//
				13'd33:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd34:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd35:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `LOWLA;
				end
				13'd36:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `LOWLA;
				end
				//
				13'd37:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd38:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd39:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd40:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				//
				13'd41:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd42:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd43:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd44:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				//
				13'd45:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd46:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd47:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd48:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				//
				13'd49:
				begin
				    note_end_1_next = `LOWSIM;
				    note_end_2_next = 22'b0;
				end
				13'd50:
				begin
				    note_end_1_next = `LOWSIM;
				    note_end_2_next = 22'd0;
				end
				13'd51:
				begin
				    note_end_1_next = `RE;
				    note_end_2_next = `LOWFA;
				end
				13'd52:
				begin
				    note_end_1_next = `RE;
				    note_end_2_next = `LOWFA;
				end
				//
				13'd53:
				begin
				    note_end_1_next = `FA;
				    note_end_2_next = `LOWSI;
				end
				13'd54:
				begin
				    note_end_1_next = `FA;
				    note_end_2_next = `LOWSI;
				end
				13'd55:
				begin
				    note_end_1_next = `SIM;
				    note_end_2_next = `LOWRE;
				end
				13'd56:
				begin
				    note_end_1_next = `SIM;
				    note_end_2_next = `LOWRE;
				end
				//
				13'd57:
				begin
				    note_end_1_next = `HIRE;
				    note_end_2_next = `LOWFA;
				end
				13'd58:
				begin
				    note_end_1_next = `HIRE;
				    note_end_2_next = `LOWFA;
				end
				13'd59:
				begin
				    note_end_1_next = `HIFA;
				    note_end_2_next = `LOWSI;
				end
				13'd60:
				begin
				    note_end_1_next = `HIFA;
				    note_end_2_next = `LOWSI;
				end
				//
				13'd61:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd62:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd63:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd64:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				//
				13'd65:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd66:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd67:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd68:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
				//
				13'd69:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd70:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
				13'd71:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd72:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
				//
				13'd73:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd74:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd75:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd76:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				//
				13'd77:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd78:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd79:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd80:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd81:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd82:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				default:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
			endcase
		end

		else
		begin
			note_end_1_next = 22'd0;
			note_end_2_next = 22'd0;
		end
	end
				//
	always @(posedge clk_15HZ or posedge rst)
		if (rst)
		begin
			note_end_1 <= 22'b0;
			note_end_2 <= 22'b0;
			cnt_end <= 13'b0;
		end
		else
		begin
			note_end_1 <= note_end_1_next;
			note_end_2 <= note_end_2_next;
			cnt_end <= cnt_end_next;
		end
    always @(posedge clk_20HZ or posedge rst)
    	if (rst)
    	begin
    		note_shoot <= 22'b0;
    		note_death_1 <= 22'b0;
    		note_death_2 <= 22'b0;
			note_death_3 <= 22'b0;
    		cnt_shoot <= 6'b0;
    		cnt_death <= 6'b0;
    	end
    	else
    	begin
    		note_shoot <= note_shoot_next;
    		note_death_1 <= note_death_1_next;
    		note_death_2 <= note_death_2_next;
			note_death_3 <= note_death_3_next;
    		cnt_shoot <= cnt_shoot_next;
    		cnt_death <= cnt_death_next;
    	end
    		
endmodule
*/
`include "note_global.v"
module in_note(
	clk_15HZ,
	clk_20HZ,
	rst,
	death_en,
	shoot_en,
	end_en,
	start_sound_en,
	note_shoot,
	note_death_1,
	note_death_2, 
	note_death_3,
	note_end_1, 
	note_end_2,
	note_start_1,
	note_start_2,
	note_start_3
    );
	input clk_15HZ;
    input clk_20HZ;
    input rst;
    input death_en;	// if death, enable = 1
    input shoot_en;	// if shooting, enable = 1
	input end_en;
	input start_sound_en;
    output reg [21:0]note_shoot;
    output reg [21:0]note_death_1, note_death_2, note_death_3;
	output reg [21:0]note_end_1, note_end_2;
	output reg [21:0]note_start_1, note_start_2, note_start_3;
    reg [21:0]note_shoot_next;
    reg [21:0]note_death_1_next, note_death_2_next, note_death_3_next;
	reg [21:0]note_end_1_next, note_end_2_next;
	reg [21:0]note_start_1_next, note_start_2_next, note_start_3_next;
    reg [5:0]cnt_death, cnt_death_next;
    reg [5:0]cnt_shoot, cnt_shoot_next;
	reg [12:0]cnt_end, cnt_end_next;
	reg [12:0]cnt_start, cnt_start_next;
    always @*
    	if (death_en == 1'b0)
    		cnt_death_next = 6'b0;
    	else if (cnt_death == 6'd43)
    		cnt_death_next = 6'b0;
    	else
    		cnt_death_next = cnt_death + 1'b1;
    always @*
    	if (shoot_en == 1'b0)
    		cnt_shoot_next = 6'b0;
		else if (cnt_shoot == 6'd12)
			cnt_shoot_next = 6'd0;
    	else
    		cnt_shoot_next = cnt_shoot + 1'b1;
	always @*
		if (start_sound_en == 1'b0)
			cnt_start_next = 13'b0;
		else if (cnt_start == 13'd145)
			cnt_start_next = 13'd0;
		else
			cnt_start_next = cnt_start + 1'b1;
	always @*
    	if (end_en == 1'b0)
    		cnt_end_next = 13'b0;
		else if (cnt_end == 13'd82)
			cnt_end_next = 13'd0;
    	else
    		cnt_end_next = cnt_end + 1'b1;

    // death song logic
    always @*
	begin
    	if (death_en == 1'b1)
    	begin
    		case(cnt_death)
    			6'b0:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd1:
    			begin
    				note_death_1_next = `LOWSO;
    			    note_death_2_next = `SO;
					note_death_3_next = `SI;
    			end
    			6'd2:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `SO;
					note_death_3_next = `SI;
    			end
				6'd3:
    			begin
    			   	note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd4:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd5:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd6:
    			begin
    			    note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd7:
    			begin
    			    note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd8:
    			begin
    				note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd9:
    			begin
    			    note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd10:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd11:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd12:
    			begin
    				note_death_1_next = 22'b0;
    				note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd13:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd14:
    			begin
    			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd15:
    			begin
	   			    note_death_1_next = `LOWSO;
    			    note_death_2_next = `HIRE;
					note_death_3_next = `HIFA;
    			end
    			6'd16:
    			begin
    				note_death_1_next = 22'b0;
    			    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
    			end
    			6'd17:
    			begin
    			    note_death_1_next = `LOWLA;
    			    note_death_2_next = `HIDO;
					note_death_3_next = `HIMI;
    			end
    			6'd18:
    			begin
    			    note_death_1_next = `LOWLA;
    			    note_death_2_next = `HIDO;
					note_death_3_next = `HIMI;
				end
				6'd19:
				begin
				    note_death_1_next = `LOWLA;
    			    note_death_2_next = `HIDO;
					note_death_3_next = `HIMI;
				end
				6'd20:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd21:
				begin
					note_death_1_next = `LOWSI;
					note_death_2_next = `SI;
					note_death_3_next = `HIRE;
				end
				6'd22:
				begin
					note_death_1_next = `LOWSI;
					note_death_2_next = `SI;
					note_death_3_next = `HIRE;
				end
				6'd23:
				begin
					note_death_1_next = `LOWSI;
					note_death_2_next = `SI;
					note_death_3_next = `HIRE;
				end
				6'd24:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd25:
				begin
					note_death_1_next = `DO;
					note_death_2_next = `SO;
					note_death_3_next = `HIDO;
				end
				6'd26:
				begin
					note_death_1_next = `DO;
					note_death_2_next = `SO;
					note_death_3_next = `HIDO;
				end
				6'd27:
				begin
				    note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd28:
				begin
				   	note_death_1_next = 22'b0;
					note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd29:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd30:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd31:
				begin
				    note_death_1_next = `LOWSO;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd32:
				begin
				    note_death_1_next = `LOWSO;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd33:
				begin
					note_death_1_next = 22'b0;
					note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd34:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd35:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = `MI;
					note_death_3_next = 22'b0;
				end
				6'd36:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd37:
				begin
					note_death_1_next = `LOWDO;
					note_death_2_next = `DO;
					note_death_3_next = 22'b0;
				end
				6'd38:
				begin
				    note_death_1_next = `LOWDO;
					note_death_2_next = `DO;
					note_death_3_next = 22'b0;
				end
				6'd39:
				begin
				    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd40:
				begin
	   			    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd41:
				begin
	   			    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				6'd42:
				begin
	   			    note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
				default: 
				begin
					note_death_1_next = 22'b0;
				    note_death_2_next = 22'b0;
					note_death_3_next = 22'b0;
				end
			endcase
		end
		else
		begin
			note_death_1_next = 22'b0;
			note_death_2_next = 22'b0;
			note_death_3_next = 22'b0;
		end
		// shoot sound effect
		if (shoot_en == 1'b1)
		begin
			case(cnt_shoot)
				6'b0: note_shoot_next = 22'b0;
				6'd1: note_shoot_next = `SI;
				6'd2: note_shoot_next = `SI;
				6'd3: note_shoot_next = `HIMI;
				6'd4: note_shoot_next = `HIMI;
				6'd5: note_shoot_next = `HIMI;
				6'd6: note_shoot_next = `HIMI;
				6'd7: note_shoot_next = 22'b0;
				6'd8: note_shoot_next = 22'b0;
				6'd9: note_shoot_next = 22'b0;
				6'd10: note_shoot_next = 22'b0;
				6'd11: note_shoot_next = 22'b0;
				default: note_shoot_next = 22'b0;
			endcase
		end
		else
			note_shoot_next = 22'b0;
		// end soundeffect
		if (end_en == 1)
		begin
			case(cnt_end)
				13'd0:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd1:
				begin
				    note_end_1_next = `LOWSO;
				    note_end_2_next = 22'd0;
				end
				13'd2:
				begin
				    note_end_1_next = `LOWSO;
				    note_end_2_next = 22'd0;
				end
				13'd3:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMI;
				end
				13'd4:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMI;
				end
				//
				13'd5:
				begin
				    note_end_1_next = `MI;
				    note_end_2_next = `LOWSO;
				end
				13'd6:
				begin
				    note_end_1_next = `MI;
				    note_end_2_next = `LOWSO;
				end
				13'd7:
				begin
				    note_end_1_next = `SO;
				    note_end_2_next = `LOWDO;
				end
				13'd8:
				begin
				    note_end_1_next = `SO;
				    note_end_2_next = `LOWDO;
				end
				//
				13'd9:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd10:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd11:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `LOWSO;
				end
				13'd12:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `LOWSO;
				end
				//
				13'd13:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd14:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd15:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd16:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				//
				13'd17:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd18:
				begin
				    note_end_1_next = `HISO;
				    note_end_2_next = `MI;
				end
				13'd19:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd20:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				//
				13'd21:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd22:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd23:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				13'd24:
				begin
				    note_end_1_next = `HIMI;
				    note_end_2_next = `DO;
				end
				//
				13'd25:
				begin
				    note_end_1_next = `LOWLAM;
				    note_end_2_next = 22'd0;
				end
				13'd26:
				begin
				    note_end_1_next = `LOWLAM;
				    note_end_2_next = 22'd0;
				end
				13'd27:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMIM;
				end
				13'd28:
				begin
				    note_end_1_next = `DO;
				    note_end_2_next = `LOWMIM;
				end
				//
				13'd29:
				begin
				    note_end_1_next = `MIM;
				    note_end_2_next = `LOWLA;
				end
				13'd30:
				begin
				    note_end_1_next = `MIM;
				    note_end_2_next = `LOWLA;
				end
				13'd31:
				begin
				    note_end_1_next = `LAM;
				    note_end_2_next = `LOWDO;
				end
				13'd32:
				begin
				    note_end_1_next = `LAM;
				    note_end_2_next = `LOWDO;
				end
				//
				13'd33:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd34:
				begin
				    note_end_1_next = `HIDO;
				    note_end_2_next = `LOWMI;
				end
				13'd35:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `LOWLA;
				end
				13'd36:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `LOWLA;
				end
				//
				13'd37:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd38:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd39:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd40:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				//
				13'd41:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd42:
				begin
				    note_end_1_next = `HILAM;
				    note_end_2_next = `MIM;
				end
				13'd43:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd44:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				//
				13'd45:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd46:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd47:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				13'd48:
				begin
				    note_end_1_next = `HIMIM;
				    note_end_2_next = `DO;
				end
				//
				13'd49:
				begin
				    note_end_1_next = `LOWSIM;
				    note_end_2_next = 22'b0;
				end
				13'd50:
				begin
				    note_end_1_next = `LOWSIM;
				    note_end_2_next = 22'd0;
				end
				13'd51:
				begin
				    note_end_1_next = `RE;
				    note_end_2_next = `LOWFA;
				end
				13'd52:
				begin
				    note_end_1_next = `RE;
				    note_end_2_next = `LOWFA;
				end
				//
				13'd53:
				begin
				    note_end_1_next = `FA;
				    note_end_2_next = `LOWSI;
				end
				13'd54:
				begin
				    note_end_1_next = `FA;
				    note_end_2_next = `LOWSI;
				end
				13'd55:
				begin
				    note_end_1_next = `SIM;
				    note_end_2_next = `LOWRE;
				end
				13'd56:
				begin
				    note_end_1_next = `SIM;
				    note_end_2_next = `LOWRE;
				end
				//
				13'd57:
				begin
				    note_end_1_next = `HIRE;
				    note_end_2_next = `LOWFA;
				end
				13'd58:
				begin
				    note_end_1_next = `HIRE;
				    note_end_2_next = `LOWFA;
				end
				13'd59:
				begin
				    note_end_1_next = `HIFA;
				    note_end_2_next = `LOWSI;
				end
				13'd60:
				begin
				    note_end_1_next = `HIFA;
				    note_end_2_next = `LOWSI;
				end
				//
				13'd61:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd62:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd63:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd64:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				//
				13'd65:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd66:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd67:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd68:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
				//
				13'd69:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd70:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
				13'd71:
				begin
				    note_end_1_next = `HILAP;
				    note_end_2_next = `FA;
				end
				13'd72:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
				//
				13'd73:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd74:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd75:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd76:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				//
				13'd77:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd78:
				begin
				    note_end_1_next = `HIHIDO;
				    note_end_2_next = `MI;
				end
				13'd79:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd80:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd81:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				13'd82:
				begin
					note_end_1_next = 22'd0;
					note_end_2_next = 22'd0;
				end
				default:
				begin
				    note_end_1_next = 22'd0;
				    note_end_2_next = 22'd0;
				end
			endcase
		end
		else
		begin
			note_end_1_next = 22'd0;
			note_end_2_next = 22'd0;
		end
		if (start_sound_en == 1'b1)
		begin
			case (cnt_start)
				13'd0:
				begin
					note_start_1_next = 22'd0;
					note_start_2_next = 22'd0;
					note_start_3_next = 22'd0;
				end
				13'd1:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd2:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd3:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd4:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd5:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd6:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd7:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd8:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd9:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd10:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd11:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd12:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd13:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd14:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd15:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd16:
				begin
				    note_start_1_next = `HIDO;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd17:
				begin
				    note_start_1_next = `HIDO;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd18:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd19:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd20:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `FAP;
				    note_start_3_next = `LOWRE;
				end
				13'd21:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd22:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd23:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd24:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd25:
				begin
				    note_start_1_next = `HISO;
				    note_start_2_next = `SI;
				    note_start_3_next = `SO;
				end
				13'd26:
				begin
				    note_start_1_next = `HISO;
				    note_start_2_next = `SI;
				    note_start_3_next = `SO;
				end
				13'd27:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd28:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd29:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd30:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd31:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd32:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd33:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd34:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd35:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd36:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd37:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = `SO;
				    note_start_3_next = `LOWSO;
				end
				13'd38:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = `SO;
				    note_start_3_next = `LOWSO;
				end
				13'd39:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd40:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd41:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd42:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd43:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd44:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd45:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd46:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd47:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd48:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd49:
				begin
				    note_start_1_next = `HIDO;
				    note_start_2_next = `MI;
				    note_start_3_next = `LOWSO;
				end
				13'd50:
				begin
				    note_start_1_next = `HIDO;
				    note_start_2_next = `MI;
				    note_start_3_next = `LOWSO;
				end
				13'd51:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd52:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd53:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd54:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd55:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd56:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd57:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd58:
				begin
				    note_start_1_next = `SO;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWMI;
				end
				13'd59:
				begin
				    note_start_1_next = `SO;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWMI;
				end
				13'd60:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd61:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd62:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd63:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd64:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd65:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd66:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd67:
				begin
				    note_start_1_next = `MI;
				    note_start_2_next = `LOWSO;
				    note_start_3_next = `LOWDO;
				end
				13'd68:
				begin
				    note_start_1_next = `MI;
				    note_start_2_next = `LOWSO;
				    note_start_3_next = `LOWDO;
				end
				13'd69:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd70:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd71:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd72:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd73:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd74:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd75:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd76:
				begin
				    note_start_1_next = `LA;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWFA;
				end
				13'd77:
				begin
				    note_start_1_next = `LA;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWFA;
				end
				13'd78:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd79:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd80:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd81:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd82:
				begin
				    note_start_1_next = `SI;
				    note_start_2_next = `RE;
				    note_start_3_next = `LOWSO;
				end
				13'd83:
				begin
				    note_start_1_next = `SI;
				    note_start_2_next = `RE;
				    note_start_3_next = `LOWSO;
				end
				13'd84:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd85:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd86:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd87:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd88:
				begin
				    note_start_1_next = `SIM;
				    note_start_2_next = `REM;
				    note_start_3_next = `LOWSOM;
				end
				13'd89:
				begin
				    note_start_1_next = `SIM;
				    note_start_2_next = `REM;
				    note_start_3_next = `LOWSOM;
				end
				13'd90:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd91:
				begin
				    note_start_1_next = `LA;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWFA;
				end
				13'd92:
				begin
				    note_start_1_next = `LA;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWFA;
				end
				13'd93:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd94:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd95:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd96:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd97:
				begin
				    note_start_1_next = `SO;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWMI;
				end
				13'd98:
				begin
				    note_start_1_next = `SO;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWMI;
				end
				13'd99:
				begin
				    note_start_1_next = `SO;
				    note_start_2_next = `DO;
				    note_start_3_next = `LOWMI;
				end
				//
				13'd100:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd101:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `SO;
				    note_start_3_next = `DO;
				end
				13'd102:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `SO;
				    note_start_3_next = `DO;
				end
				13'd103:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `SO;
				    note_start_3_next = `DO;
				end
				//
				13'd104:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd105:
				begin
				    note_start_1_next = `HISO;
				    note_start_2_next =`SI;
				    note_start_3_next = `MI;
				end
				13'd106:
				begin
				    note_start_1_next = `HISO;
				    note_start_2_next =`SI;
				    note_start_3_next = `MI;
				end
				13'd107:
				begin
				    note_start_1_next = `HISO;
				    note_start_2_next =`SI;
				    note_start_3_next = `MI;
				end
				//
				13'd108:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd109:
				begin
				    note_start_1_next = `HILA;
				    note_start_2_next = `HIDO;
				    note_start_3_next = `FA;
				end
				13'd110:
				begin
				    note_start_1_next = `HILA;
				    note_start_2_next = `HIDO;
				    note_start_3_next = `FA;
				end
				13'd111:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd112:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd113:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd114:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd115:
				begin
				    note_start_1_next = `HIFA;
				    note_start_2_next = `LA;
				    note_start_3_next = `RE;
				end
				13'd116:
				begin
				    note_start_1_next = `HIFA;
				    note_start_2_next = `LA;
				    note_start_3_next = `RE;
				end
				13'd117:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd118:
				begin
				    note_start_1_next = `HISO;
				    note_start_2_next = `SI;
				    note_start_3_next = `RE;
				end
				13'd119:
				begin
				    note_start_1_next = `HISO;
				    note_start_2_next = `SI;
				    note_start_3_next = `RE;
				end
				13'd120:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd121:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd122:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd123:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd124:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `LA;
				    note_start_3_next = `DO;
				end
				13'd125:
				begin
				    note_start_1_next = `HIMI;
				    note_start_2_next = `LA;
				    note_start_3_next = `DO;
				end
				13'd126:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd127:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd128:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd129:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd130:
				begin
				    note_start_1_next = `HIDO;
				    note_start_2_next = `MI;
				    note_start_3_next = `LOWLA;
				end
				13'd131:
				begin
				    note_start_1_next = `HIDO;
				    note_start_2_next = `MI;
				    note_start_3_next = `LOWLA;
				end
				13'd132:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd133:
				begin
				    note_start_1_next = `HIRE;
				    note_start_2_next = `FA;
				    note_start_3_next = `LOWSI;
				end
				13'd134:
				begin
				    note_start_1_next = `HIRE;
				    note_start_2_next = `FA;
				    note_start_3_next = `LOWSI;
				end
				13'd135:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd136:
				begin
				    note_start_1_next = `SI;
				    note_start_2_next = `RE;
				    note_start_3_next = `LOWSO;
				end
				13'd137:
				begin
				    note_start_1_next = `SI;
				    note_start_2_next = `RE;
				    note_start_3_next = `LOWSO;
				end
				13'd138:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd139:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd140:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd141:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				13'd142:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd143:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				13'd144:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
				//
				default:
				begin
				    note_start_1_next = 22'd0;
				    note_start_2_next = 22'd0;
				    note_start_3_next = 22'd0;
				end
			endcase
		end
		else
		begin
			note_start_1_next = 22'd0;
			note_start_2_next = 22'd0;
			note_start_3_next = 22'd0;
		end
	end

				//
	always @(posedge clk_15HZ or posedge rst)
		if (rst)
		begin
			note_end_1 <= 22'b0;
			note_end_2 <= 22'b0;
			cnt_end <= 13'b0;
		end
		else
		begin
			note_end_1 <= note_end_1_next;
			note_end_2 <= note_end_2_next;
			cnt_end <= cnt_end_next;
		end
    always @(posedge clk_20HZ or posedge rst)
    	if (rst)
    	begin
    		note_shoot <= 22'b0;
    		note_death_1 <= 22'b0;
    		note_death_2 <= 22'b0;
			note_death_3 <= 22'b0;
			note_start_1 <= 22'b0;
			note_start_2 <= 22'b0;
			note_start_3 <= 22'b0;
			cnt_start <= 13'b0;
    		cnt_shoot <= 6'b0;
    		cnt_death <= 6'b0;
    	end
    	else
    	begin
    		note_shoot <= note_shoot_next;
    		note_death_1 <= note_death_1_next;
    		note_death_2 <= note_death_2_next;
			note_death_3 <= note_death_3_next;
			note_start_1 <= note_death_1_next;
			note_start_2 <= note_start_2_next;
			note_start_3 <= note_start_3_next;
			cnt_start <= cnt_start_next;
    		cnt_shoot <= cnt_shoot_next;
    		cnt_death <= cnt_death_next;
    	end
    		
endmodule
