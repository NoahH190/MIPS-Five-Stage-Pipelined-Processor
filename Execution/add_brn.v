module add_brn (
    input [31:0] i_src1,
    input [31:0] tbd,
    output reg [31:0] o_br_address
);

//this module is defienitly a work in progress

assign o_br_address = i_src1 + tbd;

endmodule
