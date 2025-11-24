module left_shift_2 (
    input [31:0] tbd,
    output reg [31:0] o_src1
);

assign o_src1 = tbd << 2;

endmodule