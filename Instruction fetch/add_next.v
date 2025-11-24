module add_next (
    input i_pc,
    output reg [31:0] o_add_next
);

assign o_add_next = i_pc + 4;

endmodule