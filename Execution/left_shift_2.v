module left_shift_2 (
    input [31:0] i_sign_extend,
    output reg [31:0] o_address
);

assign o_address = i_sign_extend << 2;

endmodule
