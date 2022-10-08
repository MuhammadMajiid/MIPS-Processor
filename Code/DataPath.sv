//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: DataPath.sv
//  TYPE: module.
//  DATE: 8/10/2022
//  KEYWORDS: Data Path.
//  PURPOSE: An RTL modelling for the Data Path of the MIPS-Processor architecture.

module DataPath
//-----------------Ports-----------------\\
(
    input logic        reset_n,      //  Asynchrounus Active low reset.
    input logic        clock,        //  System's clock.
    input logic [31:0] instruction,  //  The 32-bit Instruction from the instruction memory.
    input logic [31:0] read_data,    //  The output from the Data memory to the Register file.
    input logic [2:0]  alu_control   //  Control signal from the CU to the RF.
    input logic        pc_src,       //  Control signal from the anding between zero_w & branch.
    input logic        mem_to_reg,   //  Control signal from the CU to the RF.
    input logic        alu_src,      //  Control signal from the CU to the RF.
    input logic        reg_dest,     //  Control signal from the CU to the RF.
    input logic        reg_write,    //  Control signal from the CU to the RF.

    output logic        zero_flag,   //  Control signal from the ALU.
    output logic [31:0] pc,          //  The Program Counter for the next instruction.
    output logic [31:0] alu_out,     //  ALU result.
    output logic [31:0] write_data   //  The data to be written into the data memory from the srcB.
);

//-----------------Control Signals-----------------\\
logic [4:0]  write_reg;         //  The address to the RF from the 2-1 MUX sel(reg_dest_w).
logic [31:0] sign_imm_w;        //  Out from the Sign Extend unit.
logic [31:0] shifted_imm_w;     //  Shifted out from the Sign Extend unit.
logic [31:0] result;            //  The output from the 2-1 MUX sel(mem_to_reg_w).
logic [31:0] src_a_w;           //  The source register A out from the RF.
logic [31:0] src_b_w;           //  The source register A out from the 2-1 MUX sel(alu_src_w).
logic [31:0] rd2_w;             //  The source register b out from the RF to the mux.
logic [31:0] alu_res_w;         //  ALU result.
logic [31:0] pc_plus4_w;        //  Output of the unit responsible of incrementing the pc.
logic [31:0] pc_barnch_w;       //  Output after adding the pc_plus4_w + shifted_imm_w.
logic [31:0] pc_decide_w;       //  Output from the 2-1 MUX sel(pc_src_w).
logic [31:0] pc_jump_w;         //  Output of the Jump PC preparation.
logic [31:0] pc_next_w;         //  Output from the two-stage pc MUXs.


//-----------------Data Path Flow-----------------\\

//------------>>> Controls the writing address for the RF.
MUX #(5) m1(
    .data_true(instruction[15:11]),
    .data_false(instruction[20:16]),
    .sel(reg_dest_w),

    .data_out(write_reg)
);

//------------>>> The Register File.
RegFile rf(
    .clock(clock),
    .write_enable(reg_write_w),
    .addr1(instruction[25:21]),
    .addr2(instruction[20:16]),
    .addr3(write_reg),
    .write_data(result),

    .rd1(src_a_w),
    .rd2(rd2_w)
);

//------------>>> Sign extention unit for immediate.
SignExtn se(
    .data_in(instruction[15:0]),

    .data_signed(sign_imm_w)
);

//------------>>> Controls which source would be taken for the ALU.
MUX #(32) m2(
    .data_true(sign_imm_w),
    .data_false(rd2_w),
    .sel(alu_src_w),

    .data_out(src_b_w)
);

//------------>>> ALU unit
ALU #(32) alu(
    .reset_n(reset_n_synch_w),
    .src_a(src_a_w),
    .src_b(src_b_w),
    .opcode(alu_control_w),

    .alu_result(alu_res_w),
    .zero_flag(zero_flag)
);

//------------>>> Assigns the rd2 of the RF to the WriteData port in the data memory.
assign write_data = rd2_w;


//-----------------Next PC logic-----------------\\

//------------>>> Shifts the SignExtended immediate to the PCBranch unit.
Shifter #(2,1,32) sh1(
    .data_in(sign_imm_w),

    .data_out(shifted_imm_w)
);

//------------>>> Increments the PC by 4. 
Adder #(32) add1(
    .reset_n(reset_n_synch_w),
    .data_a(pc),
    .data_b(32'd4),

    .data_res(pc_plus4_w)
);

//------------>>> Preparing the PCBranch.
Adder #(32) add2(
    .reset_n(reset_n_synch_w),
    .data_a(shifted_imm_w),
    .data_b(pc_plus4_w),

    .data_res(pc_barnch_w)
);

//------------>>> Decides whether will pass the PCBranch or the next PC.
MUX #(32) m3(
    .data_true(pc_barnch_w),
    .data_false(pc_plus4_w),
    .sel(pc_src_w),

    .data_out(pc_decide_w)
);

//------------>>> Prepares the PCJump.
assign pc_jump_w = {pc_plus4_w[31:28],instruction[25:0],2'b00};


//------------>>> Decides whether will pass the PCJump or (PCBranch or the next PC).
MUX #(32) m4(
    .data_true(pc_jump_w),
    .data_false(pc_decide_w),
    .sel(jump_w),

    .data_out(pc_next_w)
);

//------------>>> Synchronizes the pc with the clock.
DFF dff1(
    .reset_n(reset_n_synch_w),
    .clock(clock),
    .d(pc_next_w),

    .q(pc)
);

endmodule