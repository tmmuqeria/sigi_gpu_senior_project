`timescale 1ns / 1ps

// (c) fpga4fun.com & KNJN LLC 2013
// edited/updated for vivado 2020.1 by Dominic Meads 10/2020

////////////////////////////////////////////////////////////////////////
module HDMI_test(
	input clk,  // 125MHz
	//input valll,
	input [7:0]vr,
	input [7:0]vg,
	input [7:0]vb,
	output [2:0] TMDSp, TMDSn,
	output TMDSp_clock, TMDSn_clock,
	output reg [9:0] xout,yout,
	output reg r
);

////////////////////////////////////////////////////////////////////////
// clk divider 125 MHz to 25 MHz pixclk, and multiplier 125 MHz to 250 MHz
wire MMCM_pix_clock, pixclk;
wire clk_TMDS, DCM_TMDS_CLKFX;
wire clkfb_in, clkfb_out;

   // MMCME2_BASE: Base Mixed Mode Clock Manager
   //              Artix-7
   // Xilinx HDL Language Template, version 2020.1

   MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(6.0),     // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(8.0),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(30),  // 125*6/30 = 25 MHz
      .CLKOUT2_DIVIDE(3),   // 125*6/3  = 250 MHz
      .CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT0_DIVIDE_F(1.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(1),         // Master division value (1-106)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME2_BASE_INST (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(CLKOUT0),     // 1-bit output: CLKOUT0
      .CLKOUT0B(CLKOUT0B),   // 1-bit output: Inverted CLKOUT0
      .CLKOUT1(MMCM_pix_clock),     // 1-bit output: CLKOUT1
      .CLKOUT1B(CLKOUT1B),   // 1-bit output: Inverted CLKOUT1
      .CLKOUT2(DCM_TMDS_CLKFX),     // 1-bit output: CLKOUT2
      .CLKOUT2B(CLKOUT2B),   // 1-bit output: Inverted CLKOUT2
      .CLKOUT3(CLKOUT3),     // 1-bit output: CLKOUT3
      .CLKOUT3B(CLKOUT3B),   // 1-bit output: Inverted CLKOUT3
      .CLKOUT4(CLKOUT4),     // 1-bit output: CLKOUT4
      .CLKOUT5(CLKOUT5),     // 1-bit output: CLKOUT5
      .CLKOUT6(CLKOUT6),     // 1-bit output: CLKOUT6
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(clkfb_in),   // 1-bit output: Feedback clock
      .CLKFBOUTB(CLKFBOUTB), // 1-bit output: Inverted CLKFBOUT
      // Status Ports: 1-bit (each) output: MMCM status ports
      .LOCKED(LOCKED),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(clk),       // 1-bit input: Clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(PWRDWN),       // 1-bit input: Power-down
      .RST(1'b0),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clkfb_out)      // 1-bit input: Feedback clock
   );

   // End of MMCME2_BASE_inst instantiation

// clock buffers
   // BUFG: Global Clock Simple Buffer
   //       Artix-7
   // Xilinx HDL Language Template, version 2020.1

   BUFG BUFG_pixclk (
      .O(pixclk), // 1-bit output: Clock output
      .I(MMCM_pix_clock)  // 1-bit input: Clock input
   );
   
   // BUFG: Global Clock Simple Buffer
   //       Artix-7
   // Xilinx HDL Language Template, version 2020.1

   BUFG BUFG_TMDSp (
      .O(clk_TMDS), // 1-bit output: Clock output
      .I(DCM_TMDS_CLKFX)  // 1-bit input: Clock input
   );
   
   // BUFG: Global Clock Simple Buffer
   //       Artix-7
   // Xilinx HDL Language Template, version 2020.1

   BUFG BUFG_CLKFB (
      .O(clkfb_out), // 1-bit output: Clock output
      .I(clkfb_in)  // 1-bit input: Clock input
   );

   // End of BUFG_inst instantiation
// end clk divider to 25 MHz pixclk

////////////////////////////////////////////////////////////////////////
// counter and sync generation
reg [9:0] CounterX = 0, CounterY = 0;
reg hSync, vSync, DrawArea;

always @(posedge pixclk)
    begin  
        DrawArea <= (CounterX<640) && (CounterY<480);           // define picture dimensions for 640x480 (off-screen data 800x525)
        CounterX <= (CounterX==799) ? 0 : CounterX+1;           // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
        if(CounterX==799) 
            CounterY <= (CounterY==524) ? 0 : CounterY+1;       /* vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
                                                                   only counts up 1 count after horizontal finishes. */                                                          
        hSync <= (CounterX>=656) && (CounterX<752);         // hsync high for 96 counts                                                 
        vSync <= (CounterY>=490) && (CounterY<492);         // vsync high for 2 counts
    end
// end counter and sync generation  

///////////////////////////////////////////////////////////////////////
// color generation (not part of HDMI standard, jsut for generating some patterns)
wire [7:0] W = {8{CounterX[7:0]==CounterY[7:0]}};                     
wire [7:0] A = {8{CounterX[7:5]==3'h2 && CounterY[7:5]==3'h2}};
reg [7:0] red, green, blue;
reg [7:0] redb, greenb, blueb;
reg  redbb, greenbb, bluebb;

always @(posedge pixclk)
begin
    if(CounterX < 639 & CounterY < 479)
    begin
        xout <= CounterX + 1;
        yout <= CounterY;
        r<=1'b1;
    end else if(CounterX == 639 & CounterY != 479)
    begin
        xout <= 10'd0;
        yout <= CounterY + 10'd1;
        r<=1'b1;
    end else if (CounterX == 639 & CounterY == 479)
    begin
        xout <= 10'd0;
        yout <= 10'd0;
        r<=1'b1;
    end else
    begin
        r<=1'b0;
    end
    
end

always @(posedge pixclk) 
    red <= vr;
    
always @(posedge pixclk) 
    green <= vg;
    
always @(posedge pixclk) 
    blue <= vb;
// end color generation

////////////////////////////////////////////////////////////////////////
// 8b/10b encoding for transmission
wire [9:0] TMDS_red, TMDS_green, TMDS_blue;

// instantiate TMDS encoders (TMDS_encoder.vhd file from github)
TMDS_encoder encode_R(.clk(pixclk), .VD(red  ), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_red));
TMDS_encoder encode_G(.clk(pixclk), .VD(green), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_green));
TMDS_encoder encode_B(.clk(pixclk), .VD(blue ), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));   // I think HDMI standard says both "sync" signals are sent over the "blue" line control inputs
// end 8b/10b encoding

////////////////////////////////////////////////////////////////////////
// Serializer and output buffers
reg [3:0] TMDS_mod10=0;  // modulus 10 counter
reg [9:0] TMDS_shift_red=0, TMDS_shift_green=0, TMDS_shift_blue=0;
reg TMDS_shift_load=0;

always @(posedge clk_TMDS) 
    TMDS_shift_load <= (TMDS_mod10==4'd9);  // shift load is high only if mod ten counter is done

always @(posedge clk_TMDS)
    begin
        TMDS_shift_red   <= TMDS_shift_load ? TMDS_red   : TMDS_shift_red  [9:1];  // only if all the old data has been serialized, then start shifting new data
        TMDS_shift_green <= TMDS_shift_load ? TMDS_green : TMDS_shift_green[9:1];  // kind of a wierd way of shifting but it works. replacing the last shift data with the MSB:LSB+1
        TMDS_shift_blue  <= TMDS_shift_load ? TMDS_blue  : TMDS_shift_blue [9:1];	
        TMDS_mod10 <= (TMDS_mod10==4'd9) ? 4'd0 : TMDS_mod10+4'd1;                 // increase counter or reset after 10 counts
    end

// instantiate differential output buffers
   // OBUFDS: Differential Output Buffer
   //         Artix-7
   // Xilinx HDL Language Template, version 2020.1
   
   OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_red (
      .O(TMDSp[2]),     // Diff_p output (connect directly to top-level port)
      .OB(TMDSn[2]),   // Diff_n output (connect directly to top-level port)
      .I(TMDS_shift_red[0])      // Buffer input
   );

   // End of OBUFDS_inst instantiation
   
   // OBUFDS: Differential Output Buffer
   //         Artix-7
   // Xilinx HDL Language Template, version 2020.1
   
   OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_green (
      .O(TMDSp[1]),     // Diff_p output (connect directly to top-level port)
      .OB(TMDSn[1]),   // Diff_n output (connect directly to top-level port)
      .I(TMDS_shift_green[0])      // Buffer input
   );

   // End of OBUFDS_inst instantiation

   // OBUFDS: Differential Output Buffer
   //         Artix-7
   // Xilinx HDL Language Template, version 2020.1

   OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_blue (
      .O(TMDSp[0]),     // Diff_p output (connect directly to top-level port)
      .OB(TMDSn[0]),   // Diff_n output (connect directly to top-level port)
      .I(TMDS_shift_blue[0])      // Buffer input
   );

   // End of OBUFDS_inst instantiation
   // OBUFDS: Differential Output Buffer
   //         Artix-7
   // Xilinx HDL Language Template, version 2020.1

   OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_clock (
      .O(TMDSp_clock),     // Diff_p output (connect directly to top-level port)
      .OB(TMDSn_clock),   // Diff_n output (connect directly to top-level port)
      .I(pixclk)      // Buffer input
   );

   // End of OBUFDS_inst instantiation
// end serializer and output buffers

endmodule  // HDMI_test

`timescale 1ns / 1ps
// (c) fpga4fun.com & KNJN LLC 2013

////////////////////////////////////////////////////////////////////////
module TMDS_encoder(
	input clk,
	input [7:0] VD,  // video data (red, green or blue)
	input [1:0] CD,  // control data
	input VDE,  // video data enable, to choose between CD (when VDE=0) and VD (when VDE=1)
	output reg [9:0] TMDS = 0
);

wire [3:0] Nb1s = VD[0] + VD[1] + VD[2] + VD[3] + VD[4] + VD[5] + VD[6] + VD[7];
wire XNOR = (Nb1s>4'd4) || (Nb1s==4'd4 && VD[0]==1'b0);
wire [8:0] q_m = {~XNOR, q_m[6:0] ^ VD[7:1] ^ {7{XNOR}}, VD[0]};

reg [3:0] balance_acc = 0;
wire [3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7] - 4'd4;
wire balance_sign_eq = (balance[3] == balance_acc[3]);
wire invert_q_m = (balance==0 || balance_acc==0) ? ~q_m[8] : balance_sign_eq;
wire [3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance==0 || balance_acc==0));
wire [3:0] balance_acc_new = invert_q_m ? balance_acc-balance_acc_inc : balance_acc+balance_acc_inc;
wire [9:0] TMDS_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
wire [9:0] TMDS_code = CD[1] ? (CD[0] ? 10'b1010101011 : 10'b0101010100) : (CD[0] ? 10'b0010101011 : 10'b1101010100);

always @(posedge clk) TMDS <= VDE ? TMDS_data : TMDS_code;
always @(posedge clk) balance_acc <= VDE ? balance_acc_new : 4'h0;
endmodule


////////////////////////////////////////////////////////////////////////
