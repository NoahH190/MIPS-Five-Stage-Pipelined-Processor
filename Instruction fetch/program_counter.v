module program_counter (
    input i_clk,
    input i_reset,
    input [31:0] i_branch_address_2,
    output reg [31:0] o_pc
);

reg [31: 0] r_pc; 

always @(posedge i_clk or posedge reset) begin
    if (reset == 1'b1) r_pc <= 0; 
    else r_pc <= i_pc; 
end 

assign o_pc <= r_pc; 

endmodule