module read_write_mux (
    input [4:0] i_RT, //sel 1
    input [4:0] i_RD, //sel 0
    input i_dest_sel,  //destination control signal
    output o_mux_RD  //Mux output for RD 
); 

reg r_mux_RD; 

always @(posedge i_clk or posedge reset) begin 
    if(reset) o_placeholder <= 0;
    else r_mux_RD <= (i_dest_sel) ? i_RT : i_RD; 
end 

assign o_mux_RD = r_mux_RD;

endmodule 