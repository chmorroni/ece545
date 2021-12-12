
module fft(
    input signed [7:0] xt0, xt1,     // input signal
    input clk,                       // clock
    output reg signed [8:0] xk0, xk1 // output signal
);

    // implement a 2-point butterfly FFT
    always @(posedge clk)
    begin : fft
        xk0 <= xt0 + xt1;
        xk1 <= xt0 - xt1;
    end
    
endmodule
