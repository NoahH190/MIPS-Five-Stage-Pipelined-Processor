module pcjmp_mux (
    input  wire        i_pc_jmp_sel,
    input  wire [31:0] i_br_address_1,
    input  wire [31:0] i_pc_increment,
    output wire [31:0] o_br_address_2
);

    assign o_br_address_2 = i_pc_jmp_sel ? i_pc_increment : i_br_address_1;

endmodule