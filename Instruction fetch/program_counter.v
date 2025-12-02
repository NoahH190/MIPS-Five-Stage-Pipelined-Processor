module program_counter (
    input  wire        i_clk,
    input  wire        i_reset,
    input  wire [31:0] i_br_address_2,
    output reg  [31:0] o_pc
);

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset)
            o_pc <= 32'd0;
        else
            o_pc <= i_br_address_2;
    end

endmodule