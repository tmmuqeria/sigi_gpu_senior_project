`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2024 05:52:30 PM
// Design Name: 
// Module Name: obj_hdmi_test
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


module obj_hdmi_test(
    input clk,  // 125MHz
	output [2:0] TMDSp, TMDSn,
	output TMDSp_clock, TMDSn_clock
    );
    
    
    HDMI_test ht(
    .clk(clk),  // 125MHz
	.vr(),
	.vg(),
	.vb(),
	.TMDSp(), 
	.TMDSn(),
	.TMDSp_clock(), 
	.TMDSn_clock(),
	.xout(),
	.yout(),
	.r()
    
    );
    /// rect objects here
    rect_obj ro0(
        .new_x(),//10bit
        .new_y(),//10bit
        .x(),//10 bit
        .y(),// 10bit
        .setxy(),//bit
        .change_pxl(),//bit
        .in(),//24bit
        .clk(clk),
        .active(),
        .bool(),// true if object is in boarder
        .value()//23 bits value of pixel on (x,y) if bool it is true 
    
    );
    
    //non rect objects here
    
    non_rect_obj nro0(
        .new_x(),//10bit
        .new_y(),//10bit
        .x(),//10 bit
        .y(),// 10bit
        .new_shape(),//64 bits 8*8 shape
        .setshape(),//bit set shape to new_shape
        .setxy(),//bit
        .change_pxl(),//bit
        .in(),//24bit
        .clk(clk),
        .active(),
        .bool(),// true if object is in boarder
        .value()//23 bits value of pixel on (x,y) if bool it is true 
    
    );
    
    
endmodule
