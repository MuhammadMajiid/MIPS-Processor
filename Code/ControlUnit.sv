//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: ControlUnit.sv
//  TYPE: module.
//  DATE: 29/9/2022
//  KEYWORDS: Control unit.
//  PURPOSE: An RTL modelling for the control unit used for the MIPS architecture.

module ControlUnit 
//-----------------Ports-----------------\\
(
    input logic [5:0] opcode,
    input logic [5:0] funct,
    input logic       zero_flag,

    output logic [2:0] alu_control,
    output logic mem_to_reg,
    output logic mem_write,
    output logic alu_src,
    output logic reg_dest,
    output logic reg_write,
    output logic jump,
    output logic pc_src
);
//-----------------Control signals-----------------\\
logic [1:0] alu_op_w;
logic       branch_w;

//-----------------Main decoder instance-----------------\\
MainDec md(
    //  Input
    .opcode(opcode),

    //  Outputs
    .mem_to_reg(mem_to_reg),
    .mem_write(mem_write),
    .branch(branch_w),
    .alu_src(alu_src),
    .reg_dest(reg_dest),
    .reg_write(reg_write),
    .jump(jump)
);

//-----------------ALU decoder instance-----------------\\
ALUDec ad(
    //  Inputs
    .funct(funct),
    .alu_op(alu_op_w),

    //  Output
    .alu_control(alu_control)
);

//-----------------PC source if branching-----------------\\
assign pc_src = branch_w & zero_flag;

endmodule