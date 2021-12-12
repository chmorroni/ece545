`timescale 100ns / 1ps

module impulse_tb(
);

    reg signed [7:0] x;   // filter input signal
    wire signed [17:0] y; // filter output signal
    reg clk;              // clock
    
    fir_rag filter (
        .x0 (x),    // input signal
        .clk (clk), // clock signal
        .y (y)      // output signal
    );
    
    initial begin
        clk <= 0;
        
        // create the delta function
        x = 0; #2
        x = 1; #2
        x = 0;
    end
    
    // create the clock signal
    always #1 clk = ~clk;

endmodule
