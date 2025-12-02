module alu_ctrl (
    input  wire [5:0] i_opcode,
    output reg  [2:0] o_alu_ctrl
);

    // Placeholder: simple mapping, to be expanded
    always @* begin
        case (i_opcode)
            6'd0: o_alu_ctrl = 3'd0;
            default: o_alu_ctrl = 3'd0;
        endcase
    end