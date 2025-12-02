module instruction_decoder(
    input  wire [31:0] i_instruction,
    input  wire        i_clk,
    input  wire        i_reset,
    output reg  [15:0] o_address,
    output reg  [4:0]  o_RS,
    output reg  [4:0]  o_RT,
    output reg  [4:0]  o_RD,
    output reg  [5:0]  o_opcode,
    output reg  [5:0]  o_funct,
    output reg  [4:0]  o_shamt
);

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            o_address <= 16'd0;
            o_RS <= 5'd0;
            o_RT <= 5'd0;
            o_RD <= 5'd0;
            o_opcode <= 6'd0;
            o_funct <= 6'd0;
            o_shamt <= 5'd0;
        end else begin
            o_address <= i_instruction[15:0];
            o_RS <= i_instruction[25:21];
            o_RT <= i_instruction[20:16];
            o_RD <= i_instruction[15:11];
            o_opcode <= i_instruction[31:26];
            o_funct <= i_instruction[5:0];
            o_shamt <= i_instruction[10:6];
        end
    end

endmodule