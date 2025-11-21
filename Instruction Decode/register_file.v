module register_file (
    input i_clk,
    input i_reset,
    input [31:0] i_write_data,
    input [4:0] i_RS,
    input [4:0] i_RT,
    input [4:0] i_mux_RD
    output [31:0] o_src1;
    output [31:0] o_src2; 
);