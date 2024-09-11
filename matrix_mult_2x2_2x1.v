`timescale 1ns / 1ps

// A x = b
// (A11 A12) (x1) = (b1)
// (A21 A22) (x2)   (b2)
module matrix_mult_2x2_2x1 (
    input wire signed [19:0] A11, A21, A12, A22, x1, x2,
    output wire signed [39:0] b1, b2
);
    assign b1 = x1*A11 + x2*A12;
    assign b2 = x1*A21 + x2*A22;
    
endmodule