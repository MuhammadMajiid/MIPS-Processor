//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: RegFile.sv
//  TYPE: module.
//  DATE: 28/9/2022
//  KEYWORDS: Register File.
//  PURPOSE: An RTL modelling for a register file used for the MIPS architecture.

module RegFile 
//-----------------Ports-----------------\\
(
    input logic        clock,         //  System' clock.
    input logic        write_enable,  //  Write enable.
    input logic [4:0]  addr1,         //  src_a address.
    input logic [4:0]  addr2,         //  src_b address.
    input logic [4:0]  addr3,         //  destanation adress for the write operation.
    input logic [31:0] write_data,    //  the data to be written in the rf.

    output logic [31:0] rd1,           //  src_a.
    output logic [31:0] rd2            //  src_b.
);
//-----------------Register-----------------\\
reg [31:0] registers [31:0];         //  There are 32 register each is 32-bit wide.

//-----------------Write logic-----------------\\
always_ff @(posedge clock) 
begin
    if(write_enable)
    begin
        registers[addr3] <= write_data;
    end
    else
    begin
        registers <= registers;
    end
    //  The wite operation is synchronous
end

//-----------------Output-----------------\\
always @(*) begin
    rd1 = (addr1 != 5'b0)? registers[addr1] : 32'b0;
    rd2 = (addr2 != 5'b0)? registers[addr2] : 32'b0;
    //  The read operation is combinational, the register 0 is hardlogicd to 0
end

endmodule