//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: MUX.sv
//  TYPE: module.
//  DATE: 29/9/2022
//  KEYWORDS: Multiplexer.
//  PURPOSE: An RTL modelling for a parametrized 2-1 multiplexer.

module MUX 
//-----------------Parameters-----------------\\
#(
    parameter BUS = 32  
)
//-----------------Ports-----------------\\
(
    input  logic [(BUS-1):0] data_true,
    input  logic [(BUS-1):0] data_false,
    input  logic             sel,

    output logic [(BUS-1):0] data_out
);

//-----------------Output logic-----------------\\
assign data_out = sel? data_true : data_false;
    
endmodule