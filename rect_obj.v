`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2024 05:38:59 PM
// Design Name: 
// Module Name: rect_obj
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


module rect_obj(
        input [9:0] new_x,new_y,x,y,
        input setxy,
        input change_pxl,
        input [23:0] in,
        input clk,
        input active,
        output bool,// true if object is in boarder
        output reg [23:0] value//value of pixel if  it is true 
        
        
    );
    // 640, 480
    reg [9:0] cur_x, cur_y ;// upper left coordinate
    reg [23:0] obj[63:0];
    
    wire[5:0] adr;
    wire[2:0] dy,dx;
    assign dx =x-cur_x;
    assign dy = y-cur_y;
    assign adr = {dy[2:0],dx[2:0]};
    
    wire[5:0] new_adr;
    wire[2:0] new_dy,new_dx;
    assign new_dx =new_x-cur_x;
    assign new_dy = new_y-cur_y;
    assign new_adr = {new_dy[2:0],new_dx[2:0]};
    
    
    wire boolx,booly;
    assign boolx = (x>=cur_x&x<(cur_x+10'd8))? 1:0;
    assign booly = (y>=cur_y&y<(cur_y+10'd8))? 1:0;
    assign bool = (boolx&booly&active)?1:0;
    always @(posedge clk)
    begin
        if(bool)
        begin
            value<=obj[adr];
        end
    end
    
    always @(posedge clk)
    begin
        if(setxy)
        begin
            cur_x <=new_x;
            cur_y <=new_y;
        end
    end
    always @(posedge clk)
    begin
        if(change_pxl)
        begin
            obj[new_adr]=in;
        end
    end    
endmodule


