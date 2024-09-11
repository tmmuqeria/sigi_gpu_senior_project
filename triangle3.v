`timescale 1ns / 1ps

module triangle3(
        input wire [15:0] x_0,y_0,
        input wire [15:0] x_1,y_1,
        input wire [15:0] x_2,y_2,
        input wire start,
        input wire clk,
        output reg done,
        output reg [15:0] x,y
    );

    wire [31:0] dy_01, dy_12, dy_02;
    wire [31:0] dx_01, dx_12, dx_02;
    wire [31:0] db_01, db_12, db_02;

    assign dy_01 = y_1-y_0;
    assign dy_12 = y_2-y_1;
    assign dy_02 = y_2-y_0;

    assign dx_01 = x_1-x_0;
    assign dx_12 = x_2-x_1;
    assign dx_02 = x_2-x_0;

    assign db_01 = {16'd0, y_0} * dx_01 - dy_01 * {16'd0, x_0};
    assign db_12 = {16'd0, y_1} * dx_12 - dy_12 * {16'd0, x_1};
    assign db_02 = {16'd0, y_0} * dx_02 - dy_02 * {16'd0, x_0};
    reg [31:0] cur_x, bot_y,top_y ;
    wire [31:0] next_x;
    assign next_x = cur_x + 32'd1;
    wire [31:0] yy01, yy12, yy02;
    assign yy01 = (dy_01*next_x+db_01)/dx_01;
    assign yy12 = (dy_12*next_x+db_12)/dx_12;
    assign yy02 = (dy_02*next_x+db_02)/dx_02;
    reg out;
    initial
    begin
        out <= 1'b0;
        cur_x <= 32'd0;
        bot_y <= 32'd0;
        top_y <= 32'd0;
    end
    always @(posedge clk)
    begin
        if(start & ~out)
        begin
            cur_x <= x_0;
            bot_y <= y_0;
            top_y <= y_0;
            out <= 1'b1;
            done <= 1'b0;
   
        end
        if(out)
        begin            
            x <= cur_x[15:0];
            y <= bot_y[15:0];
            
            if ((bot_y >= top_y))
            begin
                cur_x <= cur_x + 32'd1;
                if(next_x < x_1)
                begin
                    if (yy02>yy01)
                    begin
                        top_y <= yy02;
                        bot_y <= yy01;
                    end
                    else
                    begin
                        top_y <= yy01;
                        bot_y <= yy02;
                    end
                end
                
                else if(next_x <= x_2)
                begin
                    if(yy02>yy12)
                    begin
                        top_y <= yy02;
                        bot_y <= yy12;
                    end
                    else
                    begin
                        top_y <= yy12;
                        bot_y <= yy02;
                    end
                
                end
                else
                begin
                    out <= 1'b0;
                    done <= 1'b1;
                end
                
            end
            else
            begin
                bot_y <= bot_y +32'd1;
            end
        end
    end
endmodule