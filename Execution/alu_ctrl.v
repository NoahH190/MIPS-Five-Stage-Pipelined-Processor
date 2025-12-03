module alu_ctrl (
    input  wire [5:0] i_opcode,
    input  wire [5:0] i_funct,
    output reg  [3:0] o_alu_ctrl,
    output reg        o_sel_shift
);

    always @(*) begin
        o_sel_shift = 1'b0;
        case (i_opcode)
            6'b000000: begin
                case (i_funct)
                    6'b100000: o_alu_ctrl = 4'b0000;
                    6'b100010: o_alu_ctrl = 4'b0001;
                    6'b100100: o_alu_ctrl = 4'b0010;
                    6'b100101: o_alu_ctrl = 4'b0011;
                    6'b101010: o_alu_ctrl = 4'b1000;
                    6'b000000: o_alu_ctrl = 4'b0101;
                    6'b000010: o_alu_ctrl = 4'b0110;
                    6'b000100: begin o_alu_ctrl = 4'b0101; o_sel_shift = 1'b1; end
                    6'b000110: begin o_alu_ctrl = 4'b0110; o_sel_shift = 1'b1; end
                    default:   o_alu_ctrl = 4'b0000;
                endcase
            end
            6'b001000: o_alu_ctrl = 4'b0000;
            6'b001100: o_alu_ctrl = 4'b0010;
            6'b100011: o_alu_ctrl = 4'b0000;
            6'b101011: o_alu_ctrl = 4'b0000;
            6'b000100: o_alu_ctrl = 4'b0001;
            default:   o_alu_ctrl = 4'b0000;
        endcase
    end

endmodule