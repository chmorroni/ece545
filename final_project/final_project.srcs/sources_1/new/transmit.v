
module transmit(
    input clk,                        // clock
    input rst,                        // reset
    input s_axis_ready,               // signal from the TX subsystem to indicate it is ready for data
    output wire signed [15:0] tx_sig, // TX output signal
    output reg s_axis_valid           // indicate the signal is valid
);
    
    reg [12*7:0] data = "Hello world!";

    reg data_out;
    reg [7:0] idx;

    assign tx_sig[7:0] = 0;
    
    bpsk_tx encoder (
        .data (data_out),   // input signal
        .clk (clk),         // clock signal
        .rst (rst),         // reset signal
        .en (s_axis_ready), // use the ready signal as an enable
        .y (tx_sig[15:8])   // output signal
    );
    defparam encoder.carrier_incr = 4294967; // run the carrier at 100kHz

    initial begin
        data_out <= data[0];
        idx <= 0;
		s_axis_valid <= 0;
    end
    
    reg [9:0] divider = 0;
    always @(posedge clk)
    begin : symbol_sequence
        if (s_axis_ready == 1) begin
            // shift in signals at 100kHz
            divider = divider + 1;
            if (divider == 1000) begin
                divider <= 0;
                idx = idx + 1;
                if (idx == 12*7) begin
                    idx = 0;
                end
                data_out <= data[idx];
            end

            s_axis_valid <= 1;
        end else begin
            s_axis_valid <= 0;
        end
    end

endmodule
