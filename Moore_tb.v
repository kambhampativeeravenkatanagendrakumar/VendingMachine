`timescale 1ns / 1ps

module Moore_tb;

    reg clock;
    reg reset;
    reg fiveRupees;
    reg tenRupees;
    reg twentyFiveRupees;
    wire theProduct;

    Moore uut (
        .clock(clock),
        .reset(reset),
        .fiveRupees(fiveRupees),
        .tenRupees(tenRupees),
        .twentyFiveRupees(twentyFiveRupees),
        .theProduct(theProduct)
    );

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        reset = 1;
        fiveRupees = 0;
        tenRupees = 0;
        twentyFiveRupees = 0;
        
        #10;
        reset = 0;

        #10;
        fiveRupees = 1;
        #10; fiveRupees = 0;

        #10;
        tenRupees = 1;
        #10; tenRupees = 0;

        #10;
        tenRupees = 1;
        #10; tenRupees = 0;

        #20;

        twentyFiveRupees = 1;
        #10; twentyFiveRupees = 0;

        #20;

        fiveRupees = 1;
        #10; fiveRupees = 0;

        tenRupees = 1;
        #10; tenRupees = 0;

        #20;

        $stop;
    end

    initial begin
        $monitor("Time=%0t | Reset=%b | 5=%b | 10=%b | 25=%b | Product=%b | State=%b",
                 $time, reset, fiveRupees, tenRupees, twentyFiveRupees, theProduct, uut.currentState);
    end

endmodule
