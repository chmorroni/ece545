
module moving_average_fir(
    input signed [7:0] x0, // input signal
    input clk,             // clock
    output reg [7:0] y     // output signal
);

    parameter L = 8;            // filter length
    reg signed [7:0] x [L-1:0]; // array for tapped delay line
    integer i;                  // for loop iterator
    
    // reset the tapped delay to all 0s
    initial begin
        for (i=0; i<L; i=i+1) begin
            x[i] <= 0;
        end
    end

    // on each clock, advance the tapped delat line
    always @(posedge clk)
    begin : tapped_delay
        x[0] <= x0;
        for (i=1; i<L; i=i+1) begin
            x[i] <= x[i-1];
        end
    end
    
    // calculate average
    always @(posedge clk)
    begin : filter
        // calculate the sum
        reg signed [7+L-1:0] sum;
        sum = 0;
        for (i=0; i<L; i=i+1) begin
            sum = sum + x[i];
        end
        
        y = sum / $signed(L);
    end
    
endmodule
