module alu #(
    parameter WIDTH = 32
) (
    input  wire [WIDTH-1:0] i_src1,
    input  wire [WIDTH-1:0] i_src2,
    input  wire [3:0]       i_alu_ctrl,
    input  wire [4:0]       i_shamt,
    output reg  [WIDTH-1:0] o_alu_result,
    output wire             o_zero
);

    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_SLL  = 4'b0101;
    localparam ALU_SRL  = 4'b0110;
    localparam ALU_SRA  = 4'b0111;
    localparam ALU_SLT  = 4'b1000;
    localparam ALU_SLTU = 4'b1001;

    always @* begin
        case (i_alu_ctrl)
            ALU_ADD:  o_alu_result = i_src1 + i_src2;
            ALU_SUB:  o_alu_result = i_src1 - i_src2;
            ALU_AND:  o_alu_result = i_src1 & i_src2;
            ALU_OR:   o_alu_result = i_src1 | i_src2;
            ALU_XOR:  o_alu_result = i_src1 ^ i_src2;
            ALU_SLL:  o_alu_result = i_src1 << i_shamt[4:0];
            ALU_SRL:  o_alu_result = i_src1 >> i_shamt[4:0];
            ALU_SRA:  o_alu_result = $signed(i_src1) >>> i_shamt[4:0];
            ALU_SLT:  o_alu_result = ($signed(i_src1) < $signed(i_src2)) ? {{(WIDTH-1){1'b0}},1'b1} : {WIDTH{1'b0}};
            ALU_SLTU: o_alu_result = (i_src1 < i_src2) ? {{(WIDTH-1){1'b0}},1'b1} : {WIDTH{1'b0}};
            default:  o_alu_result = {WIDTH{1'b0}};
        endcase
    end

    assign o_zero = (o_alu_result == {WIDTH{1'b0}});

endmodule
