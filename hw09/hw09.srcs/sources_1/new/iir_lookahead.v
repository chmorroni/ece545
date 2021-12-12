
module iir_lookahead(
    input signed [11:0] x, // input signal
    input clk,             // clock
    output reg [11:0] y    // output signal (12 bits)
);
 
    parameter B = 14;            // bits in intermediate products
    reg signed [B-1:0] xi [2:1]; // 2 intermediate producte from x
    reg signed [B-1:0] yi;       // 1 intermediate product that includes y
    
    // reset the intermediates and output to 0
    initial begin
        xi[1] <= 0;
        xi[2] <= 0;
        yi <= 0;
        y <= 0;
    end

    // calculate the intermediates and output
    always @(posedge clk)
    begin : LOOKAHEAD
        xi[1] <= (x >> 2) + (x >> 3); // multiply by 3/8
        xi[2] <= xi[1] + x;
        yi <= (y >> 3) + (y >> 6); // multiply by 9/64
        y <= xi[2] + yi;
    end
    
endmodule
