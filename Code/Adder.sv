//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: Adder.sv
//  TYPE: module.
//  DATE: 28/9/2022
//  KEYWORDS: Adder.
//  PURPOSE: An RTL modelling for a synthesis machine dependent parameterized adder.

module Adder 
//-----------------Parameters-----------------\\
#(
    parameter  BUS  = 32
)
//-----------------Ports-----------------\\
(
    input  logic             reset_n,
    input  logic [(BUS-1):0] data_a,
    input  logic [(BUS-1):0] data_b,

    output logic [(BUS-1):0] data_res
);

//-----------------Logic-----------------\\
assign data_res = reset_n? (data_a + data_b) : {BUS{1'b0}};

endmodule