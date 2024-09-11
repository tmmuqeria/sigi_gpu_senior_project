`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2024 06:30:48 PM
// Design Name: 
// Module Name: Tile
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


module Tile(
        input [2:0] y,
        input [2:0] x,
        input [2:0] write_y,
        input [2:0] write_x,
        input [23:0] v,
        input clk,
        input w,
        input r,
        input active,
        output reg [23:0] o

    );
    reg [23:0] tile[63:0];
    wire [5:0]addr;
    wire [5:0]write_addr;
    assign addr = {y,x};
    assign write_addr = {write_y,write_x};
    
    always @(posedge clk)
    begin
        if(active)
        begin
            if(w)
            begin
                tile[write_addr] = v;
            end
            if(r)
            begin
                o = tile[addr];
            end
        end    
    end
    
endmodule
