//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: MIPS.sv
//  TYPE: module.
//  DATE: 8/10/2022
//  KEYWORDS: MIPS.
//  PURPOSE: An RTL modelling for the MIPS-Processor architecture.
//  Full architecture Explained in details in the README file.

module MIPS 
//-----------------Ports-----------------\\
(
    input wire        reset_n,
    input wire        clock,
    input wire [31:0] instruction,
    input wire [31:0] read_data,

    output reg [31:0] pc,
    output reg [31:0] alu_out,
    output reg [31:0] write_data,
    output reg        mem_write
);

//-----------------Control Signals-----------------\\
logic        reg_write_w;       //  Control signal from the CU to the RF.
logic        reg_dest_w;        //  Control signal from the CU to the RF.
logic        alu_src_w;         //  Control signal from the CU to the RF.
logic        mem_to_reg_w;      //  Control signal from the CU to the RF.
logic        jump_w;            //  Control signal from the CU to the RF.
logic [2:0]  alu_control_w;     //  Control signal from the CU to the RF.
logic        zero_w;            //  Control signal from the ALU.
logic        pc_src_w;          //  Control signal from the anding between zero_w & branch.

//------------>>> Control Unit.
ControlUnit Cu(
    .opcode(instruction[31:26]),
    .funct(instruction[5:0]),
    .zero_flag(zero_w),

    .alu_control(alu_control_w),
    .mem_to_reg(mem_to_reg_w),
    .alu_src(alu_src_w),
    .reg_dest(reg_dest_w),
    .reg_write(reg_write_w),
    .jump(jump_w),
    .pc_src(pc_src_w),
    .mem_write(mem_write)
);

//------------>>> Data Path Unit.
DataPath dp(
    .reset_n_synch(reset_n),
    .clock(clock),
    .instruction(instruction),
    .read_data(read_data),
    .alu_control(alu_control_w),
    .pc_src(pc_src_w),
    .mem_to_reg(mem_to_reg_w),
    .alu_src(alu_src_w),
    .reg_dest(reg_dest_w),
    .reg_write(reg_write_w),
    .jump(jump_w),

    .pc(pc),
    .alu_out(alu_out),
    .write_data(write_data),
    .zero_flag(zero_w)
);

endmodule