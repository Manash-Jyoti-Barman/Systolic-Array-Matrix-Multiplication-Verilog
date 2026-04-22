`timescale 1ns / 1ps

module pe(
	input clk, rst_n, in_valid,
	input [3:0] ain, bin,
	input [8:0] cin,
	output reg [3:0] aout, 
	output reg [3:0] bout,
	output reg [8:0] psum,
	output reg out_valid
);
	reg [3:0] weight;
	wire valid;

	always @(posedge clk or negedge rst_n) begin
	   	if (!rst_n) begin
			weight <= 4'b0;
			aout <= 4'b0;
			bout <= 4'b0;
			psum <= 9'b0;
			out_valid <= 1'b0;
	    	end
	    	else begin
			if(in_valid)
		   		weight <= bin;

			aout <= ain;
			bout <= weight;
			psum <= cin + (ain * weight);
			out_valid <= in_valid;
	    	end
	end
endmodule
