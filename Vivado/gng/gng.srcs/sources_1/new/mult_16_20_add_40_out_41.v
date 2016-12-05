`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mult_16_20_add_40_out_41
// Description: Multiply-add module - uses one DSP48.
//////////////////////////////////////////////////////////////////////////////////


module mult_16_20_add_40_out_41(
    input clk,
    input [15:0] a,
    input [19:0] b,
    input [39:0] c,
    output [40:0] out
    );
    reg signed [15:0] a_reg = 16'd0;
    reg signed [19:0] b_reg = 20'd0;
    reg signed [39:0] c_reg = 40'd0;
    reg signed [35:0] prod = 36'd0;
    wire signed [40:0] sum;
    reg [40:0] result = 41'd0;   
    
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
