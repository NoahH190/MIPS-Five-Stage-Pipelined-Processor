module instruction_fetch_top (
    // Clock / reset
    input  wire        i_clk,
    input  wire        i_reset,

    // Control inputs
    input  wire [31:0] i_br_address,   // branch target (from EX)
    input  wire        i_branch,       // branch control (from ID)
    input  wire        i_jump,         // jump control (from ID)
    input  wire        i_zero,         // zero flag (from EX)

    // Instruction memory interface (optional writeback into instruction memory)
    input  wire        i_read,
    input  wire        i_write,
    input  wire [31:0] i_instruction_in,

    // Outputs
    output wire [31:0] o_instruction,
    output wire [31:0] o_pc,
    output wire [31:0] o_pc_increment
);

    // Internal nets
    wire [31:0] w_pc;
    wire [31:0] w_pc_increment;
    wire [31:0] w_br1;
    wire [31:0] w_pc_next;
    wire        w_and;

    // Branch enable = branch control AND zero flag
    and_gate u_and_gate (
        .i_opcode(i_branch),
        .i_zero(i_zero),
        .o_and(w_and)
    );

    // PC + 4
    add_next u_pc_increment (
        .i_pc(w_pc),
        .o_pc_increment(w_pc_increment)
    );

    // Select between PC+4 and branch address (pcbr)
    pcbr_mux u_pcbr_mux (
        .i_pc_br_sel(w_and),
        .i_br_address_0(i_br_address),
        .i_pc_increment(w_pc_increment),
        .o_br_address_1(w_br1)
    );

    // Select between branch result and jump/other (pcjmp)
    pcjmp_mux u_pcjmp_mux (
        .i_pc_jmp_sel(i_jump),
        .i_br_address_1(w_br1),
        .i_pc_increment(w_pc_increment),
        .o_br_address_2(w_pc_next)
    );

    // Program counter
    program_counter u_program_counter (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_br_address_2(w_pc_next),
        .o_pc(w_pc)
    );

    // Instruction memory read
    instruction_memory u_inst_mem (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_read(i_read),
        .i_write(i_write),
        .i_pc(w_pc),
        .i_instruction(i_instruction_in),
        .o_instruction(o_instruction)
    );

    assign o_pc = w_pc;
    assign o_pc_increment = w_pc_increment;

endmodule
