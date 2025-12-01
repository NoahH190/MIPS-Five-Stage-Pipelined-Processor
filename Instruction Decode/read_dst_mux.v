module read_write_mux (
    input [4:0] i_RT, //sel 1
    input [4:0] i_RD, //sel 0
    input [5:0] i_dest_sel,  //destination control signal
    output o_mux_addr  //Mux output for RD 
); 

reg r_mux_addr; 

always @(posedge i_clk or posedge reset) begin 
    if(reset) o_placeholder <= 0;
    else r_mux_addr <= (i_dest_sel) ? i_RT : i_RD; 
end 

assign o_mux_addr = r_mux_addr;

endmodule 