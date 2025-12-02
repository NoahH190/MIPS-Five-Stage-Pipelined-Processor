module shift_mux ( //shifts 5 bits 
    input  wire        i_sel_shift,
    input  wire [4:0]  i_shamt,
    input  wire [31:0] i_src1,
    output wire [4:0]  o_shamt
);

    assign o_shamt = (i_sel_shift) ? i_shamt : i_src1[4:0];

endmodule
