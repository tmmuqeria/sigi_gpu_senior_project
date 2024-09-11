`timescale 1ns / 1ps


module in_circle(
        input wire [9:0] x,y,
        input wire [9:0] circle_x, circle_y, circle_rad,
        input wire active,
        output wire present
    );
    
    wire signed [10:0] dx,dy;
    assign dx = x - circle_x;
    assign dy = y - circle_y;
    wire [19:0] dx_square, dy_square;
    assign dx_square = dx * dx;
    assign dy_square = dy * dy;
    wire [19:0]circle_rad_square;
    assign circle_rad_square = circle_rad * circle_rad;
    assign present = active && (circle_rad_square >= dx_square + dy_square);
       
    
endmodule
