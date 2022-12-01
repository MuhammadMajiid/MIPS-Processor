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
    input  logic [2:0]           alu_control,

    output logic [(WIDTH-1) : 0] alu_result,
    output logic zero_flag
);

//-----------------Registers-----------------\\
logic [2:0] state;
logic [31:0] cla_out;

//-----------------Encodings-----------------\\
localparam  AND      = 3'b000,
            OR       = 3'b001,
            ADD      = 3'b010,
            NOTUSED1 = 3'b011,
            NOTUSED2 = 3'b100,
            SUB      = 3'b110,
            SLT      = 3'b111,
            MUL      = 3'b101;

//-----------------ALU Logic-----------------\\
always_comb
begin
    if(!reset_n)
    begin
        alu_result = {WIDTH{1'b0}};
        state      = NOTUSED1;
    end
    else
    begin
        state = alu_control;
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
                alu_result = cla_out;
            end

            NOTUSED1:
            begin
                alu_result = {WIDTH{1'b0}};
            end

            SUB:
            begin
                alu_result = src_a - src_b;
            end

            MUL:
            begin
                alu_result = src_a * src_b;
            end

            SLT:
            begin
                alu_result = (src_a < src_b);
            end

            NOTUSED2:
            begin
                alu_result = {WIDTH{1'b0}};
            end

            default: state     = NOTUSED1;
        endcase
    end
end

//-----------------Zero Flag Logic-----------------\\
assign zero_flag = (!alu_result);

//-----------------Instances-----------------\\
CLA_Adder #(32) claComp(
    .in_1(src_a),
    .in_2(src_b),
    .carry_in(1'b0),

    .sum(cla_out)
);
endmodule