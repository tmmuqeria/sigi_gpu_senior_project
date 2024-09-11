`timescale 1ns / 1ps

module is_in_triangle (
    input wire [9:0] vertex_1x, vertex_1y,
    input wire [9:0] vertex_2x, vertex_2y,
    input wire [9:0] vertex_3x, vertex_3y,
    input wire [9:0] x, y,
    input wire active,

    output wire present
);

// resolution: 640x480
// we are using Barycentric coordinate method
// (e1.e1 e1.e2) (beta)   ((P-a).e1)           (beta)
// (           ) (    ) = (        )    ---> A (    )
// (e1.e2 e2.e2) (gama)   ((P-a).e2)           (gama)

// A_det = (e1x e2y - e1y e2x)^2
// a = (x1, y1)
// b = (x2, y2)
// c = (x3, y3)
// e1 = a -> b
// e2 = a -> c

    wire signed [10:0] e1x = vertex_2x - vertex_1x;
    wire signed [10:0] e1y = vertex_2y - vertex_1y;
    wire signed [10:0] e2x = vertex_3x - vertex_1x;
    wire signed [10:0] e2y = vertex_3y - vertex_1y;
    
    wire signed [22:0] A_det_sqrt = e1x*e2y - e1y*e2x;
    wire signed [45:0] A_det = A_det_sqrt * A_det_sqrt;  // >= 0
    
    wire signed [39:0] e1e1 = e1x*e1x + e1y*e1y;
    wire signed [39:0] e2e2 = e2x*e2x + e2y*e2y;
    
    wire signed [39:0] minus_e1e2 = -(e1x*e2x + e1y*e2y);
    
    // P = (x, y)
    
    wire signed [10:0] p_minus_ax = x - vertex_1x;
    wire signed [10:0] p_minus_ay = y - vertex_1y;
    
    wire signed [22:0] b1 = (p_minus_ax * e1x) + (p_minus_ay * e1y);
    wire signed [22:0] b2 = (p_minus_ax * e2x) + (p_minus_ay * e2y);
    
//    wire signed [39:0] A_det_beta, A_det_gamma;
    
//    matrix_mult_2x2_2x1 beta_and_gamma(
//        .A11(e2e2),
//        .A21(minus_e1e2),
//        .A12(minus_e1e2),
//        .A22(e1e1),
//        .x1(b1),
//        .x2(b2),
//        .b1(A_det_beta),
//        .b2(A_det_gamma)
//    );

    wire signed [45:0] A_det_beta = b1*e2e2 + b2*minus_e1e2;
    wire signed [45:0] A_det_gamma = b1*minus_e1e2 + b2*e1e1;

    assign present = (A_det_beta >= 0) && (A_det_gamma >= 0) && ((A_det_beta + A_det_gamma) <= A_det) && active;

endmodule