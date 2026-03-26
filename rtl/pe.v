module pe (
        input  wire clk,
	input  wire rst_n,

        input  wire [3:0] a_in,
        input  wire [3:0] b,
        input  wire [8:0] cin,

        input  wire clr_psum,

        output reg [3:0] a_out,
        output wire [8:0] cout
);

        reg [8:0] psum;

        always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                        psum <= 9'b0;
                        a_out <= 4'b0;
                end
                else begin
                        a_out <= a_in;

                        if (clr_psum)
                                psum <= 9'b0;
                        else
                                psum <= cin + (a_in * b);
                end
        end

        assign cout = psum;

endmodule

