//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: DataMem.sv
//  TYPE: module.
//  DATE: 8/10/2022
//  KEYWORDS: Data Memory.
//  PURPOSE: An RTL modelling for a Data Memory used for the MIPS architecture.

module DataMem 
//-----------------Ports-----------------\\
(
    input  logic         reset_n,
    input  logic         clock,
    input  logic         write_enable,
    input  logic [31:0]  write_data,
    input  logic [31:0]  address,

    output logic [31:0]  read_data,
    output logic [15:0]  test_value
);

//-----------------Memory Declaration-----------------\\
reg [31:0] data_mem [255:0];
integer i;

//------------>>> Reading combinationally.
always_comb
begin
    read_data = data_mem[address];
end

//------------>>> Writing on the positive edge of the clock.
always_ff @(posedge clock, negedge reset_n)
begin
    if(~reset_n)
    //  Initialization
    begin
        for (i=0; i<256; i++)
        begin
        data_mem[i] <= 32'b0 ;
        end
    end
    else
    begin
        if(write_enable)
        begin
            data_mem[address] <= write_data;
        end    
    end
end

assign test_value = data_mem[0][15:0];

endmodule