`timescale 10ns / 1ps

module tx_testbench(
);

    wire signed [7:0] y; // output signal
    reg clk, rst;        // clock and reset signals
    
    reg [7:0] data = "G";
    
    bpsk_tx encoder (
        .data (data[0]), // input signal
        .clk (clk),      // clock signal
        .rst (rst),      // reset signal
        .y (y)           // output signal
    );
    defparam encoder.carrier_incr = 42949672; // run the carrier at 100kHz
    
    initial begin
        clk <= 0;
        rst = 1;
        #6 rst = 0;
    end
    
    // create the clock signal for the sample rate (10MHz)
    always #5 clk = ~clk;
    
    reg [7:0] divider = 0;
    always @(posedge clk)
    begin : symbol_sequence
        // shift in signals at 100kHz
        divider = divider + 1;
        if (divider == 100) begin
            divider = 0;
            data = data >> 1;
        end
    end

endmodule
