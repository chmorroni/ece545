`timescale 100ns / 1ps

module testbench(
);

    reg signed [11:0] x;  // filter input signal
    wire signed [11:0] y; // filter output signal
    reg clk;              // clock
    
    iir_lookahead filter (
        .x (x),     // input signal
        .clk (clk), // clock signal
        .y (y)      // output signal
    );
    
    initial begin
        clk <= 0;
        
        // create the impulse function
        x = 0;
        x = 100; #2
        x = 0;
    end
    
    // create the clock signal
    always #1 clk = ~clk;

endmodule
