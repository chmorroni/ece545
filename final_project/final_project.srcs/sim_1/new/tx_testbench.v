`timescale 1ns / 1ps

module tx_testbench(
);

    wire signed [15:0] y; // output signal
    wire valid;           // valid signal
    reg clk, rst, en;     // clock, reset, and enable signals
    
    transmit tx (
        .clk (clk),           // clock signal
        .rst (rst),           // reset signal
        .s_axis_ready (en),   // enable signal
        .tx_sig (y),          // output signal
        .s_axis_valid (valid) // valid signal
    );
    
    initial begin
        clk <= 0;
        en <= 1;

        rst = 1;
        #6 rst <= 0;

        // test the enable signal
        #40000 en = 0;
        #10000 en = 1;
    end
    
    // create the clock signal for the sample rate (100MHz)
    always #5 clk = ~clk;

endmodule
