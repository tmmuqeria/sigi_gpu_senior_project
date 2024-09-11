`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 12:25:24 PM
// Design Name: 
// Module Name: horizontal
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


module horizontal(
        input [15:0] start_x,end_x,
        input start,
        input clk,
        input clk_enb,
        output reg done,
        output reg [15:0] out_x
    );
    reg out;
    wire [15:0]d;
    assign d = start_x>end_x? -16'd1:16'd1;
    initial
    begin
        done = 1'b1;
        out = 1'b0;
    end
    always @(clk)
    begin
        if(clk_enb)
        begin
        if(start&~out)
        begin
            done <= 1'b0;
            out <= 1'b1;
            out_x <= start_x;
        end
        if(out)
        begin
            if(out_x==end_x)
            begin
                out=1'b0;
                done=1'b1;
            end
            else
            begin
                out_x=out_x+d;
            end            
        end
        end
    end
    
    
endmodule
