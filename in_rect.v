`timescale 1ns / 1ps


module in_rect(
        input wire [9:0] x,y,
        input wire [9:0] rect_x, rect_y, rect_w, rect_h,
        input wire active,
        output wire present
    );
    
    wire signed [10:0] rl_x, du_y, xx, yy, rect_xx, rect_yy;
    assign rl_x = rect_xx + {1'b0,rect_w};
    assign du_y = rect_yy + {1'b0,rect_h};
    assign xx ={1'b0,x};
    assign yy ={1'b0,y};
    assign rect_xx ={1'b0,rect_x};
    assign rect_yy ={1'b0,rect_y};
    
    
    assign present = active && ((xx < rl_x && xx >= rect_xx)&&(yy < du_y && yy >= rect_yy));
       
    
endmodule
