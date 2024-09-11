// File: linedraw.v
// This is the linedraw design for EE178 Lab #6.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module linedraw (
  input wire update,
  output wire busy,
  input wire [15:0] inx0,inx1,iny0,iny1,
  output wire [15:0] x,y,
  input wire clk
  );
    reg [15:0] x0,x1,y0,y1,
    assign x0 = (inx0<inx1) ? inx0:inx1;
    
    
    
endmodule