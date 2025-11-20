module read_write_mux (
    input i_clk, 
    input i_reset,
    input [4:0] i_RT, //sel 1
    input [4:0] i_RD, //sel 0
    input i_placeholder_sel,  //need to figure out where im grabbing this signal from 
    output o_placeholder   //same here 
); //note: figure out swhere register write coontrol signal

reg r_placeholder; 

always @(posedge i_clk or posedge reset) begin 
    if(reset) o_placeholder <= 0;
    else r_placeholder <= (i_placeholder_sel) ? i_RT : i_RD; 
end 

assign o_placeholder = r_placeholder; 

endmodule 