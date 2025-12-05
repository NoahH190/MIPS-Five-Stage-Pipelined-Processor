module pc_increment (
    input  wire [31:0] i_pc,
    output wire [31:0] o_pc_increment
);

assign o_pc_increment = i_pc + 4;

endmodule