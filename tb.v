`timescale 1ns / 1ps

module tb #(
    parameter M = 32,
    parameter N = 32
)();
// Testbench has no I/P or O/P pins.
// Jo module me reg the wo isme wire ho jate and vice versa

reg clk, WE;
reg [$clog2(M)-1:0] RW, R1, R2;
reg [N-1:0] WriteData;
wire[N-1:0] ReadData1, ReadData2;

// Now instantiate the DUT top module with the name uut: 
top uut (clk, WE, RW, R1, R2, WriteData, ReadData1, ReadData2);

initial begin
clk = 0;
end

always #5 clk = ~clk;
// We initiated the clk with 0 and then toggle it at every 5 sec to create an infinite clk.

initial begin

WE = 0;
RW = 0;
R1 = 0;
R2 = 0;
WriteData = 0; 

#10;
WE = 1;
RW = 8;
R1 = 0;
R2 = 0;
WriteData = 7;

#10;
WE = 1;
RW = 12;
R1 = 0;
R2 = 0;
WriteData = 55;

#10;
WE = 0;
RW = 0;
R1 = 8;
R2 = 0;
WriteData = 0;

#10;
WE = 0;
RW = 0;
R1 = 0;
R2 = 12;
WriteData = 0;

#1;
$display("ReadData1 = %d", ReadData1);

#10;
$finish;

end

endmodule
