module alu_mux (
    input i_sel_alu,
    input [31:0] i_src1,
    input [31:0] i_src2,
    output reg [31:0] o_src2
);

assign o_src2 = i_sel_alu ? i_src2 : i_src1;

endmodule

