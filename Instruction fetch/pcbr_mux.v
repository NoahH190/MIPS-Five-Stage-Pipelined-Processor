module pcbr_mux (
    input i_pc_br_sel,
    input [31:0] i_br_address_0,
    input [31:0] i_pc_increment), //if sel true give add next 
    output [31:0] o_br_address_1 //else give branch address
);

assign o_br_address_1 = i_pc_br_sel ? i_pc_increment : i_br_address_0;

endmodule
