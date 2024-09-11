

module functiongeneratory
    #( parameter size = 16)
    (
        input wire [size-1:0] x0, y0, x1, y1,
        input wire clk,
        input wire clk_enb,
        input wire start,
        output wire [size-1:0] x, y,
        output wire done
     );
     
     //
     wire [size-1:0] xx1,xx2,yy1,yy2,difx,dify,mdifx,mdify,dbg1,dbg2;
     wire done1,done2;
     assign difx = (x1-x0);
     assign mdifx = difx[size-1]?-difx:difx;
     assign dify = (y1-y0);
     assign mdify = dify[size-1]?-dify:dify;
     functiongenerator fx(
            .x0(x0),
            .y0(y0),
            .x1(x1),
            .y1(y1),
            .clk(clk),
            .clk_enb(clk_enb),
            .start(start),
            .done(done1),
            .y(yy1),
            .x(xx1)
        );
    functiongenerator fy(
            .x0(y0),
            .y0(x0),
            .x1(y1),
            .y1(x1),
            .clk(clk),
            .clk_enb(clk_enb),
            .start(start),
            .done(done2),
            .y(xx2),
            .x(yy2)
        );
   assign x = mdifx>mdify? xx1:xx2;
   assign y = mdifx>mdify? yy1:yy2;
   assign done = mdifx>mdify? done1:done2;
     
     
endmodule     