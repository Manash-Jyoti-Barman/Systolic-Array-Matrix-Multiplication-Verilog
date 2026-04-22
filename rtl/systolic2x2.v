`timescale 1ns / 1ps

module systolic2x2(
	input clk, rst_n,
	input [3:0] a1, a2, b1, b2,
	output [8:0] c1, c2
);
	wire [3:0] wb11, wb12, wb21, wb22, wa11, wa12, wa21, wa22;
	wire [8:0] wc1, wc2;
	wire valid1, valid2, wv11, wv12, wv21, wv22;
	
	valid_checker Valid(clk, rst_n, b1, valid1, valid2);
	
	pe PE11(clk, rst_n, valid1, a1, b1, 9'b0, wa11, wb11, wc1, wv11);
	pe PE12(clk, rst_n, valid2, wa11, b2, 9'b0, wa12, wb12, wc2, wv12);
	pe PE21(clk, rst_n, wv11, a2, wb11, wc1, wa21, wb21, c1, wv21);
	pe PE22(clk, rst_n, wv12, wa21, wb12, wc2, wa22, wb22, c2, wv22);

endmodule
