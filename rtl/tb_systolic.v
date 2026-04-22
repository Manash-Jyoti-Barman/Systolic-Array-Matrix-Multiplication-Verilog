`timescale 1ns/1ps

module tb_systolic;
	reg clk, rst_n;
	reg [3:0] a1, a2, b1, b2;
	wire [8:0] c1, c2;
	
	systolic2x2 dut(
		clk, rst_n,
		a1, a2, b1, b2,
		c1, c2
	);
	
	always #5 clk = ~clk;
	
	initial begin
		$dumpfile("wave_systolic.vcd");
		$dumpvars(0, tb_systolic);
		
		$display("               Time | rst_n | a1  a2  |   b1     b2  |  valid1 |  valid2 |  weight11   |  weight12   |  weight21   |  weight22   |   C1   |   C1   |"); 
		$monitor("%d|   %d   | %d  %d  |   %d     %d  |    %d    |    %d    |     %d      |     %d      |     %d      |     %d      |  %d   |  %d   |", $time, rst_n, a1, a2, b1, b2, dut.Valid.out1, dut.Valid.out2, dut.PE11.weight, dut.PE12.weight, dut.PE21.weight, dut.PE22.weight, c1, c2);
	end
	
	initial begin
		clk = 0;
		rst_n = 0;
		#10;
		rst_n = 1;
		
		//CYCLE0
		//preload = 1;
		b1 = 7;
		#10;
		
		//CYCLE1
		b1 = 5; b2 = 8;
		#10;
		
		//CYCLE2
		a1 = 1;
		b1 = 4'bx; b2 = 6;
		#10;
		
		//CYCLE3
		
		a1 = 3; a2 = 2;
		b2 = 4'bx;
		#10;
		
		//CYCLE4
		//preload = 0;
		a1 = 4'bx; a2 = 4;
		#10;
		
		//CYCLE5
		a1 = 4'bx; a2 = 4'bx;
		#10;
		#50;
		$finish;
	end
endmodule
