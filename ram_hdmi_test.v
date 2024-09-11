`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2024 10:48:21 PM
// Design Name: 
// Module Name: ram_hdmi_test
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


module ram_hdmi_test(
    //input wire  btn,
    input wire[9:0] x0,y0,x1,y1,x2,y2,
    input wire start,
    input wire clk,  // 125MH
	output wire [2:0] TMDSp, TMDSn,
	output wire TMDSp_clock, TMDSn_clock,
	output wire done,
	output wire [15:0] x,y
    );
    wire [9:0] vx,vy;
    wire o,r,v,w;//,done;
//    reg [9:0] x0,x1,y0,y1;
   // reg start;
    reg btnc;
    //wire [15:0]x,y;
    reg [8:0]counte;
//    initial
//    begin 
//        counte<= 9'b111111111;
//        x0<=10'd50;
//        y0<=10'd300;
//        x1<= 10'd100;
//        y1<= 10'd440;
//        x1<= 10'd100;
//        y1<= 10'd440;
//        start <= 1'b0;
//        btnc <= 1'b0;
//    end
//    always @(posedge clk)
//    begin
//        if(start)
//        begin
//            start=1'b0;
//        end

//        if(btn)
//        begin
//            start=1'b1;
//        end
//    end    
    triangle3 ld(
        .x_0({6'b000000,x0}),
        .y_0({6'b000000,y0}),
        .x_1({6'b000000,x1}),
        .y_1({6'b000000,y1}),
        .x_2({6'b000000,x2}),
        .y_2({6'b000000,y2}),
        .clk(clk),
        .start(start),
        .done(done),
        .x(x),
        .y(y)
    ); 
    video_memory vm(
        .vx0(vx),
        .vy0(vy),
        .x0(x[9:0]),
        .y0(y[9:0]),
        .clk(clk),
        .vr0(r),
        .w0(~done&~start),// write in x0,y0
        .v(1'b1),
        .o(o)
        
    );
    HDMI_test ht(
        .clk(clk),
        .valll(o),
        .TMDSp(TMDSp),
        .TMDSn(TMDSn),
        .TMDSp_clock(TMDSp_clock),
        .TMDSn_clock(TMDSn_clock),
        .xout(vx),
        .yout(vy),
        .r(r)
    );
endmodule
