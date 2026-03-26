module systolic (
        input clk,
        input rst_n,
        input in_valid,

        input [3:0] a11,
        input [3:0] a12,
        input [3:0] a21,
        input [3:0] a22,

        input [3:0] b11,
        input [3:0] b12,
        input [3:0] b21,
        input [3:0] b22,

        output wire [8:0] c11,
        output wire [8:0] c12,
        output wire [8:0] c21,
        output wire [8:0] c22,

        output wire out_valid
);

        wire [3:0] a_pe11;
        wire [3:0] a_pe21;

        wire clr_pe21;
        wire clr_pe22;

        systolic_controller controller (
                clk, rst_n, in_valid, a11, a12, a21, a22, a_pe11, a_pe21, clr_pe21, clr_pe22, out_valid
        );

        systolic_datapath datapath (
                clk, rst_n, a_pe11, a_pe21, b11, b12, b21, b22, clr_pe21, clr_pe22, c11, c12, c21, c22
        );

endmodule

