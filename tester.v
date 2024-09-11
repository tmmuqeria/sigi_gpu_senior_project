`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2024 05:05:20 PM
// Design Name: 
// Module Name: tester
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


module tester(
        input [31:0] in_data,
        input read, write,
        input clk,
        input [7:0] read_adr, write_adr,
        output reg [31:0] out_data
    );
    
    reg [31:0] mem [7:0];
    always @ (clk)
    begin
        if(read)
        begin
            out_data <= mem[read_adr];
        end
        if(write)
        begin
            mem[write_adr] <= in_data;
        end
    end
    
endmodule
