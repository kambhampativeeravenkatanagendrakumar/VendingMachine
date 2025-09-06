`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2025 14:20:25
// Design Name: 
// Module Name: Mealy
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


module Mealy(input clock,
    input reset,
    input fiveRupees,
    input tenRupees,
    input twentyFiveRupees,
    output theProduct
    );

// State encoding using parameters
parameter State0 = 3'b000;
parameter State1 = 3'b001;
parameter State2 = 3'b010;
parameter State3 = 3'b011;
parameter State4 = 3'b100;

reg [2:0] currentState, nextState;
reg product;

// State register
always @(posedge clock or posedge reset) begin
    if (reset)
        currentState <= State0;
    else
        currentState <= nextState;
end

always @(*) begin
    product = 0; // default
    case (currentState)
        State0: begin
            if (fiveRupees) nextState = State1;
            else if (tenRupees) nextState = State2;
            else if (twentyFiveRupees) begin
                product = 1;
                nextState = State0;
            end
            else nextState = State0;
        end

        State1: begin
            if (fiveRupees) nextState = State2;
            else if (tenRupees) nextState = State3;
            else if (twentyFiveRupees) begin
                product = 1;
                nextState = State0;
            end
            else nextState = State1;
        end

        State2: begin
            if (fiveRupees) nextState = State3;
            else if (tenRupees) nextState = State4;
            else if (twentyFiveRupees) begin
                product = 1;
                nextState = State0;
            end
            else nextState = State2;
        end

        State3: begin
            if (fiveRupees) nextState = State4;
            else if (tenRupees) begin
                product = 1;
                nextState = State0;
            end
            else if (twentyFiveRupees) begin
                product = 1;
                nextState = State0;
            end
            else nextState = State3;
        end

        State4: begin
            if (fiveRupees || tenRupees || twentyFiveRupees) begin
                product = 1;
                nextState = State0;
            end
            else nextState = State4;
        end
    endcase
end

assign theProduct = product;
         
endmodule
