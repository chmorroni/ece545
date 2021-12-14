
module bpsk_tx(
    input signed data,         // input signal
    input clk,                 // clock
    input rst,                 // reset
    input en,                  // enable
    output wire signed [7:0] y // output signal
);

    parameter carrier_incr = 1; // the increment value for the carrier NCO
    wire [7:0] carrier_signal_unsigned;
    wire signed [7:0] carrier_signal;
    wire [7:0] acc;

    // setup the NCO for the carrier frequency
    fun_text signal_gen (
        .clk (clk),
        .reset (rst),
        .en (en),
        .M (carrier_incr),
        .sin (carrier_signal_unsigned),
        .acc (acc)
    );
    
    // convert to signed signal
    assign carrier_signal = carrier_signal_unsigned - 128;
    
    // do the actual BPSK encoding
    assign y = (data == 0) ? carrier_signal : -carrier_signal;
    
endmodule
