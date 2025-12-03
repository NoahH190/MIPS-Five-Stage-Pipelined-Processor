module sign_extend (
    input  wire [15:0] i_address,
    input  wire [5:0]  i_se_ctrl,
    output reg  [31:0] o_sign_extend
);

    always @(*) begin
        if (i_se_ctrl == 6'b001100 || i_se_ctrl == 6'b001101 || i_se_ctrl == 6'b001110)
            o_sign_extend = {16'd0, i_address};
        else
            o_sign_extend = {{16{i_address[15]}}, i_address};
    end

endmodule
 
