module pcjmp_mux (
    input i_pc_jmp_sel,
    input [31:0] i_br_address_1, //sel true give branch address
    input [31:0] i_jmp_address,  //sel false give jump address
    output [31:0] o_br_address_2,
);

assign o_br_address_2 = i_pc_jmp_sel ? i_jmp_address : i_br_address_1;

endmodule