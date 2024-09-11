`timescale 1ns / 1ps

module bottomflat(
        input [9:0] top_x,top_y,
        input [9:0] bot_l_x,bot_l_y,
        input [9:0] bot_r_x,bot_r_y,
        input clk,
        input start,
        output reg done,
        output reg  [9:0] x,y
    );
    reg out;
    reg [9:0]cur_y,l_x,r_x;
    initial
    begin
        done = 1'b1;
        out = 1'b0;
    end
    always @(clk)
    begin
        if(start&~out)
        begin
            done <= 1'b0;
            out <= 1'b1;
            
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
endmodule
