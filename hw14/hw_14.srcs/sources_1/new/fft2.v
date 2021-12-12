
module fft2(
    input signed [7:0] xt0, xt1,     // input signal
    output wire signed [8:0] xk0, xk1 // output signal
);

    // implement a 2-point butterfly FFT
    assign xk0 = xt0 + xt1;
    assign xk1 = xt0 - xt1;
    
endmodule
