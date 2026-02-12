// File mux4_tb.v
`timescale 1ns/1ps
module mux4_tb();
    // mux4 localparam
    localparam WIDTH = 8;
    // mux4 ports
    // `reg` for inputs
    // `wire` for outputs
    reg [WIDTH-1:0] d0_i;
    reg [WIDTH-1:0] d1_i;
    reg [WIDTH-1:0] d2_i;
    reg [WIDTH-1:0] d3_i;
    reg [1:0] sel_i;
    wire [WIDTH-1:0] res_o;
    
    // mux4 instance
    mux4 #(
        .WIDTH(WIDTH)
    ) mux4_inst (
        .d0_i (d0_i ),
        .d1_i (d1_i ),
        .d2_i (d2_i ),
        .d3_i (d3_i ),
        .sel_i(sel_i),
        .res_o(res_o)
    );

    // testbench logic
    initial begin
        $dumpvars; // For waveforms
        d0_i = 8'hAA;
        d1_i = 8'hBB;
        d2_i = 8'hCC;
        d3_i = 8'hDD;
        sel_i = 2'b00;
        #10;
        sel_i = 2'b01;
        #10;
        sel_i = 2'b10;
        #10;
        sel_i = 2'b11;
        #10;
        $finish;
    end
endmodule