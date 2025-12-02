module top (
    input wire i_clk,
    input wire i_reset
);

    // Wires between phases
    // IF outputs
    wire [31:0] if_instruction;
    wire [31:0] if_pc;
    wire [31:0] if_pc_increment;

    // ID outputs
    wire [31:0] id_src1;
    wire [31:0] id_src2;
    wire [31:0] id_sign_extend;
    wire [4:0]  id_RS;
    wire [4:0]  id_RT;
    wire [4:0]  id_RD;
    wire [4:0]  id_mux_addr;
    wire [15:0] id_address;
    wire [5:0]  id_opcode;

    // EX outputs
    wire [31:0] ex_alu_result;
    wire        ex_zero;
    wire [31:0] ex_br_address;

    // Control / simple placeholders
    wire        ctrl_branch = id_opcode != 6'd0; // placeholder: non-zero opcode -> branch
    wire        ctrl_jump = 1'b0;
    wire [5:0]  ctrl_dest_sel = 6'd0;
    wire [5:0]  ctrl_se_ctrl = 6'd0;

    instruction_fetch_top u_if (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_br_address(ex_br_address),
        .i_branch(ctrl_branch),
        .i_jump(ctrl_jump),
        .i_zero(ex_zero),
        .i_read(1'b1),
        .i_write(1'b0),
        .i_instruction_in(32'd0),
        .o_instruction(if_instruction),
        .o_pc(if_pc),
        .o_pc_increment(if_pc_increment)
    );

    instruction_decode_top u_id (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_instruction(if_instruction),
        .i_wb_data(32'd0),
        .i_dest_sel(ctrl_dest_sel),
        .i_se_ctrl(ctrl_se_ctrl),
        .o_src1(id_src1),
        .o_src2(id_src2),
        .o_sign_extend(id_sign_extend),
        .o_RS(id_RS),
        .o_RT(id_RT),
        .o_RD(id_RD),
        .o_mux_addr(id_mux_addr),
        .o_address(id_address),
        .o_opcode(id_opcode)
    );

    execution_top u_ex (
        .i_pc_increment(if_pc_increment),
        .i_src1(id_src1),
        .i_src2(id_src2),
        .i_sign_extend(id_sign_extend),
        .i_shamt(id_RS),
        .i_opcode(id_opcode),
        .i_sel_shift(1'b0),
        .i_alu_src_sel(1'b0),
        .o_alu_result(ex_alu_result),
        .o_zero(ex_zero),
        .o_br_address(ex_br_address)
    );

endmodule
