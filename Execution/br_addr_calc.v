module br_addr_calc (
    input  wire [31:0] i_address,
    input  wire [31:0] i_add_next,
    input  wire        i_se_crtl,
    output wire [31:0] o_br_address
);

    assign o_br_address = i_address + i_add_next;

endmodule
