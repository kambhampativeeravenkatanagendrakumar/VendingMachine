`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2025 14:22:22
// Design Name: 
// Module Name: Mealy_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Mealy_tb;

    reg clock;
    reg reset;
    reg fiveRupees;
    reg tenRupees;
    reg twentyFiveRupees;
    wire theProduct;

    Mealy uut (
        .clock(clock),
        .reset(reset),
        .fiveRupees(fiveRupees),
        .tenRupees(tenRupees),
        .twentyFiveRupees(twentyFiveRupees),
        .theProduct(theProduct)
    );

    always #5 clock = ~clock;

    initial begin
        clock = 0;
        reset = 1;
        fiveRupees = 0;
        tenRupees = 0;
        twentyFiveRupees = 0;

        #10 reset = 0;

        #10 fiveRupees = 1; #10 fiveRupees = 0;
        #10 fiveRupees = 1; #10 fiveRupees = 0;
        #10 tenRupees = 1; #10 tenRupees = 0;
        #10 twentyFiveRupees = 1; #10 twentyFiveRupees = 0;

        #10 tenRupees = 1; #10 tenRupees = 0;
        #10 tenRupees = 1; #10 tenRupees = 0;
        #10 fiveRupees = 1; #10 fiveRupees = 0;

        #10 twentyFiveRupees = 1; #10 twentyFiveRupees = 0;

        #50 $finish;
    end

    initial begin
        $monitor("Time=%0t | State=%b | 5=%b 10=%b 25=%b | Product=%b", 
                 $time, uut.currentState, fiveRupees, tenRupees, twentyFiveRupees, theProduct);
    end

endmodule

