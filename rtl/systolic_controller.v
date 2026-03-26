module systolic_controller (
        input clk,
        input rst_n,
        input in_valid,

        input [3:0] a11,
        input [3:0] a12,
        input [3:0] a21,
        input [3:0] a22,

        output reg [3:0] a_pe11,
        output reg [3:0] a_pe21,

        output reg clr_pe21,
        output reg clr_pe22,

        output reg out_valid
);

        reg [2:0] cycle;
        reg active;

        always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                        cycle <= 3'd0;
                        active <= 1'b0;
                        a_pe11 <= 4'd0;
                        a_pe21 <= 4'd0;
                        clr_pe21 <= 1'b0;
                        clr_pe22<= 1'b0;
                        out_valid <= 1'b0;
                end
                else begin
                        clr_pe21 <= 1'b0;
                        clr_pe22 <= 1'b0;
                        out_valid <= 1'b0;

                        if (in_valid && !active) begin
                                active <= 1'b1;
                                cycle<= 3'd0;
                        end
                        else if (active) begin
                                cycle <= cycle + 3'd1;
                                if (cycle == 3'd4)
                                        active <= 1'b0;
                        end

                        if (active) begin
                                case (cycle)
                                        3'd0: begin
                                                a_pe11 <= a11;
                                                a_pe21 <= 4'd0;
                                        end
                                        3'd1: begin
                                                a_pe11 <= a21;
                                                a_pe21 <= a12;
                                        end
                                        3'd2: begin
			        		a_pe11 <= 4'd0;
			        		a_pe21 <= a22;
					end

		        		3'd3: begin
						a_pe11 <= 4'd0;
						a_pe21 <= 4'd0;
						clr_pe21 <= 1'b1;
					end

					3'd4: begin
						clr_pe22 <= 1'b1;
						out_valid <= 1'b1;
					end

                                endcase
                        end
                        else begin
                                a_pe11 <= 4'd0;
                                a_pe21 <= 4'd0;
                        end
                end
        end

endmodule

