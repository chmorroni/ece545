`timescale 100ns / 1ps

module testbench(
);

    reg signed [7:0] xt [1:0]; // fft input signal
    wire signed [8:0] xk [1:0]; // fft output signal
    reg clk; // clock
    
    // setup the FFT block
    fft transform (
        .xt0 (xt[0]),
        .xt1 (xt[1]),
        .clk (clk),
        .xk0 (xk[0]),
        .xk1 (xk[1])
    );
    
    initial begin
        // setup DC input
        clk <= 0;
        xt[0] <= 7'H10;
        xt[1] <= 7'H10;
        
        #5
        clk <= 1;
        
        #5 // setup Nyquist cosine input
        clk <= 0;
        xt[0] <= 7'H10;
        xt[1] <= -7'H10;
        
        #5
        clk <= 1;
    end

endmodule
