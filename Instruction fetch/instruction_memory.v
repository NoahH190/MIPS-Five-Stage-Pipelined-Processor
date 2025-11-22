module instruction_memory(
    input i_clk,
    input i_reset,
    input i_read, //read signal
    input i_write, //write signal 
    input [31:0] i_pc,
    input [31:0] i_instruction,
    output reg [31:0] o_instruction
);
