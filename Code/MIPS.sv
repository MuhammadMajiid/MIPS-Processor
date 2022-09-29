module MIPS (
    input wire reset_n,
    input wire clock,
    input wire [31:0] instruction,
    input wire [31:0] read_data,

    output reg [31:0] pc,
    output reg [31:0] alu_out,
    output reg [31:0] write_data
);
    
endmodule