
module transmit(
    input clk,  // clock
    input rst,  // reset
    output wire signed [7:0] tx_sig
);
    
    reg [12*7:0] data = "Hello world!";

    reg data_out;
    reg [7:0] idx;
    
    bpsk_tx encoder (
        .data (data_out), // input signal
        .clk (clk),       // clock signal
        .rst (rst),       // reset signal
        .y (tx_sig)       // output signal
    );
    defparam encoder.carrier_incr = 4294967; // run the carrier at 100kHz

    initial begin
        data_out <= data[0];
        idx <= 0;
    end
    
    reg [9:0] divider = 0;
    always @(posedge clk)
    begin : symbol_sequence
        // shift in signals at 100kHz
        divider = divider + 1;
        if (divider == 1000) begin
            divider = 0;

            idx = idx + 1;
            if (idx == 12*7) begin
                idx = 0;
            end
            data_out <= data[idx];
        end
    end

endmodule
