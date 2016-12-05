`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mask_to_zero
// Description: Selects active region from input data, bit reverses and masks LS 
//              bits to zero depending on the position of the leading zero identified 
//              by lzd.v
//////////////////////////////////////////////////////////////////////////////////


module mask_to_zero(
    input clk,
    input [14:0] data_in,
    input [5:0] lz_pos,
    output [14:0] data_out
    );
    wire [14:0] data_in_rev;
    reg [14:0] data_in_r = 15'd0;
    reg [14:0] data = 15'd0;
    
    assign data_in_rev = {data_in[0], data_in[1], data_in[2], data_in[3], data_in[4],
                  data_in[5], data_in[6], data_in[7], data_in[8], data_in[9],
                  data_in[10], data_in[11], data_in[12], data_in[13], data_in[14]};
                  
    always @ (posedge clk) begin
        data_in_r <= data_in_rev;
        case (lz_pos)
            6'd61:   data <= data_in_r & 15'b111111111111111;
            6'd60:   data <= data_in_r & 15'b011111111111111;
            6'd59:   data <= data_in_r & 15'b101111111111111;
            6'd58:   data <= data_in_r & 15'b110111111111111;
            6'd57:   data <= data_in_r & 15'b111011111111111;
            6'd56:   data <= data_in_r & 15'b111101111111111;
            6'd55:   data <= data_in_r & 15'b111110111111111;
            6'd54:   data <= data_in_r & 15'b111111011111111;
            6'd53:   data <= data_in_r & 15'b111111101111111;
            6'd52:   data <= data_in_r & 15'b111111110111111;
            6'd51:   data <= data_in_r & 15'b111111111011111;
            6'd50:   data <= data_in_r & 15'b111111111101111;
            6'd49:   data <= data_in_r & 15'b111111111110111;
            6'd48:   data <= data_in_r & 15'b111111111111011;
            6'd47:   data <= data_in_r & 15'b111111111111101;
            6'd46:   data <= data_in_r & 15'b111111111111110;
            default: data <= data_in_r & 15'b111111111111111;
        endcase
    end
    
    assign data_out = data;
endmodule
