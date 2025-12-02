module alu_mux (
    input  wire [5:0]  i_sel_alu,
    input  wire [31:0] i_sign_extend,
    input  wire [31:0] i_src2,
    output wire [31:0] o_alu_mux
);

    // Minimal behavior: select between sign-extended immediate and src2
    // For now, choose sign-extend when opcode LSB is 1 (placeholder)
    assign o_alu_mux = (i_sel_alu[0]) ? i_sign_extend : i_src2;

endmodule

