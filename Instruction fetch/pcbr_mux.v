module pcbr_mux (
    input  wire        i_pc_br_sel,
    input  wire [31:0] i_br_address_0,
    input  wire [31:0] i_pc_increment,
    output wire [31:0] o_br_address_1
);

    assign o_br_address_1 = i_pc_br_sel ? i_br_address_0 : i_pc_increment;

endmodule