module tb_systolic;

        reg clk;
        reg rst_n;
        reg in_valid;

        reg [3:0] a11;
        reg [3:0] a12;
        reg [3:0] a21;
        reg [3:0] a22;

        reg [3:0] b11;
        reg [3:0] b12;
        reg [3:0] b21;
        reg [3:0] b22;

        wire [8:0] c11;
        wire [8:0] c12;
        wire [8:0] c21;
        wire [8:0] c22;

        wire out_valid;

        systolic dut (
                clk, rst_n, in_valid, a11, a12, a21, a22, b11, b12, b21, b22, c11, c12, c21, c22, out_valid
        );

        always #5 clk = ~clk;

        initial begin
        	$dumpfile("tb_systolic.vcd");
                $dumpvars(0, tb_systolic);
                
                clk = 0;
                rst_n = 0;
                in_valid = 0;

                $monitor(
                        "T=%0t | cycle=%0d | a_pe11=%0d a_pe21=%0d | c11=%0d c12=%0d c21=%0d c22=%0d | out_valid=%b",
                        $time, dut.controller.cycle, dut.a_pe11, dut.a_pe21, c11, c12, c21, c22, out_valid
                );

                a11 = 0; a12 = 0; a21 = 0; a22 = 0;
                b11 = 0; b12 = 0; b21 = 0; b22 = 0;

                #20;
                rst_n = 1;

                #10;

                a11 = 1;  a12 = 2;
                a21 = 3;  a22 = 4;

                b11 = 5;  b12 = 6;
                b21 = 7;  b22 = 8;

                in_valid = 1;
                #10;
                in_valid = 0;

                wait(out_valid);

                #20;
                $finish;
        end

endmodule

