module instruction_memory (
    input  wire        i_clk,
    input  wire        i_reset,
    input  wire        i_read,
    input  wire        i_write,
    input  wire [31:0] i_pc,
    input  wire [31:0] i_instruction,
    output reg  [31:0] o_instruction
);

    reg [31:0] mem [0:255];
    integer k;

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            for (k = 0; k < 256; k = k + 1) begin
                mem[k] <= 32'd0;
            end
        end else if (i_write) begin
            mem[i_pc[31:2]] <= i_instruction;
        end
    end

    always @(*) begin
        if (i_read)
            o_instruction = mem[i_pc[31:2]];
        else
            o_instruction = 32'd0;
    end

endmodule