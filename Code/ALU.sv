//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: ALU.sv
//  TYPE: module.
//  DATE: 28/9/2022
//  KEYWORDS: ALU.
//  PURPOSE: An RTL modelling for a parameterized ALU used for the MIPS architecture.


//-----------------Ports and Parameters-----------------\\
module ALU
#(
    parameter WIDTH = 32
)
(
    input  logic                 reset_n,
    input  logic [(WIDTH-1) : 0] src_a,
    input  logic [(WIDTH-1) : 0] src_b,
    input  logic [2:0]           opcode,

    output logic [(WIDTH-1) : 0] alu_result,
    output logic zero_flag
);

//-----------------Registers-----------------\\
logic [2:0] state;

//-----------------Encodings-----------------\\
localparam  AND     = 3'b000,
            OR      = 3'b001,
            ADD     = 3'b010,
            NOTUSED = 3'b011,
            ANDNOT  = 3'b100,
            ORNOT   = 3'b101,
            SUB     = 3'b110,
            SLT     = 3'b111;

//-----------------ALU Logic-----------------\\
always_comb
begin
    if(!reset_n)
    begin
        state      = NOTUSED;
    end
    else
    begin
        state = opcode;
        case (state)
            AND:
            begin
                alu_result = src_a & src_b;
            end

            OR:
            begin
                alu_result = src_a | src_b;
            end

            ADD:
            begin
                alu_result = src_a + src_b;
            end

            NOTUSED:
            begin
                alu_result = {WIDTH{1'b0}};
            end

            ANDNOT:
            begin
                alu_result = src_a & (~src_b);
            end

            ORNOT:
            begin
                alu_result = src_a | (~src_b);
            end

            SUB:
            begin
                alu_result = src_a - src_b;
            end

            SLT:
            begin
                if(src_a < src_b)
                begin
                    alu_result = {{(WIDTH-1){1'b0}},1'b1};
                end
                else
                begin
                    alu_result = {WIDTH{1'b0}};
                end
            end

            default: state     = NOTUSED;
        endcase
    end
end

//-----------------Zero Flag Logic-----------------\\
assign zero_flag = alu_result? 1'b0 : 1'b1;

endmodule