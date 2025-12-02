module register_file (
    input  wire        i_clk,
    input  wire        i_reset,
    input  wire [31:0] i_wb_data,
    input  wire [4:0]  i_RS,
    input  wire [4:0]  i_RT,
    input  wire [4:0]  i_mux_addr,
    output wire [31:0] o_src1,
    output wire [31:0] o_src2
);

    reg [31:0] regs [31:0];

    integer i;
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            for (i = 0; i < 32; i = i+1) regs[i] <= 32'd0;
        end else begin
            // write-back to register file at address i_mux_addr
            regs[i_mux_addr] <= i_wb_data;
        end
    end

    assign o_src1 = regs[i_RS];
    assign o_src2 = regs[i_RT];

endmodule