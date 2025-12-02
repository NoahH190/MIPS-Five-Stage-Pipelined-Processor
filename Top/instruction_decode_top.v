module instruction_decode_top (
    input  wire        i_clk,
    input  wire        i_reset,
    input  wire [31:0] i_instruction,
    input  wire [31:0] i_wb_data,
    input  wire [5:0]  i_dest_sel,
    input  wire [5:0]  i_se_ctrl,
    output wire [31:0] o_src1,
    output wire [31:0] o_src2,
    output wire [31:0] o_sign_extend,
    output wire [4:0]  o_RS,
    output wire [4:0]  o_RT,
    output wire [4:0]  o_RD,
    output wire [4:0]  o_mux_addr,
    output wire [15:0] o_address,
    output wire [5:0]  o_opcode
);

    wire [15:0] w_address;
    wire [4:0]  w_RS;
    wire [4:0]  w_RT;
    wire [4:0]  w_RD;
    wire [4:0]  w_mux_addr;
    wire [5:0]  w_opcode;

    instruction_decoder u_decoder (
        .i_instruction(i_instruction),
        .o_address(w_address),
        .o_RS(w_RS),
        .o_RT(w_RT),
        .o_RD(w_RD),
        .o_opcode(w_opcode)
    );

    read_write_mux u_dst_mux (
        .i_RT(w_RT),
        .i_RD(w_RD),
        .i_dest_sel(i_dest_sel),
        .o_mux_addr(w_mux_addr)
    );

    register_file u_regfile (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_wb_data(i_wb_data),
        .i_RS(w_RS),
        .i_RT(w_RT),
        .i_mux_addr(w_mux_addr),
        .o_src1(o_src1),
        .o_src2(o_src2)
    );

    sign_extend u_sign_ext (
        .i_address(w_address),
        .i_se_ctrl(i_se_ctrl),
        .o_sign_extend(o_sign_extend)
    );

    assign o_RS = w_RS;
    assign o_RT = w_RT;
    assign o_RD = w_RD;
    assign o_mux_addr = w_mux_addr;
    assign o_address = w_address;
    assign o_opcode = w_opcode;

endmodule
