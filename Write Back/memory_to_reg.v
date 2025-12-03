
module memory_to_reg ( 
    input  wire [31:0] i_memory_data,
    input  wire [31:0] i_alu_result,
    input  wire [5:0]  i_opcode,
    output wire [31:0] o_wb_data
);

    // Placeholder: select ALU result by default. Replace with opcode-based selection.
    assign o_wb_data = i_alu_result;

endmodule
