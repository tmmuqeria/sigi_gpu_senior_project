`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2024 06:27:49 PM
// Design Name: 
// Module Name: Tiles
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


module Tiles(
        input [2:0]x,
        input [2:0]y,
        input [2:0] write_y,
        input [2:0] write_x,
        input [5:0] write_adr,
        input [5:0]adr,
        input r,
        input clk,
        input w,
        input [23:0]v,
        output [23:0]o

    );
    wire [23:0] out [63:0];
    assign o=out[adr];
Tile t0(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd0),
        .r(r&adr==6'd0),
        .o(out[0]),
        .active(adr==6'd0|write_adr==6'd0)
    );   
Tile t1(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd1),
        .r(r&adr==6'd1),
        .o(out[1]),
        .active(adr==6'd1|write_adr==6'd1)
    );   
Tile t2(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd2),
        .r(r&adr==6'd2),
        .o(out[2]),
        .active(adr==6'd2|write_adr==6'd2)
    );   
Tile t3(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd3),
        .r(r&adr==6'd3),
        .o(out[3]),
        .active(adr==6'd3|write_adr==6'd3)
    );   
Tile t4(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd4),
        .r(r&adr==6'd4),
        .o(out[4]),
        .active(adr==6'd4|write_adr==6'd4)
    );   
Tile t5(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd5),
        .r(r&adr==6'd5),
        .o(out[5]),
        .active(adr==6'd5|write_adr==6'd5)
    );   
Tile t6(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd6),
        .r(r&adr==6'd6),
        .o(out[6]),
        .active(adr==6'd6|write_adr==6'd6)
    );   
Tile t7(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd7),
        .r(r&adr==6'd7),
        .o(out[7]),
        .active(adr==6'd7|write_adr==6'd7)
    );   
Tile t8(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd8),
        .r(r&adr==6'd8),
        .o(out[8]),
        .active(adr==6'd8|write_adr==6'd8)
    );   
Tile t9(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd9),
        .r(r&adr==6'd9),
        .o(out[9]),
        .active(adr==6'd9|write_adr==6'd9)
    );   
Tile t10(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd10),
        .r(r&adr==6'd10),
        .o(out[10]),
        .active(adr==6'd10|write_adr==6'd10)
    );   
Tile t11(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd11),
        .r(r&adr==6'd11),
        .o(out[11]),
        .active(adr==6'd11|write_adr==6'd11)
    );   
Tile t12(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd12),
        .r(r&adr==6'd12),
        .o(out[12]),
        .active(adr==6'd12|write_adr==6'd12)
    );   
Tile t13(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd13),
        .r(r&adr==6'd13),
        .o(out[13]),
        .active(adr==6'd13|write_adr==6'd13)
    );   
Tile t14(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd14),
        .r(r&adr==6'd14),
        .o(out[14]),
        .active(adr==6'd14|write_adr==6'd14)
    );   
Tile t15(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd15),
        .r(r&adr==6'd15),
        .o(out[15]),
        .active(adr==6'd15|write_adr==6'd15)
    );   
Tile t16(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd16),
        .r(r&adr==6'd16),
        .o(out[16]),
        .active(adr==6'd16|write_adr==6'd16)
    );   
Tile t17(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd17),
        .r(r&adr==6'd17),
        .o(out[17]),
        .active(adr==6'd17|write_adr==6'd17)
    );   
Tile t18(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd18),
        .r(r&adr==6'd18),
        .o(out[18]),
        .active(adr==6'd18|write_adr==6'd18)
    );   
Tile t19(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd19),
        .r(r&adr==6'd19),
        .o(out[19]),
        .active(adr==6'd19|write_adr==6'd19)
    );   
Tile t20(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd20),
        .r(r&adr==6'd20),
        .o(out[20]),
        .active(adr==6'd20|write_adr==6'd20)
    );   
Tile t21(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd21),
        .r(r&adr==6'd21),
        .o(out[21]),
        .active(adr==6'd21|write_adr==6'd21)
    );   
Tile t22(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd22),
        .r(r&adr==6'd22),
        .o(out[22]),
        .active(adr==6'd22|write_adr==6'd22)
    );   
Tile t23(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd23),
        .r(r&adr==6'd23),
        .o(out[23]),
        .active(adr==6'd23|write_adr==6'd23)
    );   
Tile t24(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd24),
        .r(r&adr==6'd24),
        .o(out[24]),
        .active(adr==6'd24|write_adr==6'd24)
    );   
Tile t25(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd25),
        .r(r&adr==6'd25),
        .o(out[25]),
        .active(adr==6'd25|write_adr==6'd25)
    );   
Tile t26(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd26),
        .r(r&adr==6'd26),
        .o(out[26]),
        .active(adr==6'd26|write_adr==6'd26)
    );   
Tile t27(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd27),
        .r(r&adr==6'd27),
        .o(out[27]),
        .active(adr==6'd27|write_adr==6'd27)
    );   
Tile t28(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd28),
        .r(r&adr==6'd28),
        .o(out[28]),
        .active(adr==6'd28|write_adr==6'd28)
    );   
Tile t29(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd29),
        .r(r&adr==6'd29),
        .o(out[29]),
        .active(adr==6'd29|write_adr==6'd29)
    );   
Tile t30(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd30),
        .r(r&adr==6'd30),
        .o(out[30]),
        .active(adr==6'd30|write_adr==6'd30)
    );   
Tile t31(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd31),
        .r(r&adr==6'd31),
        .o(out[31]),
        .active(adr==6'd31|write_adr==6'd31)
    );   
Tile t32(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd32),
        .r(r&adr==6'd32),
        .o(out[32]),
        .active(adr==6'd32|write_adr==6'd32)
    );   
Tile t33(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd33),
        .r(r&adr==6'd33),
        .o(out[33]),
        .active(adr==6'd33|write_adr==6'd33)
    );   
Tile t34(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd34),
        .r(r&adr==6'd34),
        .o(out[34]),
        .active(adr==6'd34|write_adr==6'd34)
    );   
Tile t35(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd35),
        .r(r&adr==6'd35),
        .o(out[35]),
        .active(adr==6'd35|write_adr==6'd35)
    );   
Tile t36(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd36),
        .r(r&adr==6'd36),
        .o(out[36]),
        .active(adr==6'd36|write_adr==6'd36)
    );   
Tile t37(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd37),
        .r(r&adr==6'd37),
        .o(out[37]),
        .active(adr==6'd37|write_adr==6'd37)
    );   
Tile t38(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd38),
        .r(r&adr==6'd38),
        .o(out[38]),
        .active(adr==6'd38|write_adr==6'd38)
    );   
Tile t39(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd39),
        .r(r&adr==6'd39),
        .o(out[39]),
        .active(adr==6'd39|write_adr==6'd39)
    );   
Tile t40(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd40),
        .r(r&adr==6'd40),
        .o(out[40]),
        .active(adr==6'd40|write_adr==6'd40)
    );   
Tile t41(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd41),
        .r(r&adr==6'd41),
        .o(out[41]),
        .active(adr==6'd41|write_adr==6'd41)
    );   
Tile t42(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd42),
        .r(r&adr==6'd42),
        .o(out[42]),
        .active(adr==6'd42|write_adr==6'd42)
    );   
Tile t43(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd43),
        .r(r&adr==6'd43),
        .o(out[43]),
        .active(adr==6'd43|write_adr==6'd43)
    );   
Tile t44(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd44),
        .r(r&adr==6'd44),
        .o(out[44]),
        .active(adr==6'd44|write_adr==6'd44)
    );   
Tile t45(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd45),
        .r(r&adr==6'd45),
        .o(out[45]),
        .active(adr==6'd45|write_adr==6'd45)
    );   
Tile t46(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd46),
        .r(r&adr==6'd46),
        .o(out[46]),
        .active(adr==6'd46|write_adr==6'd46)
    );   
Tile t47(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd47),
        .r(r&adr==6'd47),
        .o(out[47]),
        .active(adr==6'd47|write_adr==6'd47)
    );   
Tile t48(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd48),
        .r(r&adr==6'd48),
        .o(out[48]),
        .active(adr==6'd48|write_adr==6'd48)
    );   
Tile t49(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd49),
        .r(r&adr==6'd49),
        .o(out[49]),
        .active(adr==6'd49|write_adr==6'd49)
    );   
Tile t50(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd50),
        .r(r&adr==6'd50),
        .o(out[50]),
        .active(adr==6'd50|write_adr==6'd50)
    );   
Tile t51(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd51),
        .r(r&adr==6'd51),
        .o(out[51]),
        .active(adr==6'd51|write_adr==6'd51)
    );   
Tile t52(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd52),
        .r(r&adr==6'd52),
        .o(out[52]),
        .active(adr==6'd52|write_adr==6'd52)
    );   
Tile t53(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd53),
        .r(r&adr==6'd53),
        .o(out[53]),
        .active(adr==6'd53|write_adr==6'd53)
    );   
Tile t54(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd54),
        .r(r&adr==6'd54),
        .o(out[54]),
        .active(adr==6'd54|write_adr==6'd54)
    );   
Tile t55(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd55),
        .r(r&adr==6'd55),
        .o(out[55]),
        .active(adr==6'd55|write_adr==6'd55)
    );   
Tile t56(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd56),
        .r(r&adr==6'd56),
        .o(out[56]),
        .active(adr==6'd56|write_adr==6'd56)
    );   
Tile t57(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd57),
        .r(r&adr==6'd57),
        .o(out[57]),
        .active(adr==6'd57|write_adr==6'd57)
    );   
Tile t58(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd58),
        .r(r&adr==6'd58),
        .o(out[58]),
        .active(adr==6'd58|write_adr==6'd58)
    );   
Tile t59(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd59),
        .r(r&adr==6'd59),
        .o(out[59]),
        .active(adr==6'd59|write_adr==6'd59)
    );   
Tile t60(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd60),
        .r(r&adr==6'd60),
        .o(out[60]),
        .active(adr==6'd60|write_adr==6'd60)
    );   
Tile t61(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd61),
        .r(r&adr==6'd61),
        .o(out[61]),
        .active(adr==6'd61|write_adr==6'd61)
    );   
Tile t62(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd62),
        .r(r&adr==6'd62),
        .o(out[62]),
        .active(adr==6'd62|write_adr==6'd62)
    );   
Tile t63(
        .x(x),
        .y(y),
        .write_x(write_x),
        .write_y(write_y),
        .v(v),
        .clk(clk),
        .w(w&write_adr==6'd63),
        .r(r&adr==6'd63),
        .o(out[63]),
        .active(adr==6'd63|write_adr==6'd63)
    );   
    
    
    
endmodule
