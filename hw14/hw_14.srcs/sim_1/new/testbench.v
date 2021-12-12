`timescale 100ns / 1ps

module testbench(
);

    reg signed [7:0] xt [3:0]; // fft input signal
    wire signed [9:0] xk_r [3:0]; // fft real output signal
    wire signed [9:0] xk_i [3:0]; // fft imaginary output signal
    reg clk; // clock
    
    // setup the FFT block
    fft4 fft (
        .xt0 (xt[0]),
        .xt1 (xt[1]),
        .xt2 (xt[2]),
        .xt3 (xt[3]),
        .clk (clk),
        .xk0_r (xk_r[0]),
        .xk1_r (xk_r[1]),
        .xk2_r (xk_r[2]),
        .xk3_r (xk_r[3]),
        .xk0_i (xk_i[0]),
        .xk1_i (xk_i[1]),
        .xk2_i (xk_i[2]),
        .xk3_i (xk_i[3])
    );
    
    initial begin
        // setup DC input
        clk <= 0;
        xt[0] <= 7'H10;
        xt[1] <= 7'H10;
        xt[2] <= 7'H10;
        xt[3] <= 7'H10;
        
        #5
        clk <= 1;
        
        #5 // setup Nyquist cosine input
        clk <= 0;
        xt[0] <= 7'H10;
        xt[1] <= -7'H10;
        xt[2] <= 7'H10;
        xt[3] <= -7'H10;
        
        #5
        clk <= 1;
        
        #5 // setup fundamental cosine input
        clk <= 0;
        xt[0] <= 7'H10;
        xt[1] <= 7'H00;
        xt[2] <= -7'H10;
        xt[3] <= 7'H00;
        
        #5
        clk <= 1;
        
        #5 // setup fundamental sine input
        clk <= 0;
        xt[0] <= 7'H00;
        xt[1] <= 7'H10;
        xt[2] <= 7'H00;
        xt[3] <= -7'H10;
        
        #5
        clk <= 1;
    end

endmodule
