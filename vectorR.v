`timescale 1ns / 1ps
module vectorR(
    input [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15,
    input load,
    output reg [31:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15
    );

    always @(posedge load) begin
        out0 <= in0;
        out1 <= in1;
        out2 <= in2;
        out3 <= in3;
        out4 <= in4;
        out5 <= in5;
        out6 <= in6;
        out7 <= in7;
        out8 <= in8;
        out9 <= in9;
        out10 <= in10;
        out11 <= in11;
        out12 <= in12;
        out13 <= in13;
        out14 <= in14;
        out15 <= in15;
    end
endmodule
