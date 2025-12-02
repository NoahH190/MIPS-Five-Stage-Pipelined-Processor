module add_brn (
    input  wire [31:0] i_address,
    input  wire [31:0] i_add_next,
    input  wire        i_se_crtl,
    output wire [31:0] o_br_address
);

    // compute branch target: add shifted immediate to next PC
    assign o_br_address = i_add_next + i_address;

endmodule
