//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: InstrMem.v
//  TYPE: module.
//  DATE: 8/10/2022

module InstrMem 
#(
    parameter myPROGRAM = "prog1.txt"
)
(
    input  logic [31:0] pc,

    output logic [31:0] instr
);

logic [31:0] ram [127:0];

initial
begin
    $readmemh(myPROGRAM, ram);
end

assign instr = ram[pc>>2];

endmodule