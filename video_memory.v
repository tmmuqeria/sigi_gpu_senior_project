`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2024 10:19:34 PM
// Design Name: 
// Module Name: video_memory
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


module video_memory(
        input wire [9:0] vx0,vy0, x0,y0,x1,y1,
        input wire clk,
        input wire vr0,
        input wire w0,w1,
        input wire [23:0]v0,v1,
        output reg [23:0]vo
        
    );
    wire [19:0] vadr,adr,adr1;
    
   (* ram_style = "block" *) reg [23:0] emvram [76799:0]; 
   always@(posedge clk)
    begin
        if(vr0)
        begin 
            vo = emvram[vadr];
        end
        if(w0)
        begin
            emvram[adr] = v0;
        end
        if(w1)
        begin
            emvram[adr1] = v1;
        end
        
        
    end
    assign adr = (x0 & 10'b1111111110)+(y0 & 10'b1111111110)*10'd640;
    assign adr1 = (x1 & 10'b1111111110)+(y1 & 10'b1111111110)*10'd640;
    assign vadr = (vx0 & 10'b1111111110)+(vy0 & 10'b1111111110)*10'd640; 
    
endmodule
