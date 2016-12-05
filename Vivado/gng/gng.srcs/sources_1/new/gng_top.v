`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: gng_top
// Description: Top-level wrapper file for Gaussian Noise Generator
//////////////////////////////////////////////////////////////////////////////////


module gng_top(
    input clk,
    input rst,
    output [15:0] data_out
    );
    wire [63:0] urn_data;
    (* ASYNC_REG = "TRUE" *) reg rst_sync_d1 = 1'd1;
    (* ASYNC_REG = "TRUE" *) reg rst_sync_d2 = 1'd1;
    
    // Syncronise rst to clk domain    
    always @ (posedge clk) begin
        rst_sync_d1 <= rst;
        rst_sync_d2 <= rst_sync_d1;
    end 
       
    urn_gen i_urn_gen (.clk(clk) , .rst(rst_sync_d2) , .urn(urn_data));
    gng_interpolator i_gng_interpolator (.clk(clk), .data_in(urn_data), .data_out(data_out));
    
endmodule
