module read_dst_mux (
    input  wire [4:0] i_RT,
    input  wire [4:0] i_RD,
    input  wire       i_dest_sel,
    output wire [4:0] o_mux_addr
);

    assign o_mux_addr = i_dest_sel ? i_RD : i_RT;

endmodule