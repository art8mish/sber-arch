`timescale 1ns/1ps

module cnt_en_clr_tb();
    localparam CNT_WIDTH = 2;

    reg clk_i;
    reg arstn_i;
    reg cnt_en_i;
    reg cnt_clr_i;
    
    wire [CNT_WIDTH-1:0] cnt_o;
    wire ovf_o;

    cnt_en_clr #(
        .CNT_WIDTH(CNT_WIDTH)
    ) cnt_en_clr_inst (
        .clk_i    (clk_i    ),
        .arstn_i  (arstn_i  ),
        .cnt_en_i (cnt_en_i ),
        .cnt_clr_i(cnt_clr_i),

        .cnt_o (cnt_o),
        .ovf_o (ovf_o)
    );

    always begin
        clk_i = 1'b0; #1;
        clk_i = 1'b1; #1;
    end

    initial begin
        $dumpvars;
        arstn_i   = 1'b1;
        cnt_en_i  = 1'b0;
        cnt_clr_i = 1'b0;

        @(posedge clk_i); #0.5;
        arstn_i = 1'b0;

        @(posedge clk_i); #0.5;
        arstn_i = 1'b1;

        @(posedge clk_i); #0.5;
        cnt_en_i  = 1'b1; #2;
        @(posedge clk_i);
        @(posedge clk_i); #0.5;
        cnt_en_i  = 1'b0; #2;
        @(posedge clk_i); #0.5;
        cnt_en_i  = 1'b1;

        @(posedge clk_i); #0.5;
        cnt_clr_i  = 1'b1;
        @(posedge clk_i); #1.5;
        cnt_clr_i  = 1'b0; #10;
        @(posedge clk_i); #0.5;
        $finish;
    end


endmodule