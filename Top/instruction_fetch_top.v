module instruction_fetch_top (
    input i_clk,
    input i_reset,
    input o_br_addr_calc,
    input o_zero, 
    input o_opcode,
    input i_instruction,
    input i_read,
    input i_write,
    output o_pc_increment,
    output [31:0] o_instruction,
);