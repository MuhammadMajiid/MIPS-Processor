//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: Top.sv
//  TYPE: module.
//  DATE: 8/10/2022
//  KEYWORDS: MIPS, Data Memory, Instruction Memory.
//  PURPOSE: An RTL modelling for the Top of the MIPS-Processor architecture.
//  Full architecture Explained in details in the README file.

module Top 
//-----------------Ports-----------------\\
(
    input  logic reset_n,      //  Asynchrounus Active low reset.
    input  logic clock,        //  System's clock.

    output logic [15:0] test_value    //  This signal is just for observing the output.
);

//-----------------Control Signals-----------------\\
logic        reset_n_synch_w;   //  The output reset from the Reset Synchronizer Unit.
logic        mem_write_w;       //  Control signal from the CU to the RF.
logic [31:0] pc_w;              //  The PC out from the data path unit.
logic [31:0] instr_w;           //  Intsruction from the Intsruction memory.
logic [31:0] alu_out_w;         //  ALU result.
logic [31:0] write_data_w;      //  The data to be written in the data memory.
logic [31:0] read_data_w;       //  The data read from the data memory.

//------------>>> Reset Synchronizer Unit.
ResetSynchronizer rs(
    .reset_n(reset_n),
    .clock(clock),

    .reset_n_synch(reset_n_synch_w)
);

//------------>>> MIPS Unit.
MIPS mips(
    .reset_n(reset_n_synch_w),
    .clock(clock),
    .instruction(instr_w),
    .read_data(read_data_w),

    .pc(pc_w),
    .alu_out(alu_out_w),
    .write_data(write_data_w),
    .mem_write(mem_write_w)
);

//------------>>> Data Memory Unit.
DataMem dm(
    .reset_n(reset_n_synch_w),
    .clock(clock),
    .write_enable(mem_write_w),
    .address(alu_out_w),
    .write_data(write_data_w),

    .read_data(read_data_w),
    .test_value(test_value)
);

//------------>>> Instruction Memory Unit.
InstrMem im(
    .pc(pc_w),

    .instr(instr_w)
);

endmodule