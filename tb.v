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
RW = 4;
R1 = 0;
R2 = 0;
WriteData = 18;

#10;
WE = 1;
RW = 16;
R1 = 0;
R2 = 0;
WriteData = 29;

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

/* till now we read from r1 and r2 ports separately, now since we have 2 read ports, 
we must be able to read from both the ports simultaneously 
We wrote and read from register number 8 and 12, now lets read from register 4 and 16*/

#10;
WE = 0;
RW = 0;
R1 = 4;
R2 = 16;
WriteData = 0;

// verifying that write does not happen when WE = 0:
#10;
WE = 0;
RW = 2;
R1 = 2;
R2 = 0;
WriteData = 19;
// expected R1 = 0;


// since we have 2R1W, we can do simultaneously read and write both:
#10;
WE = 1;
RW = 2;
R1 = 8;
R2 = 2;
WriteData = 11;

/* at the end, we see that the ReadData2 gives output only at the posedge of clk, 
while this type of behaviour is not seen for other corners. This is because we are writing
and reading simultaneously. Write happens only at the posedge clk and read is combinational.
So, when once the value is written at the posedge of clk, read immediately goes high.
*/

#10;
$finish;

end

endmodule
