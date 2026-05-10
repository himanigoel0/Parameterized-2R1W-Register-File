`timescale 1ns / 1ps

module top #(
    parameter M = 32,
    parameter N = 32
)(
// We initialised M and N as 32. $clog2 se basic log base 2 le skte h.
    input clk, WE, 
    input [$clog2(M)-1:0] RW, R1, R2, 
    input [N-1:0] WriteData,
    output[N-1:0] ReadData1, ReadData2
 );
 
 // We are making M registers each N bit wide, calling this array as reg_file.
 reg [N-1:0] reg_file [M-1:0];
 
 // Jo krna h posedge clk pe hi krenge
 always @(posedge clk) begin
 /* 
    Jb WriteEnable = 1 hoga, tbhi RegisterWrite wale index pe jo register hoga
    usme hme WriteData jo bhi hoga wo likh denge. 
 */
 if (WE) begin
    reg_file[RW] <= WriteData;
 end
 end
 
/* 
   Ab, write krne ke lie to posedge clk chie thi but agar read krna h to 
   kbi b kr skte h. jese hi read signal aya, wese hi read krlo. So, we dont 
   need any sequential logic now. We will work with combinational only.
   Basic combinational block hm assign statement use krke bna skte h.
*/
 
 assign ReadData1 = reg_file[R1];
 assign ReadData2 = reg_file[R2];
 
endmodule
