module pcjump_mux (
    input i_clk,
    input i_reset,
    input [31:0] i_pc,
    output reg [31:0] o_pc
);