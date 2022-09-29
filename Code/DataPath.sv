module DataPath
//-----------------Ports-----------------\\
(
    input logic reset_n,
    input logic clock,
    input logic [31:0] instruction,
    input logic [31:0] read_data,

    output logic [31:0] pc,
    output logic [31:0] alu_out,
    output logic [31:0] write_data
);

//-----------------Control Signals-----------------\\
logic        reg_write_w;
logic        reg_dest_w;
logic        alu_src_w;
logic        pc_src_w;
logic        mem_write_w;
logic        mem_to_reg_w;
logic        jump_w;
logic        zero_w;
logic [1:0]  alu_control_w;
logic [4:0]  write_reg;
logic [31:0] sign_imm_w;
logic [31:0] shifted_imm_w;
logic [31:0] result;
logic [31:0] src_a_w;
logic [31:0] src_b_w;
logic [31:0] rd2_w;
logic [31:0] alu_res_w;
logic [31:0] pc_plus4_w;
logic [31:0] pc_barnch_w;
logic [31:0] pc_next_w;
logic [31:0] pc_decide_w;
logic [31:0] pc_jump_w;

//-----------------Data Path Flow-----------------\\
ControlUnit Cu(
    .opcode(instruction[31:26]),
    .funct(instruction[5:0]),
    .zero_flag(zero_w),

    .alu_control(alu_control_w),
    .mem_to_reg(mem_to_reg_w),
    .mem_write(mem_write_w),
    .alu_src(alu_src_w),
    .reg_dest(reg_dest_w),
    .reg_write(reg_write_w),
    .jump(jump_w),
    .pc_src(pc_src_w)
);

MUX #(5) m1(
    .data_true(instruction[15:11]),
    .data_false(instruction[20:16]),
    .sel(reg_dest_w),

    .data_out(write_reg)
);

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

SignExtn se(
    .data_in(instruction[15:0]),

    .data_signed(sign_imm_w)
);

MUX #(32) m2(
    .data_true(sign_imm_w),
    .data_false(rd2_w),
    .sel(alu_src_w),

    .data_out(src_b_w)
);

ALU #(32) alu(
    .reset_n(reset_n),
    .src_a(src_a_w),
    .src_b(src_b_w),
    .opcode(alu_control_w),

    .alu_result(alu_res_w),
    .zero_flag(zero_w)
);

assign write_data = rd2_w;

//-----------------Next PC logic-----------------\\
Shifter #(2,1,32) sh1(
    .data_in(sign_imm_w),

    .data_out(shifted_imm_w)
);

Adder #(32) add1(
    .reset_n(reset_n),
    .data_a(pc),
    .data_b(32'd4),

    .data_res(pc_plus4_w)
);

Adder #(32) add2(
    .reset_n(reset_n),
    .data_a(shifted_imm_w),
    .data_b(pc_plus4_w),

    .data_res(pc_barnch_w)
);

MUX #(32) m3(
    .data_true(pc_barnch_w),
    .data_false(pc_plus4_w),
    .sel(pc_src_w),

    .data_out(pc_decide_w)
);

assign pc_jump_w = {pc_plus4_w[31:28],instruction[25:0],2'b00};

MUX #(32) m4(
    .data_true(pc_jump_w),
    .data_false(pc_decide_w),
    .sel(jump_w),

    .data_out(pc_next_w)
);

DFF dff1(
    .reset_n(reset_n),
    .clock(clock),
    .d(pc_next_w),

    .q(pc)
);

endmodule