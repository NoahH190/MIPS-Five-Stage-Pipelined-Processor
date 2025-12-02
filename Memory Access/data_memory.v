module dmemory(
    input i_clk,
    input [5:0] i_read_en, //read signal
    input [5:0] i_write_en, //write signal 
    input [31:0] i_address,   //should be output of ALU unit
    input [31:0] i_write,   //should be source 2 but have to confirm
    output reg [31:0] o_memory_data
);

//this is most likely gonna be implemented on ddr3 ram 

endmodule 