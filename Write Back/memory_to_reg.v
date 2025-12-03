
module memory_to_reg ( 
    input  wire [31:0] i_memory_data,
    input  wire [31:0] i_alu_result,
    input  wire [5:0]  i_opcode,
    output wire [31:0] o_wb_data
);

    assign o_wb_data = (i_opcode == 6'b100011) ? i_memory_data : i_alu_result;

endmodule
