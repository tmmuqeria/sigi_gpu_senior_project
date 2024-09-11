`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 02:59:20 PM
// Design Name: 
// Module Name: obj_nr_16x16
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


module obj_nr_16x16(
        input wire [9:0] x, y, hdmi_x, hdmi_y,
        input wire [255:0] shape,
        input wire active,
//        input wire [23:0] color,
//        input wire [2:0] color_x,color_y,
//        input wire set_color,
        output wire present
//        output wire [23:0] out_color
        
    );
    
    reg [23:0] picture [255:0]; ///colored shape
    wire [7:0]color_adr, hdmi_adr;
    assign color_adr = {color_y,color_x};
    
    wire [7:0] dx,dy;
    assign dx = ((hdmi_x - x));
    assign dy = ((hdmi_y - y));
    assign hdmi_adr = {dy[2:0], dx[2:0]}; 
    
    always @(set_color == 1'b1)
    begin
        picture [color_adr] = color;
    end
    assign present = (((hdmi_x >= x) && hdmi_x < (x+10'd8)) && ((hdmi_y >= y) && hdmi_y < (y+10'd8))) && shape[hdmi_adr] ? 1'b1: 1'b0;
    
endmodule
