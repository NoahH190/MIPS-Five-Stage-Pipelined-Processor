module alu_mux (
    input  wire [5:0]  i_sel_alu,
    input  wire [31:0] i_sign_extend,
    input  wire [31:0] i_src2,
    output wire [31:0] o_alu_mux
);

    assign o_alu_mux = (i_sel_alu == 6'b000000 || i_sel_alu == 6'b000100) ? i_src2 : i_sign_extend;

endmodule

