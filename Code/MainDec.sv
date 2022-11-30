//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: MainDec.sv
//  TYPE: module.
//  DATE: 28/9/2022
//  KEYWORDS: Decoder.
//  PURPOSE: An RTL modelling for the main decoder used for the MIPS architecture.

module MainDec 
//-----------------Ports-----------------\\
(
    input logic [5:0]  opcode_md,

    output logic       reg_write,
    output logic       reg_dest,
    output logic       alu_src,
    output logic       branch,
    output logic       mem_write,
    output logic       mem_to_reg,
    output logic [1:0] alu_op,
    output logic       jump
);
//-----------------Register-----------------\\
logic [8:0] controllers;

//-----------------Instruction Opcode-----------------\\
localparam  RTYPE = 6'b000000,
            LW    = 6'b100011,
            SW    = 6'b101011,
            BEQ   = 6'b000100,
            ADDI  = 6'b001000,
            JUMP  = 6'b000010;

//-----------------6-1 MUX for the instruction-----------------\\
always_comb begin
    case (opcode_md)
        RTYPE: controllers = 9'b1100_00100;
        LW:    controllers = 9'b1010_01000;
        SW:    controllers = 9'b0010_10000;
        BEQ:   controllers = 9'b0001_00010;
        ADDI:  controllers = 9'b1010_00000;
        JUMP:  controllers = 9'b0000_00001;

        default: controllers = 9'b1100_00100;  //  R-Type
    endcase
end

//-----------------Output-----------------\\
assign reg_write   = controllers[8];
assign reg_dest    = controllers[7];
assign alu_src     = controllers[6];
assign branch      = controllers[5];
assign mem_write   = controllers[4];
assign mem_to_reg  = controllers[3];
assign alu_op      = controllers[2:1];
assign jump        = controllers[0];

endmodule