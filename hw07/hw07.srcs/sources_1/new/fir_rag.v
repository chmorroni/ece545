
module fir_rag(
    input signed [7:0] x0, // input signal
    input clk,             // clock
    output reg [B-1:0] y   // output signal (18 bits)
);
 
    parameter B = 28;           // bits in intermediate products
    reg signed [B-1:0] x [9:0]; // array for tapped delay line with intermediate clk
                                // 11 filter coefficients (but the last part of the tapped delay line is just the output)
                                // 18 bits for intermediate products
    integer i;                  // for loop iterator
    
    // reset the tapped delay to all 0s
    initial begin
        for (i=0; i<B; i=i+1) begin
            x[i] <= 0;
        end
        y <= 0;
    end

    // calculate the outputs from the adder graph
    always @(posedge clk)
    begin : RAG
        // calculate the intermediate products
        reg signed [B-1:0] intermediates[2:0];
        intermediates[0] = x0 + (x0 <<< 1);                             // 3x[n]
        intermediates[1] = (intermediates[0] <<< 3) + x0;               // 25x[n]
        intermediates[2] = (intermediates[1] <<< 1) + intermediates[1]; // 75x[n]
        
        // advance the tapped delay line and add in new values
        x[0] <= intermediates[0];               // 3x[n]
        x[1] <= x[0];                           // add 0x[n-1]
        x[2] <= x[1] - intermediates[1];        // subtract 25x[n-2]
        x[3] <= x[2];                           // add 0x[n-3]
        x[4] <= x[3] + (intermediates[2] << 1); // add 150x[n-4]
        x[5] <= x[4] + (x0 <<< 8);              // add 256x[n-5]
        x[6] <= x[5] + (intermediates[2] << 1); // add 150x[n-6]
        x[7] <= x[6];                           // add 0x[n-7]
        x[8] <= x[7] - intermediates[1];        // subtract 25x[n-8]
        x[9] <= x[8];                           // add 0x[n-9]
        y <= x[9] + intermediates[0];           // add 3x[n-10]
    end
    
endmodule
