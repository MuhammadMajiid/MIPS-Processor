//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: ALUDec.sv
//  TYPE: module.
//  DATE: 28/9/2022
//  KEYWORDS: ALU, Decoder.
//  PURPOSE: An RTL modelling for an ALU decoder used for the MIPS architecture.

module ALUDec 
//-----------------Ports-----------------\\
(
    input  logic [5:0] funct,
    input  logic [1:0] alu_op,

    output logic  [2:0] alu_control
);

//-----------------ALUOp encoding-----------------\\
localparam  ADDOP    = 2'b00,
            SUBOP    = 2'b01,
            FUNCTOP  = 2'b10;

//-----------------Funct encoding-----------------\\
localparam  ADDFUN  = 6'b100000,
            SUBFUN  = 6'b100010,
            ANDFUN  = 6'b100100,
            ORFUN   = 6'b100101,
            SLTFUN  = 6'b101010;

//-----------------Output encoding-----------------\\
localparam  AND     = 3'b000,
            OR      = 3'b001,
            ADD     = 3'b010,
            SUB     = 3'b110,
            SLT     = 3'b111;

//-----------------ALU Decoder logic-----------------\\
always_comb
begin
    //  Priority to the alu_op first, then check the funct field.
    if(!alu_op)
    begin
        alu_control = ADD;
    end
    else if(alu_op[0])
    begin
        alu_control = SUB;
    end
    else
    begin
        case (funct)
            ADDFUN: alu_control = ADD;
            SUBFUN: alu_control = SUB;
            ANDFUN: alu_control = AND;
            ORFUN:  alu_control = OR;
            SLTFUN: alu_control = SLT;

            default: alu_control = ADD;
        endcase
    end
end
endmodule