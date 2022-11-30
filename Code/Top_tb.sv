`timescale 1ns/1ps
module Top_tb;

////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////-----------------DUT-----------------\\\\\\\\\\\\\\\\\\
////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
reg         reset_n_tb;
reg         clock_tb;
wire [15:0] test_value_tb;

Top dut(
    .reset_n(reset_n_tb),
    .clock(clock_tb),

    .test_value(test_value_tb)
);
//-------------> Parameters
parameter CLKPERIOD = 10;

//-------------> Save wave from
initial
begin
    $dumpfile("Mips.vcd");
    $dumpvars;
end

/////////////////-----------------Clock-----------------\\\\\\\\\\\\\\\\\\ 
initial begin
    forever begin
        #CLKPERIOD clock_tb = ~clock_tb;
    end
end

/////////////////-----------------Test-----------------\\\\\\\\\\\\\\\\\\
initial
begin
    Initialization();
    Reset();
end

////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/////////////////-----------------Tasks-----------------\\\\\\\\\\\\\\\\\
////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
task Initialization;
begin
    clock_tb   = 1'b0;
    reset_n_tb = 1'b1;
end
endtask

task Reset;
begin
   #CLKPERIOD     reset_n_tb = 1'b0;
   #(2*CLKPERIOD) reset_n_tb = 1'b1;
end
endtask

endmodule