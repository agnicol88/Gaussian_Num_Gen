`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lzd
// Description: Identifies the leading zero in a 64-bit input number
//////////////////////////////////////////////////////////////////////////////////


module lzd(
    input [60:0] data_in,
    output [5:0] lz_pos,
    input clk
    );
    reg [5:0] lz_pos_r = 6'd0;
    reg [5:0] lz_pos_w = 6'd0;
    reg [5:0] lz_pos_reg = 6'd0;
        
    integer i;
    
    assign lz_pos = lz_pos_reg;
    
    always @ (data_in) begin
        lz_pos_w = 6'd61;
        for (i = 0; i < 61; i=i+1) begin
            lz_pos_w = (!data_in[i]) ? (6'd60-i) : lz_pos_w;
        end
    end
    
    always @ (posedge clk) begin
        lz_pos_r <= lz_pos_w;
        lz_pos_reg <= lz_pos_r;
    end
    
endmodule
