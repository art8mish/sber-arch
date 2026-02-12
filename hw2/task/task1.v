module shift_register_with_dac (
    input wire clk,
    input wire rst,
    output wire phi0,      
    output wire [2:0] u_out
);

    reg [4:0] q;

    initial begin
        q = 5'b11000;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 5'b11000;
        end else begin
            q <= {q[3:0], q[0] ^ q[4]};
        end
    end

    assign phi0 = q[4];
    assign u_out = q[0] + q[1] + q[2] + q[3] + q[4];

endmodule
