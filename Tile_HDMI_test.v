`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2024 11:01:34 PM
// Design Name: 
// Module Name: Tile_HDMI_test
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


module Tile_HDMI_test(
        input clk,  // 125MHz
        output [2:0] TMDSp, TMDSn,
        output TMDSp_clock, TMDSn_clock
    );
    
    //conversion from hdmi to tile map x,y
    //640
    //80*8
    
    //480
    //60*8
    wire [9:0]x_hdmi_o,y_hdmi_o;
    
    wire [9:0]x_hdmi_o_div8,y_hdmi_o_div8;
    wire [5:0] y_Tile_map_i;
    wire [6:0] x_Tile_map_i;
    assign x_hdmi_o_div8 = (x_hdmi_o>>3);
    assign y_hdmi_o_div8 = y_hdmi_o>>3;
    
    assign x_Tile_map_i = x_hdmi_o_div8[5:0];
    assign y_Tile_map_i = y_hdmi_o_div8[6:0];
    
    //
    wire read_color;//read color
    
    //
    wire [5:0] tile_adr;
    wire [2:0] tile_x,tile_y;
    assign tile_x = x_hdmi_o[2:0];
    assign tile_y = y_hdmi_o[2:0];
    
    //
    wire [23:0] tile_pxl;
    
    HDMI_test h(
        .clk(clk),
        .vr(tile_pxl[7:0]),
        .vg(tile_pxl[15:8]),
        .vb(tile_pxl[23:16]),
        .TMDSp(TMDSp),
        .TMDSn(TMDSn),
        .TMDSp_clock(TMDSp_clock),
        .TMDSn_clock(TMDSn_clock),
        .xout(x_hdmi_o),
        .yout(y_hdmi_o),
        .r(read_color)
    );
    
    reg [5:0] tm_write_y;
    reg [6:0] tm_write_x;
    reg [5:0] tm_v;
    reg [0:0] tm_w;
    
    Tile_map tm(
        .clk(clk),
        .x(x_Tile_map_i),
        .y(y_Tile_map_i),
        .write_x(tm_write_x), //7bits
        .write_y(tm_write_y), //6bits
        .v(tm_v), //6bits
        .w(tm_w), //bit
        .r(read_color),
        .o(tile_adr)
    );
    
    reg [2:0] t_write_y;
    reg [2:0] t_write_x;
    reg [5:0] t_write_adr;
    reg [23:0] t_v;
    reg [0:0] t_w;
    
    Tiles t(
        .x(tile_x),
        .y(tile_y),
        .adr(tile_adr),
        .write_x(t_write_x), //3bits
        .write_y(t_write_y), //3bits
        .write_adr(t_write_adr),//6bits
        .clk(clk),
        .r(read_color),
        .w(t_w),//bit
        .v(t_v),//24bits
        .o(tile_pxl)    
    );
    
endmodule
