`timescale 1ns / 1ps
module trianglerast(
        input [15:0] top_x,top_y,
        input [15:0] mid_x,mid_y,
        input [15:0] bot_x,bot_y,
        input start,
        input clk,
        output reg done,
        output reg [15:0] x,y
   );
   reg [15:0] start_x,end_x,start_y,end_y,h_x0,h_x1;
   reg start_f,clk_enb_f,start_h,clk_enb_h;
   wire [15:0]x_f,y_f,out_x_h;
   reg [15:0] last_y;
   wire done_f, done_h;
   reg out0,out1;
   reg [1:0]done_cnt;
   initial
   begin
    out0 <= 1'b0;
    out1 <= 1'b0;
    done_cnt <= 2'd0;
     start_x <= top_x;
     start_y <= top_y;
     end_x <= mid_x;
     end_y <= mid_y;
     done <= 1'b1;
     last_y <= 16'd9999;
     start_f <= 1'b0;
     clk_enb_f <= 1'b0;
   end
   always @(posedge clk)
   begin 
        if(start&~out0&~out1)
        begin
            start_x <= top_x;
            start_y <= top_y;
            end_x <= mid_x;
            end_y <= mid_y;
            done <= 1'b0;
            out0 <= 1'b1;
            start_f <= 1'b1;
            clk_enb_f <= 1'b1;  
        end
        if(out0&~out1)
        begin
            if(start_f)
            begin
                start_f <= 1'b0;
            end
            
            if(y_f != last_y)
            begin
                clk_enb_f <= 1'b0;
                last_y <= y_f;
                x <= x_f;
                y <= y_f;
                h_x0 <= x_f;
                h_x1 <= y_f;
                clk_enb_h <= 1'b1;
                start_h <= 1'b1;
                out1 <= 1'b1;
            end
            else
            begin
                clk_enb_f <= 1'b1;
            end
            if(done_h&done_cnt==2'b00)
            begin
                start_x <= bot_x;
                start_y <= bot_y;
                end_x <= mid_x;
                end_y <= mid_y;
                done <= 1'b0;
                out0 <= 1'b1;
                start_f <= 1'b1;
                clk_enb_f <= 1'b1;
                done_cnt <= 2'b01;  
            end
            if(done_h&done_cnt==2'b01)
            begin
                start_x <= bot_x;
                start_y <= bot_y;
                end_x <= top_x;
                end_y <= top_y;
                done <= 1'b0;
                out0 <= 1'b1;
                start_f <= 1'b1;
                clk_enb_f <= 1'b1;
                done_cnt = 2'b11;  
            end
            if(done_h&done_cnt==2'b11)
            begin
                out0 <= 1'b0;
                out1 <= 1'b0;
                done_cnt <= 2'd0;
                start_x <= top_x;
                start_y <= top_y;
                end_x <= mid_x;
                end_y <= mid_y;
                done <= 1'b1;
                last_y <= 16'd9999;
                start_f <= 1'b0;
                clk_enb_f <= 1'b0;
                done <=1'b1;
            end
            
            
        end
        if(out1)
        begin
            if(start_h)
            begin
                start_h <=1'b0;
            end
            if(~done_h)
            begin
                x <= out_x_h;
            end
            else
            begin
                out1 <= 1'b0;
                clk_enb_h <= 1'b0;
            end
                      
        end
        
        
   end
   functiongeneratory ff(
        .x0(start_x), .y0(start_y), .x1(end_x), .y1(end_y),
        .clk(clk),
        .clk_enb(clk_enb_f),
        .start(start_f),
        .x(x_f), .y(y_f),
        .done(done_f)   
   );
   horizontal hl(
        .start_x(h_x0),.end_x(h_x1),
        .start(start_h),
        .clk(clk),
        .clk_enb(clk_enb_h),
        .done(done_h),
        .out_x(out_x_h)
   
   );
         
endmodule
