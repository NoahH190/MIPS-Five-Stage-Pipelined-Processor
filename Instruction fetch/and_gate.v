module and_gate (
    input  wire i_opcode,
    input  wire i_zero,
    output wire o_and
);

    assign o_and = i_opcode & i_zero;

endmodule