`timescale 1ns / 1ps

module tx_testbench(
);

    wire signed [7:0] y; // output signal
    reg clk, rst;        // clock and reset signals
    
    transmit tx (
        .clk (clk), // clock signal
        .rst (rst), // clock signal
        .tx_sig (y) // output signal
    );
    
    initial begin
        clk <= 0;
        rst = 1;
        #6 rst = 0;
    end
    
    // create the clock signal for the sample rate (100MHz)
    always #5 clk = ~clk;

endmodule
