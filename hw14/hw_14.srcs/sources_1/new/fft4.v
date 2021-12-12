
module fft4(
    input signed [7:0] xt0, xt1, xt2, xt3,              // input signal
    input clk,                                          // clock
    output reg signed [9:0] xk0_r, xk1_r, xk2_r, xk3_r, // real output signal
    output reg signed [9:0] xk0_i, xk1_i, xk2_i, xk3_i  // imaginary output signal
);

    wire signed [8:0] xe[1:0]; // intermediate even values
    wire signed [8:0] xo[1:0]; // intermediate odd values
    
    // 2-point FFTs for the fisrt stage
    fft2 fft_e(
        .xt0 (xt0),
        .xt1 (xt2),
        .xk0 (xe[0]),
        .xk1 (xe[1])
    );
    fft2 fft_o(
        .xt0 (xt1),
        .xt1 (xt3),
        .xk0 (xo[0]),
        .xk1 (xo[1])
    );
    
    // combine intermediates with weights
    always @(posedge clk)
    begin : stage_2
    
        // X[0] = Xe[0] + Xo[0]
        xk0_r <= xe[0] + xo[0];
        xk0_i <= 0;
    
        // X[1] = Xe[1] + j*Xo[1]
        xk1_r <= xe[1];
        xk1_i <= xo[1];
    
        // X[2] = Xe[0] - Xo[0]
        xk2_r <= xe[0] - xo[0];
        xk2_i <= 0;
    
        // X[3] = Xe[0] - j*Xo[0]
        xk3_r <= xe[1];
        xk3_i <= -xo[1];
        
    end
    
endmodule
