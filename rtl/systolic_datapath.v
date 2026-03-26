module systolic_datapath (
        input clk,
        input rst_n,

        input [3:0] a_pe11,
        input [3:0] a_pe21,

        input [3:0] b11,
        input [3:0] b12,
        input [3:0] b21,
        input [3:0] b22,

        input clr_pe21,
        input clr_pe22,

        output wire [8:0] c11,
        output wire [8:0] c12,
        output wire [8:0] c21,
        output wire [8:0] c22
);

        wire [3:0] wa1;
        wire [3:0] wa2;

        pe PE11 (clk, rst_n, a_pe11, b11, 9'b0, 1'b0, wa1, c11);
        pe PE12 (clk, rst_n, wa1, b12, 9'b0, 1'b0, , c12);
        pe PE21 (clk, rst_n, a_pe21, b21, c11, clr_pe21, wa2, c21);
        pe PE22 (clk, rst_n, wa2, b22, c12, clr_pe22, , c22);

endmodule

