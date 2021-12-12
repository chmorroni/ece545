`timescale 1ns / 1ps

module qv2g(
    input wire[3:0] a, b, c, d,
    output wire[3:0] u, v, w, x, y, z
    );

    assign u = a + b - c + d;
    assign v = (a + b) - (c - d);
    assign w = a + b + c;
    assign x = a - b - c;
    
    wire[3:0] t1;
    assign t1 = b + c;
    assign y = a + t1;
    assign z = a - t1;

endmodule
