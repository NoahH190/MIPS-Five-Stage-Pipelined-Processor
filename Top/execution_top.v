module execution_top (
    input  wire [31:0] i_pc_increment,
    input  wire [31:0] i_src1,
    input  wire [31:0] i_src2,
    input  wire [31:0] i_sign_extend,
    input  wire [4:0]  i_shamt,
    input  wire [5:0]  i_opcode,
    input  wire        i_sel_shift,
    input  wire        i_alu_src_sel, // select between src2 and sign-extend
    output wire [31:0] o_alu_result,
    output wire        o_zero,
    output wire [31:0] o_br_address
);

    wire [31:0] w_alu_mux;
    wire [2:0]  w_alu_ctrl;
    wire [3:0]  w_alu_ctrl_ext;
    wire [31:0] w_shifted;

    alu_mux u_alu_mux (
        .i_sel_alu(i_opcode),
        .i_sign_extend(i_sign_extend),
        .i_src2(i_src2),
        .o_alu_mux(w_alu_mux)
    );

    alu_ctrl u_alu_ctrl (
        .i_opcode(i_opcode),
        .o_alu_ctrl(w_alu_ctrl)
    );

    // zero-extend alu ctrl to 4 bits (alu expects 4-bit control)
    assign w_alu_ctrl_ext = {1'b0, w_alu_ctrl};

    alu u_alu (
        .i_src1(i_src1),
        .i_src2(w_alu_mux),
        .i_alu_ctrl(w_alu_ctrl_ext),
        .i_shamt(i_shamt),
        .o_alu_result(o_alu_result),
        .o_zero(o_zero)
    );

    left_shift_2 u_left_shift (
        .i_sign_extend(i_sign_extend),
        .o_address(w_shifted)
    );

    add_brn u_br_addr_calc (
        .i_address(w_shifted),
        .i_add_next(i_pc_increment),
        .i_se_crtl(1'b1),
        .o_br_address(o_br_address)
    );

    shift_mux u_shift_mux (
        .i_sel_shift(i_sel_shift),
        .i_shamt(i_shamt),
        .i_src1(i_src1),
        .o_shamt() // left unconnected here; wrapper doesn't expose shamt
    );

endmodule
