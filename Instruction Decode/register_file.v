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

    reg [31:0] registers [0:31];
    integer i;

    assign o_src1 = (i_RS == 5'd0) ? 32'd0 : registers[i_RS];
    assign o_src2 = (i_RT == 5'd0) ? 32'd0 : registers[i_RT];

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'd0;
        end else if (i_mux_addr != 5'd0) begin
            registers[i_mux_addr] <= i_wb_data;
        end
    end

endmodule