module cnt_en_clr #(
    parameter CNT_WIDTH = 2
) (
    input clk_i,
    input arstn_i,
    input cnt_en_i,
    input cnt_clr_i,
    
    output [CNT_WIDTH-1:0] cnt_o,
    output ovf_o
);
    reg [CNT_WIDTH:0] cnt_ff;

    always @(posedge clk_i or negedge arstn_i) begin
        if (!arstn_i | cnt_clr_i) begin
            cnt_ff <= {CNT_WIDTH+1{1'b0}};
        end else begin
            cnt_ff <= cnt_en_i ? cnt_ff + 1 : cnt_ff;
        end
    end

    assign {ovf_o, cnt_o} = cnt_ff;
endmodule