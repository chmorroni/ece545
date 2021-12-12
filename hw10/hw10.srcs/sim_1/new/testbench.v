`timescale 10ns / 1ps

module testbench(
);

    reg clk, rst_signal, rst_filter;      // clock and reset
    wire [7:0] signal_base, signal_noise; // signals from function generators
    reg [31:0] incr_base, incr_noise;     // 32 bit increment values for the function generator
    wire signed [7:0] d, x;               // filter input signals
    wire signed [15:0] y, e;              // filter output signal
    
    fir_lms filter (
        .clk (clk),
        .reset (rst_filter),
        .x_in (x),
        .d_in (d),
        .f0_out (),
        .f1_out (),
        .y_out (y),
        .e_out (e)
    );
    
    // setup the base signal generator
    fun_text signal_gen (
        .clk (clk),
        .reset (rst_signal),
        .M (incr_base),
        .sin (signal_base),
        .acc ()
    );
    
    // setup the interferance signal generator
    fun_text noise_gen (
        .clk (clk),
        .reset (rst_signal),
        .M (incr_noise),
        .sin (signal_noise),
        .acc ()
    );
    
    // signal plus 1/4 * noise; maintain 8-bit precision; shifted for signed
    assign x = signal_noise - 128;
    assign d = ((signal_base - 128) + (x >>> 2)) >>> 1;
    
    initial begin
        // reset the signal generators
        clk <= 0;
        rst_filter <= 1;
        rst_signal = 1;
        #1 rst_signal = 0;
        #5 rst_filter = 0; // reset the filter after the first clock cycle, so the signals are valid
    end
    
    initial begin
        // setup the signal generators
        incr_base <= 300647710;     // 700kHz (2^32 * 700kHz / 10MHz = 300647710)
        incr_noise = 0;             // phase the noise in after a couple cycles, to make it more visible
        #20 incr_noise = 901943132; // 2.1MHz (2^32 * 2.1MHz / 10MHz = 901943132)
    end
    
    // create the clock signal (10MHz)
    always #5 clk = ~clk;

endmodule
