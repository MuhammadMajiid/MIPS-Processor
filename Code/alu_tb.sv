`timescale 1ns/1ps
module alu_tb;

logic                 reset_n_tb;
logic [7:0] src_a_tb;
logic [7:0] src_b_tb;
logic [2:0]           alu_control_tb;

logic [7:0] alu_result_tb;
logic zero_flag_tb;

ALU #(8) aluTest (
    .reset_n(reset_n_tb),
    .src_a(src_a_tb),
    .src_b(src_b_tb),
    .alu_control(alu_control_tb),

    .alu_result(alu_result_tb),
    .zero_flag(zero_flag_tb)
);

initial begin
    $monitor($time, " @ SrcA = %b   SrcB = %b   AluControl = %b  >>> The AluResult = %b   ZeroFlag = %b",
    src_a_tb, src_b_tb, alu_control_tb, alu_result_tb, zero_flag_tb);
end

initial begin
    reset_n_tb = 1'b1;
    #10;
    reset_n_tb = 1'b0;
    #10;
    reset_n_tb = 1'b1;
end

integer i;
initial begin
    src_a_tb = $urandom();
    src_b_tb = $urandom();
    alu_control_tb = $urandom();
    #20;
    for ( i=0 ; i<8 ; i++ ) begin
        alu_control_tb = i;
        src_a_tb = $urandom();
        src_b_tb = $urandom();
        #10;
    end
end

    
endmodule