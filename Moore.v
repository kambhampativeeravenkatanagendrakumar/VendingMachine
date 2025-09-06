`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2025
// Module Name: Moore
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moore FSM version of vending machine
//
//////////////////////////////////////////////////////////////////////////////////

module Moore(
    input clock,
    input reset,
    input fiveRupees,
    input tenRupees,
    input twentyFiveRupees,
    output reg theProduct
    );

    // State encoding
    parameter State0 = 4'b0000; // 0
    parameter State1 = 4'b0001; // 5
    parameter State2 = 4'b0010; // 10
    parameter State3 = 4'b0011; // 15
    parameter State4 = 4'b0100; // 20
    parameter StateP = 4'b0101; // Product delivery state

    reg [3:0] currentState, nextState;

    // State register
    always @(posedge clock or posedge reset) begin
        if (reset)
            currentState <= State0;
        else
            currentState <= nextState;
    end

    // Next state logic
    always @(*) begin
        case (currentState)
            State0: begin
                if (fiveRupees) nextState = State1;
                else if (tenRupees) nextState = State2;
                else if (twentyFiveRupees) nextState = StateP;
                else nextState = State0;
            end

            State1: begin
                if (fiveRupees) nextState = State2;
                else if (tenRupees) nextState = State3;
                else if (twentyFiveRupees) nextState = StateP;
                else nextState = State1;
            end

            State2: begin
                if (fiveRupees) nextState = State3;
                else if (tenRupees) nextState = State4;
                else if (twentyFiveRupees) nextState = StateP;
                else nextState = State2;
            end

            State3: begin
                if (fiveRupees) nextState = State4;
                else if (tenRupees || twentyFiveRupees) nextState = StateP;
                else nextState = State3;
            end

            State4: begin
                if (fiveRupees || tenRupees || twentyFiveRupees)
                    nextState = StateP;
                else nextState = State4;
            end

            StateP: nextState = State0; // After product delivery, return to initial state

            default: nextState = State0;
        endcase
    end

    // Output logic (depends only on current state)
    always @(*) begin
        case (currentState)
            StateP: theProduct = 1;
            default: theProduct = 0;
        endcase
    end

endmodule
