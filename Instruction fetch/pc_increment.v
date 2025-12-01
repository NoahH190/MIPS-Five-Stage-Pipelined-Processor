module add_next (
    input i_pc,
    output reg [31:0] o_pc_increment
);

assign o_pc_increment = i_pc + 4;

endmodule