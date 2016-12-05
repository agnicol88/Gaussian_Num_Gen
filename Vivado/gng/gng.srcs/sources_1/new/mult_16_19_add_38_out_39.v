`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mult_16_19_add_38_out_39
// Description: Multiply-add module - uses one DSP48.
//////////////////////////////////////////////////////////////////////////////////


module mult_16_19_add_38_out_39(
    input clk,
    input [15:0] a,
    input [18:0] b,
    input [37:0] c,
    output [38:0] out
    );
    reg signed [15:0] a_reg = 16'd0;
    reg signed [18:0] b_reg = 19'd0;
    reg signed [37:0] c_reg = 38'd0;
    reg signed [34:0] prod = 35'd0;
    wire signed [38:0] sum;
    reg [38:0] result = 35'd0;
    
    always @ (posedge clk) begin
        a_reg <= a;
        b_reg <= b;
        c_reg <= c;
    end
    
    always @ (posedge clk) begin
        prod <= a_reg * b_reg;
    end
    
    assign sum = c_reg + prod;
    
    always @ (posedge clk) begin
        result <= sum;
    end
    
    assign out = result;    
    
endmodule
