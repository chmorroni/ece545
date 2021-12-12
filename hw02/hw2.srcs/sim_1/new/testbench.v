`timescale 1ns / 1ps

module testbench(
    );
    
    reg[4:0] a, b, c, d;
    wire[3:0] u, v, w, x, y, z;
    reg[3:0] test;
    
    qv2g iut (a[3:0], b[3:0], c[3:0], d[3:0], u, v, w, x, y, z);
    
    initial
    begin
    
        $display("Beginning test");
    
        for (a=0; a<16; a=a+1)
        begin
            for (b=0; b<16; b=b+1)
            begin
            
                for (c=0; c<16; c=c+1)
                begin
                
                    for (d=0; d<16; d=d+1)
                    begin
                        #1 // delay for signals to propogate
                        if(u != (a + b - c + d))
                            $display("Failed output u for inputs a =", a, ", b =", b, ", c =", c, ", d =", d);
                        if(v != ((a + b) - (c - d)))
                            $display("Failed output u for inputs a =", a, ", b =", b, ", c =", c, ", d =", d);
                        if(w != (a + b +c))
                            $display("Failed output u for inputs a =", a, ", b =", b, ", c =", c, ", d =", d);
                        if(x != (a - b - c))
                            $display("Failed output u for inputs a =", a, ", b =", b, ", c =", c, ", d =", d);
                        if(y != (a + (b + c)))
                            $display("Failed output u for inputs a =", a, ", b =", b, ", c =", c, ", d =", d);
                        if(z != (a - (b + c)))
                            $display("Failed output u for inputs a =", a, ", b =", b, ", c =", c, ", d =", d);
                    end
                    
                end
                
            end
            
        end

        $display("Test Complete");
        
    end
    
endmodule
