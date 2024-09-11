`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2024 02:35:03 PM
// Design Name: 
// Module Name: bresenham_line
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Bresenham's Line Drawing Algorithm
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module functiongenerator
    #( parameter size = 16)
    (
        input [size-1:0] x0, y0, x1, y1,
        input clk,
        input clk_enb,
        input start,
        output reg [size-1:0] x, y,
        output reg done
        
    );
    wire [size-1:0] nx0,nx1,ny0,ny1;
    
    assign nx0 = (x0<x1)? x0: x1;
    assign ny0 = (x0<x1)? y0: y1;
    
    assign nx1 = (x0<x1)? x1: x0;
    assign ny1 = (x0<x1)? y1: y0;
    reg [size-1:0] cur_x, cur_y, delta_y, delta_x;
    reg out;
    reg [size-1:0]d;
    reg [size-1:0]dbg;
    reg [size-1:0]dbg2;
    reg [size-1:0] const;
    initial
    begin
    done=1'b1;
    end
    
    always @(posedge clk) begin
        if(clk_enb)
        begin
        if(start & ~out)
        begin
                dbg2=ny1-ny0;
                if(dbg2!=0&(~dbg2[size-1]))
                begin 
                    d=16'd1;
                end else
                begin 
                    if((dbg2)==0)
                    begin
                        d=16'd0;
                    end else
                    begin 
                        d=-16'd1;
                    end
                end
                if (~d[size-1])
                begin
                    const = (((ny0*nx1)-(ny1*nx0))<<1 );
                    
                end else 
                begin
                    const = (((ny1*nx0)-(ny0*nx1))<<1 );
                    
                end
                
                delta_y=d*2*(ny1-ny0);
                delta_x=d*2*(nx1-nx0);
                done<=1'b0;
                out<=1'b1;
                cur_x<=nx0;
                cur_y<=ny0;
    
        end
        if(out) begin
                x=cur_x;
                y=cur_y;
                if(cur_x==nx1)begin
                    out=1'b0;
                   done=1'b1;
                end
                cur_x=cur_x+1;
                dbg = ((const+nx0-nx1+delta_y*cur_x-delta_x*cur_y));
                if (~dbg[size-1]&&dbg!=0)
                begin
                    cur_y=cur_y+d;
                end
            
            
        end
        end
    
    end

endmodule
