`timescale 1ns / 1ps

module qv2g(
    input [3:0] a, b, c, d,
    output reg[3:0] u, v, w, x, y, z
);

    always @(a, b, c, d)
    begin : P0
        u <= a + b - c + d;
    end
    
    always @(a, b, c, d)
    begin : P1
        v <= (a + b) - (c - d);
    end
    
    always @(a, b, c)
    begin : P2
        w <= a + b + c;
        x <= a - b - c;
    end
    
    always @(a, b, c)
    begin : P3
        reg[3:0] t1;
        t1 = b + c;
        y <= a + t1;
        z <= a - t1;
    end

endmodule
