`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2024 03:53:54 PM
// Design Name: 
// Module Name: VALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Vector ALU that performs element-wise operations on 16-element 
//              vectors with each element being 32-bit wide.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module VALU(
    input [31:0] A0,A1,A2,A3,A4,A5,A6,A7,  // Vector A with 16 elements
    input [31:0] B0,B1,B2,B3,B4,B5,B6,B7,  // Vector B with 16 elements
    input [3:0] Op,        // Operation selector
    output wire [31:0] out0,out1,out2,out3,out4,out5,out6,out7,  // Vector output with 16 elements
    output wire [7:0] ng,  // Negative flags for each element
    output wire [7:0] zr   // Zero flags for each element
    );

    
     SALU  (.A(A0),.B(B0), .Op(Op), .out(out0), .ng(ng[0]), .zr(zr[0]));
     SALU  (.A(A1),.B(B1), .Op(Op), .out(out1), .ng(ng[1]), .zr(zr[1]));
     SALU  (.A(A2),.B(B2), .Op(Op), .out(out2), .ng(ng[2]), .zr(zr[2]));
     SALU  (.A(A3),.B(B3), .Op(Op), .out(out3), .ng(ng[3]), .zr(zr[3]));
     SALU  (.A(A4),.B(B4), .Op(Op), .out(out4), .ng(ng[4]), .zr(zr[4]));
     SALU  (.A(A5),.B(B5), .Op(Op), .out(out5), .ng(ng[5]), .zr(zr[5]));
     SALU  (.A(A6),.B(B6), .Op(Op), .out(out6), .ng(ng[6]), .zr(zr[6]));
     SALU  (.A(A7),.B(B7), .Op(Op), .out(out7), .ng(ng[7]), .zr(zr[7]));
      

endmodule
