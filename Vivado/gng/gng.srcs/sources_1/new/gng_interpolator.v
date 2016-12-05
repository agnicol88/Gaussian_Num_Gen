`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: gng_interpolator
// Description: This module implements the approximation of the Inverse Cumulative 
//              Distribuiton Function. Includes instantiation of various sub-modules 
//////////////////////////////////////////////////////////////////////////////////


module gng_interpolator(
    input clk,
    input [63:0] data_in,
    output [15:0] data_out
    );
    wire [5:0] lz_pos;
    wire [14:0] mult_in; // ufix(15,15)
    reg [15:0] mult_in_d1 = 16'd0; // sfix(16,15)
    reg [15:0] mult_in_d2 = 16'd0; // sfix(16,15)
    reg [15:0] mult_in_d3 = 16'd0; // sfix(16,15)
    reg [15:0] mult_in_d4 = 16'd0; // sfix(16,15)
    reg [15:0] mult_in_d5 = 16'd0; // sfix(16,15)
    wire [7:0] addr;
    reg [1:0] offset = 2'd0;
    reg [1:0] offset_d1 = 2'd0;
    reg [9:0] sign_pipe = 10'd0;
    wire [17:0] coeff1; // ufix(18,24)
    wire [17:0] coeff2; // ufix(18,20)
    reg [17:0] coeff2_d1 = 18'd0; // ufix(18,20)
    wire [20:0] coeff3; // ufix(21,17)
    reg [21:0] coeff3_d1 = 22'd0; // sfix(22,17)
    reg [21:0] coeff3_d2 = 22'd0; // sfix(22,17)
    reg [21:0] coeff3_d3 = 22'd0; // sfix(22,17)
    reg [21:0] coeff3_d4 = 22'd0; // sfix(22,17)
    wire [38:0] mult_add1_out; // sfix(39,39)
    wire signed [40:0] mult_add2_out; // sfix(41,35)
    reg [15:0] output_reg = 16'd0; // sfix(16,11)
    
    lzd i_lzd ( .data_in(data_in[63:3]), .lz_pos(lz_pos), .clk(clk));
    
    mask_to_zero i_mask ( .clk(clk), .data_in(data_in[17:3]), .lz_pos(lz_pos), .data_out(mult_in));
    
    // Calculate look-up table address
    always @ (posedge clk) begin
        offset <= data_in[2:1];
        offset_d1 <= offset;
    end
    assign addr = {lz_pos, offset_d1};
    
    always @ (posedge clk) begin
        sign_pipe <= {sign_pipe[8:0],data_in[0]};
    end
    
    coeff_store i_coeff_store ( .clk(clk), .addr(addr), .coeff1(coeff1), .coeff2(coeff2),.coeff3(coeff3));
    
    // Delay pipeline for multiplier input
    always @ (posedge clk) begin
        mult_in_d1 <= {1'd0,mult_in};
        mult_in_d2 <= mult_in_d1;
        mult_in_d3 <= mult_in_d2;
        mult_in_d4 <= mult_in_d3;
        mult_in_d5 <= mult_in_d4;
    end
    
    always @ (posedge clk) begin
        coeff2_d1 <= coeff2;
    end
    
    mult_16_19_add_38_out_39 i_mult_add1 ( .clk(clk), .a(mult_in_d2), .b({1'd0,coeff1}), .c({1'd0,coeff2_d1,19'd0}), .out(mult_add1_out));
        
    // Delay pipeline for coeff3
    always @ (posedge clk) begin
        coeff3_d1 <= {1'd0,coeff3};
        coeff3_d2 <= coeff3_d1;
        coeff3_d3 <= coeff3_d2;
        coeff3_d4 <= coeff3_d3;
    end
    
    mult_16_20_add_40_out_41 i_mult_add2 ( .clk(clk), .a(mult_in_d5), .b(mult_add1_out[38:19]), .c({coeff3_d4,18'd0}), .out(mult_add2_out));
    
    always @ (posedge clk) begin
        if (sign_pipe[9])
            output_reg <= ~mult_add2_out[39:24]+1'b1;
        else
            output_reg <= mult_add2_out[39:24];
    end
    
    assign data_out = output_reg;
        
endmodule
