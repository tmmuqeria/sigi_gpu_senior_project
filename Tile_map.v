`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2024 06:07:08 PM
// Design Name: 
// Module Name: Tile_map
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


module Tile_map(
        input [5:0] y,
        input [6:0] x,
        input [5:0] write_y,
        input [6:0] write_x,
        input [5:0] v,
        input clk,
        input w,
        input r,
        output reg [5:0] o
    );
    reg [5:0] vtram [4799:0];// 60*80
    wire [12:0]addr;
    wire [12:0]write_addr;
    assign addr = (13'd80)*y+x;
    assign write_addr = (13'd80)*write_y+write_x;
    always @(posedge clk)
    begin
        if(w)
        begin
            vtram[write_addr] = v;
        end
        if(r)
        begin
            o = vtram[addr];
        end    
    end
    
    
    
endmodule
