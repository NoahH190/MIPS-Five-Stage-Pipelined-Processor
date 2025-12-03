module and_gate (
    input  wire [5:0] i_opcode, 
    input  wire       i_zero,   // From ALU (1 if subtraction result is 0)
    output wire       o_and     // Output to PC Branch Mux Select
);

    // 1. Decode: Check if the instruction is BEQ (Opcode: 000100)
    wire is_beq_instruction;
    assign is_beq_instruction = (i_opcode == 6'b000100);

    // 2. Gate: Signal branch only if it is a BEQ instruction AND Zero flag is high
    assign o_and = is_beq_instruction & i_zero;

endmodule