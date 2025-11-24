module instruction_decoder(
    input [31:0] i_instruction,
    output [15:0] o_address,
    output [4:0] o_RS,
    output [4:0] o_RT,
    output [4:0] o_RD
); //remove clock and reset at some point 

reg [15:0] r_address;
reg [4:0] r_RS;
reg [4:0] r_RT;
reg [4:0] r_RD;

always @(posedge i_clk or posedge i_reset) begin 
    if(i_reset) begin
        r_address <= 0; 
        r_RS <= 0;
        r_RT <= 0;
        r_RD <= 0;
    end 
    else begin 
        r_address <= i_instruction[15:0]; 
        r_RS <= i_instruction[25:21];
        r_RT <= i_instruction[20:16];
        r_RD <= i_instruction[15:11];
    end 
end 

assign o_address = r_address; 
assign o_RS = r_RS;
assign o_RT = r_RT;
assign o_RD = r_RD;

endmodule