`timescale 10ns / 1ps

module sweptnco_tb(
);

    wire [7:0] sine;      // unsigned waveform from function generator
    wire signed [7:0] x;  // filter input signal
    wire signed [17:0] y; // filter output signal
    reg clk, rst;         // clock and reset
    reg [31:0] incr;      // 32 bit counter for the function generator
    integer i;            // for loop iterator
    wire [7:0] acc;       // accumulator signal for the NCO
    
    fir_rag filter (
        .x0 (x),    // input signal
        .clk (clk), // clock signal
        .y (y)      // output signal
    );
    
    // setup the function generator
    fun_text f_gen (
        .clk (clk),
        .reset (rst),
        .M (incr),
        .sin (sine),
        .acc (acc)
    );
    
    // shift signal from [0, 255] to [-128, 127]
    assign x = sine - 128;
    
    initial begin
        // reset the function generator
        clk <= 0;
        rst = 1;
        #1 rst = 0;
        
        // sweep the function generator
        //   start at 1kHz (2^32 * 1kHz / 10MHz = 429496)
        //   end at 5MHz (2^32 * 5MHz / 10MHz = 2147483648)
        //   over 1ms ((2147483648 - 429496) / (10MHz * 1ms) = 214705)
        incr = 429496;
        for (i=0; i<10000; i=i+1) begin
            #10 incr = incr + 214705;
        end
    end
    
    // create the clock signal (10MHz)
    always #5 clk = ~clk;

endmodule
