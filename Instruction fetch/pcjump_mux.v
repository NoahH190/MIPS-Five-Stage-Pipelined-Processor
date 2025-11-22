module pcjump_mux (
    input i_clk,
    input i_reset,
    input i_pc_jmp_sel,
    input [31:0] i_branch_address_1,
    input [31:0] i_jump_address,
    output [31:0] o_branch_address_2,
);