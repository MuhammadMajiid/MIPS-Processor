//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: DFF.sv
//  TYPE: module.
//  DATE: 28/9/2022
//  KEYWORDS: D-FlipFlop, Asynchronous reset.
//  PURPOSE: An RTL modelling for a D-FlipFlop with Asynchronous active low reset.

module DFF
//-----------------Ports-----------------\\
(
    input  logic reset_n,
    input  logic clock,
    input  logic d,

    output logic q
);

//-----------------Logic-----------------\\
always_ff @(posedge clock, negedge reset_n)
begin
    if(!reset_n)
    begin
        q <= 1'b0;
    end
    else
    begin
        q <= d;
    end
end

endmodule