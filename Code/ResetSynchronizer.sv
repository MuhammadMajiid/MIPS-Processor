//  AUTHOR: Mohamed Maged Elkholy.
//  INFO.: Undergraduate ECE student, Alexandria university, Egypt.
//  AUTHOR'S EMAIL: majiidd17@icloud.com
//  FILE NAME: ResetSynchronizer.sv
//  TYPE: module.
//  DATE: 8/10/2022
//  KEYWORDS: Reset Synchronizer, Asynchronous reset.
//  PURPOSE: An RTL modelling for an Active low Reset Synchronizer.

module ResetSynchronizer 
(
    input  logic reset_n,       //  Active low asynchronous reset.
    input  logic clock,         //  System's clock.

    output logic reset_n_synch  //  The Synchronized Reset-deassertion.
);

//  The Synchronizer logic
always_ff @(posedge clock or negedge reset_n) begin
    if(!reset_n)
    begin
        reset_n_synch  <= 1'b0;
    end
    else 
    begin
        reset_n_synch  <= 1'b1;
    end
end

endmodule