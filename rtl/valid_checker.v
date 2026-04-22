`timescale 1ns / 1ps

module valid_checker(
	input clk, rst_n,
	input [3:0] in,
	output out1, out2
);
	reg d1;
	wire valid;
	always @(posedge clk or negedge rst_n) begin
    		if (!rst_n)
        		d1 <= 1'b0;
		else
        		d1 <= valid;
	end
	assign valid = (^in !== 1'bx);
	assign out1 = valid;
	assign out2 = d1;
endmodule