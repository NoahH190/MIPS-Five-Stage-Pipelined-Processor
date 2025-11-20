// Simple parametrizable ALU core
// Inputs: i_src1, i_src2
// Output: o_dest
// Control: i_alu_ctrl selects operation

module alu #(
	parameter WIDTH = 32
) (
	input  wire [WIDTH-1:0] i_src1,
	input  wire [WIDTH-1:0] i_src2,
	input  wire [3:0]       i_alu_ctrl,
	output reg  [WIDTH-1:0] o_dest,
	output wire             o_zero
);

	// ALU control encodings
	localparam ALU_ADD  = 4'b0000;
	localparam ALU_SUB  = 4'b0001;
	localparam ALU_AND  = 4'b0010;
	localparam ALU_OR   = 4'b0011;
	localparam ALU_XOR  = 4'b0100;
	localparam ALU_SLL  = 4'b0101; // logical left by lower 5 bits
	localparam ALU_SRL  = 4'b0110; // logical right by lower 5 bits
	localparam ALU_SRA  = 4'b0111; // arithmetic right by lower 5 bits
	localparam ALU_SLT  = 4'b1000; // set on less than (signed)
	localparam ALU_SLTU = 4'b1001; // set on less than (unsigned)

	always @* begin
		case (i_alu_ctrl)
			ALU_ADD:  o_dest = i_src1 + i_src2;
			ALU_SUB:  o_dest = i_src1 - i_src2;
			ALU_AND:  o_dest = i_src1 & i_src2;
			ALU_OR:   o_dest = i_src1 | i_src2;
			ALU_XOR:  o_dest = i_src1 ^ i_src2;
			ALU_SLL:  o_dest = i_src1 << i_src2[4:0];
			ALU_SRL:  o_dest = i_src1 >> i_src2[4:0];
			ALU_SRA:  o_dest = $signed(i_src1) >>> i_src2[4:0];
			ALU_SLT:  o_dest = ($signed(i_src1) < $signed(i_src2)) ? {{(WIDTH-1){1'b0}},1'b1} : {WIDTH{1'b0}};
			ALU_SLTU: o_dest = (i_src1 < i_src2) ? {{(WIDTH-1){1'b0}},1'b1} : {WIDTH{1'b0}};
			default:  o_dest = {WIDTH{1'b0}};
		endcase
	end

	assign o_zero = (o_dest == {WIDTH{1'b0}});

endmodule
