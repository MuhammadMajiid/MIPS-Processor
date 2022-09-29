//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: SignExtn.sv
//  TYPE: module.
//  DATE: 28/9/2022
//  KEYWORDS: Sign Extension.
//  PURPOSE: An RTL modelling for a parametrized sign extension unit.

module SignExtn
//-----------------Parameters-----------------\\ 
#(
    parameter   BEFORE     = 16,
                AFTER      = 32,
                SIGNAMOUNT = (AFTER-BEFORE) 
)
//-----------------Ports-----------------\\
(
    input  logic [(BEFORE-1):0] data_in,

    output logic [(AFTER-1):0] data_signed
);

//-----------------Output logic-----------------\\
always_comb
begin
    if(data_in[(BEFORE-1)])
    begin
        data_signed = {{SIGNAMOUNT{1'b1}},data_in};
        //  Ones extenstion if the last bit is 1.
    end
    else
    begin
        data_signed = {{SIGNAMOUNT{1'b0}},data_in};
        //  Zeros extenstion if the last bit is 0.
    end
end
    
endmodule