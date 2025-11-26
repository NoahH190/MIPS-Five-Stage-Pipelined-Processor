module memory_to_reg ( 
    input [31:0] i_mem_data,
    output reg [31:0] o_reg_data
)

assign o_reg_data = i_mem_data;

endmodule