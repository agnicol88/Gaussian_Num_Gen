`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: coeff_store
// Description: Stores coefficients for polynomial approximation of the ICDF
//////////////////////////////////////////////////////////////////////////////////


module coeff_store(
    input clk,
    input [7:0] addr,
    output [17:0] coeff1,
    output [17:0] coeff2,
    output [20:0] coeff3
    );
    reg [56:0] val = 57'd0;
    reg [17:0] coeff1_reg = 18'd0;
    reg [17:0] coeff2_reg = 18'd0;
    reg [20:0] coeff3_reg = 21'd0;
    
    assign coeff1 = coeff1_reg;
    assign coeff2 = coeff2_reg;
    assign coeff3 = coeff3_reg;
    
    always @ (posedge clk) begin
        coeff1_reg <= val[56:39];
        coeff2_reg <= val[38:21];
        coeff3_reg <= val[20:0];
        case (addr)
          8'd0  :  val <= 57'b000011111110100110_101000000000011001_000000000000000000100;
          8'd1  :  val <= 57'b001100101001111111_101000011111010100_000000101000010010000;
          8'd2  :  val <= 57'b010111110111100101_101010000010010001_000001010001100101100;
          8'd3  :  val <= 57'b101000111011111100_101100111100000011_000001111101001001100;
          8'd4  :  val <= 57'b001111011010110010_011001000111110010_000010101100101011001;
          8'd5  :  val <= 57'b010100110110100101_011011000001110101_000011000110110001011;
          8'd6  :  val <= 57'b011101010000010110_011101100110001111_000011100011000111110;
          8'd7  :  val <= 57'b101011011100110101_100001001011010101_000100000010100100111;
          8'd8  :  val <= 57'b001111011001000101_010011011000100110_000100100110011111101;
          8'd9  :  val <= 57'b010100001111101111_010101010010100001_000100111010110110011;
          8'd10  :  val <= 57'b011011110101110100_010111110010010000_000101010001011010111;
          8'd11  :  val <= 57'b101000110010001001_011011001100011010_000101101010111110010;
          8'd12  :  val <= 57'b001110010110010011_010000001110000001_000110001000101111010;
          8'd13  :  val <= 57'b010010110100001001_010001111111101100_000110011001110111010;
          8'd14  :  val <= 57'b011001110100101001_010100010100001001_000110101101000011001;
          8'd15  :  val <= 57'b100101110011000101_010111011110011110_000111000011000000010;
          8'd16  :  val <= 57'b001101010011010010_001110001010110001_000111011100110111010;
          8'd17  :  val <= 57'b010001011100111101_001111110100001000_000111101011110111110;
          8'd18  :  val <= 57'b010111111110100011_010001111101110100_000111111100110010100;
          8'd19  :  val <= 57'b100011001001101010_010100111001101010_001000010000010001110;
          8'd20  :  val <= 57'b001100011000110111_001100101101011110_001000100111011001010;
          8'd21  :  val <= 57'b010000010001101000_001110001111100110_001000110100111000111;
          8'd22  :  val <= 57'b010110011001010001_010000001111111111_001001000100001010011;
          8'd23  :  val <= 57'b100000111001000100_010010111111011001_001001010101110101011;
          8'd24  :  val <= 57'b001011100111001000_001011100111000100_001001101010111001100;
          8'd25  :  val <= 57'b001111010001100011_001101000011000001_001001110111001111100;
          8'd26  :  val <= 57'b010101000011000101_001110111011100000_001010000101010000011;
          8'd27  :  val <= 57'b011110111101111011_010001100000010101_001010010101100001011;
          8'd28  :  val <= 57'b001010111100101100_001010101111101000_001010101000111110110;
          8'd29  :  val <= 57'b001110011010110011_001100000110010101_001010110100011010101;
          8'd30  :  val <= 57'b010011111001010100_001101111000000011_001011000001011011011;
          8'd31  :  val <= 57'b011101010100001111_010000010011110101_001011010000100100010;
          8'd32  :  val <= 57'b001010011000001100_001010000010100110_001011100010101110011;
          8'd33  :  val <= 57'b001101101011100111_001011010100110001_001011101101011011000;
          8'd34  :  val <= 57'b010010111001100100_001101000000101010_001011111001100111001;
          8'd35  :  val <= 57'b011011111000101001_001111010100101000_001100000111110100101;
          8'd36  :  val <= 57'b001001111000011111_001001011101000111_001100011000111001111;
          8'd37  :  val <= 57'b001101000010100001_001010101011010111_001100100010111110111;
          8'd38  :  val <= 57'b010010000001111100_001100010010001100_001100101110011111001;
          8'd39  :  val <= 57'b011010101000100000_001110011111010101_001100111011111010100;
          8'd40  :  val <= 57'b001001011100101010_001000111101010100_001101001100000101011;
          8'd41  :  val <= 57'b001100011110011010_001010001000000111_001101010101101000111;
          8'd42  :  val <= 57'b010001010000111011_001011101010011111_001101100000100011100;
          8'd43  :  val <= 57'b011001100001101101_001101110001101000_001101101101010100010;
          8'd44  :  val <= 57'b001001000100000010_001000100001111010_001101111100101100111;
          8'd45  :  val <= 57'b001011111110011001_001001101001101011_001110000101110011011;
          8'd46  :  val <= 57'b010000100101011001_001011001000000101_001110010000001101101;
          8'd47  :  val <= 57'b011000100010101011_001101001001111000_001110011100011001001;
          8'd48  :  val <= 57'b001000101110000100_001000001010000000_001110101011000110000;
          8'd49  :  val <= 57'b001011100001110001_001001001111000010_001110110011110011010;
          8'd50  :  val <= 57'b001111111110011010_001010101001111010_001110111101110001000;
          8'd51  :  val <= 57'b010111101010001000_001100100110111100_001111001001011011111;
          8'd52  :  val <= 57'b001000011010010100_000111110100111001_001111010111100010011;
          8'd53  :  val <= 57'b001011001000000001_001000110111011110_001111011111111001010;
          8'd54  :  val <= 57'b001111011011010010_001010001111001100_001111101001011101110;
          8'd55  :  val <= 57'b010110110111000011_001100000111111010_001111110100101011110;
          8'd56  :  val <= 57'b001000001000011100_000111100010000110_010000000010001111111;
          8'd57  :  val <= 57'b001010110000101100_001000100010011110_010000001010010010111;
          8'd58  :  val <= 57'b001110111011011010_001001110111010011_010000010011100000111;
          8'd59  :  val <= 57'b010110001000101000_001011101100000111_010000011110010100111;
          8'd60  :  val <= 57'b000111111000001100_000111010001001101_010000101011011010011;
          8'd61  :  val <= 57'b001010011011011100_001000001111100101_010000110011001011011;
          8'd62  :  val <= 57'b001110011110010101_001001100001110010_010000111100000101010;
          8'd63  :  val <= 57'b010101011110001111_001011010011000010_010001000110100001111;
          8'd64  :  val <= 57'b000111101001010100_000111000001111101_010001010011001011101;
          8'd65  :  val <= 57'b001010000111111110_000111111110011110_010001011010101100100;
          8'd66  :  val <= 57'b001110000011101100_001001001110010010_010001100011010100000;
          8'd67  :  val <= 57'b010100110111010101_001010111100010010_010001101101011011011;
          8'd68  :  val <= 57'b000111011011101010_000110110100000100_010001111001101011111;
          8'd69  :  val <= 57'b001001110110000101_000111101110111001_010010000000111110000;
          8'd70  :  val <= 57'b001101101011001010_001000111100100000_010010001001010100111;
          8'd71  :  val <= 57'b010100010011011101_001010100111011111_010010010011001000111;
          8'd72  :  val <= 57'b000111001111000011_000110100111010111_010010011111000010011;
          8'd73  :  val <= 57'b001001100101100011_000111100000101001_010010100110000111000;
          8'd74  :  val <= 57'b001101010100011110_001000101100001101_010010101110001110100;
          8'd75  :  val <= 57'b010011110010010000_001010010100011010_010010110111110000111;
          8'd76  :  val <= 57'b000111000011010111_000110011011101100_010011000011010101001;
          8'd77  :  val <= 57'b001001010110001110_000111010011100001_010011001010001101011;
          8'd78  :  val <= 57'b001100111111011010_001000011101001101_010011010010000110110;
          8'd79  :  val <= 57'b010011010011011010_001010000010110101_010011011011011000110;
          8'd80  :  val <= 57'b000110111000100000_000110010000111011_010011100110101001100;
          8'd81  :  val <= 57'b001001000111111101_000111000111011010_010011101101010110010;
          8'd82  :  val <= 57'b001100101011110100_001000001111010100_010011110101000010101;
          8'd83  :  val <= 57'b010010110110101011_001001110010100011_010011111110000101100;
          8'd84  :  val <= 57'b000110101110010111_000110000110111100_010100001001000100010;
          8'd85  :  val <= 57'b001000111010101010_000110111100001010_010100001111100110011;
          8'd86  :  val <= 57'b001100011001100000_001000000010011100_010100010111000110101;
          8'd87  :  val <= 57'b010010011011110011_001001100011011100_010100011111111011100;
          8'd88  :  val <= 57'b000110100100111001_000101111101101001_010100101010101001011;
          8'd89  :  val <= 57'b001000101110001100_000110110001101101_010100110001000001101;
          8'd90  :  val <= 57'b001100001000010111_000111110110011100_010100111000010110101;
          8'd91  :  val <= 57'b010010000010100111_001001010101010101_010101000000111110011;
          8'd92  :  val <= 57'b000110011100000000_000101110100111110_010101001011011100100;
          8'd93  :  val <= 57'b001000100010100000_000110100111111011_010101010001101011100;
          8'd94  :  val <= 57'b001011111000010000_000111101011001111_010101011000110110001;
          8'd95  :  val <= 57'b010001101010111011_001001001000001010_010101100001010001101;
          8'd96  :  val <= 57'b000110010011101001_000101101100110111_010101101011100001001;
          8'd97  :  val <= 57'b001000010111100000_000110011110110010_010101110001100111100;
          8'd98  :  val <= 57'b001011101001000110_000111100000101111_010101111000101000001;
          8'd99  :  val <= 57'b010001010100101000_001000111011110011_010110000000111000010;
          8'd100  :  val <= 57'b000110001011110000_000101100101010000_010110001010111010000;
          8'd101  :  val <= 57'b001000001101001000_000110010110001100_010110010000111000010;
          8'd102  :  val <= 57'b001011011010110010_000111010110110111_010110010111101111101;
          8'd103  :  val <= 57'b010000111111100100_001000110000001011_010110011111110101000;
          8'd104  :  val <= 57'b000110000100010100_000101011110000101_010110101001101001110;
          8'd105  :  val <= 57'b001000000011010100_000110001110000111_010110101111100000011;
          8'd106  :  val <= 57'b001011001101010000_000111001101100100_010110110110001111001;
          8'd107  :  val <= 57'b010000101011101001_001000100101001111_010110111110001010010;
          8'd108  :  val <= 57'b000101111101010000_000101010111010101_010111000111110010111;
          8'd109  :  val <= 57'b000111111010000010_000110000110011111_010111001101100010010;
          8'd110  :  val <= 57'b001011000000011100_000111000100110011_010111010100001000110;
          8'd111  :  val <= 57'b010000011000110001_001000011010111001_010111011011111010011;
          8'd112  :  val <= 57'b000101110110100101_000101010000111100_010111100101010111011;
          8'd113  :  val <= 57'b000111110001001110_000101111111010001_010111101011000000000;
          8'd114  :  val <= 57'b001010110100010010_000110111100100000_010111110001011110110;
          8'd115  :  val <= 57'b010000000110110101_001000010001000111_010111111001000111010;
          8'd116  :  val <= 57'b000101110000001110_000101001010111010_011000000010011001011;
          8'd117  :  val <= 57'b000111101000110110_000101111000011100_011000000111111011100;
          8'd118  :  val <= 57'b001010101000101101_000110110100101001_011000001110010010111;
          8'd119  :  val <= 57'b001111110101110001_001000000111110101_011000010101110010110;
          8'd120  :  val <= 57'b000101101010001011_000101000101001010_011000011110111010101;
          8'd121  :  val <= 57'b000111100000111000_000101110001111101_011000100100010110101;
          8'd122  :  val <= 57'b001010011101101101_000110101101001011_011000101010100111000;
          8'd123  :  val <= 57'b001111100101100001_000111111111000001_011000110001111110110;
          8'd124  :  val <= 57'b000101100100011011_000100111111101101_011000111010111100101;
          8'd125  :  val <= 57'b000111011001010010_000101101011110010_011001000000010010111;
          8'd126  :  val <= 57'b001010010011001100_000110100110000100_011001000110011100101;
          8'd127  :  val <= 57'b001111010110000001_000111110110101000_011001001101101100101;
          8'd128  :  val <= 57'b000101011110111011_000100111010100001_011001010110100001010;
          8'd129  :  val <= 57'b000111010010000010_000101100101111011_011001011011110001111;
          8'd130  :  val <= 57'b001010001001001010_000110011111010011_011001100001110101011;
          8'd131  :  val <= 57'b001111000111001100_000111101110101001_011001101000111101111;
          8'd132  :  val <= 57'b000101011001101011_000100110101100101_011001110001101001100;
          8'd133  :  val <= 57'b000111001011000110_000101100000010100_011001110110110100111;
          8'd134  :  val <= 57'b001001111111100100_000110011000110110_011001111100110010011;
          8'd135  :  val <= 57'b001110111001000001_000111100111000001_011010000011110011111;
          8'd136  :  val <= 57'b000101010100101001_000100110000110110_011010001100010110111;
          8'd137  :  val <= 57'b000111000100011101_000101011010111110_011010010001011101010;
          8'd138  :  val <= 57'b001001110110011001_000110010010101100_011010010111010100111;
          8'd139  :  val <= 57'b001110101011011100_000111011111101110_011010011110001111101;
          8'd140  :  val <= 57'b000101001111110101_000100101100010101_011010100110101010101;
          8'd141  :  val <= 57'b000110111110000110_000101010101110111_011010101011101100010;
          8'd142  :  val <= 57'b001001101101100101_000110001100110010_011010110001011110011;
          8'd143  :  val <= 57'b001110011110011011_000111011000110000_011010111000010010101;
          8'd144  :  val <= 57'b000101001011001101_000100101000000000_011011000000100101110;
          8'd145  :  val <= 57'b000110110111111111_000101010000111110_011011000101100010110;
          8'd146  :  val <= 57'b001001100101001000_000110000111001001_011011001011001111100;
          8'd147  :  val <= 57'b001110010001111011_000111010010000100_011011010001111101101;
          8'd148  :  val <= 57'b000101000110110001_000100100011110111_011011011010001001011;
          8'd149  :  val <= 57'b000110110010001000_000101001100010001_011011011111000001111;
          8'd150  :  val <= 57'b001001011101000000_000110000001101110_011011100100101001101;
          8'd151  :  val <= 57'b001110000101111010_000111001011101010_011011101011010001110;
          8'd152  :  val <= 57'b000101000010100000_000100011111111000_011011110011010110011;
          8'd153  :  val <= 57'b000110101100011111_000101000111110001_011011111000001010101;
          8'd154  :  val <= 57'b001001010101001100_000101111100100001_011011111101101101100;
          8'd155  :  val <= 57'b001101111010010110_000111000101100000_011100000100010000000;
          8'd156  :  val <= 57'b000100111110011001_000100011100000100_011100001100001101101;
          8'd157  :  val <= 57'b000110100111000011_000101000011011100_011100010000111101110;
          8'd158  :  val <= 57'b001001001101101011_000101110111100001_011100010110011100000;
          8'd159  :  val <= 57'b001101101111001110_000110111111100101_011100011100111001000;
          8'd160  :  val <= 57'b000100111010011100_000100011000011001_011100100100110000000;
          8'd161  :  val <= 57'b000110100001110101_000100111111010001_011100101001011100010;
          8'd162  :  val <= 57'b001001000110011011_000101110010101110_011100101110110110000;
          8'd163  :  val <= 57'b001101100100100000_000110111001111001_011100110101001101110;
          8'd164  :  val <= 57'b000100110110101000_000100010100110110_011100111100111110011;
          8'd165  :  val <= 57'b000110011100110010_000100111011010001_011101000001100110111;
          8'd166  :  val <= 57'b001000111111011100_000101101110000101_011101000110111100010;
          8'd167  :  val <= 57'b001101011010001001_000110110100011010_011101001101001111000;
          8'd168  :  val <= 57'b000100110010111100_000100010001011100_011101010100111001100;
          8'd169  :  val <= 57'b000110010111111011_000100110111011001_011101011001011110010;
          8'd170  :  val <= 57'b001000111000101101_000101101001101000_011101011110101111100;
          8'd171  :  val <= 57'b001101010000001010_000110101111000111_011101100100111101010;
          8'd172  :  val <= 57'b000100101111011001_000100001110001010_011101101100100001111;
          8'd173  :  val <= 57'b000110010011001110_000100110011101011_011101110001000011010;
          8'd174  :  val <= 57'b001000110010001100_000101100101010100_011101110110010000100;
          8'd175  :  val <= 57'b001101000110100000_000110101010000001_011101111100011001100;
          8'd176  :  val <= 57'b000100101011111101_000100001010111111_011110000011111000011;
          8'd177  :  val <= 57'b000110001110101011_000100110000000101_011110001000010110011;
          8'd178  :  val <= 57'b001000101011111000_000101100001001010_011110001101011111101;
          8'd179  :  val <= 57'b001100111101001011_000110100101000101_011110010011100100001;
          8'd180  :  val <= 57'b000100101000101001_000100000111111011_011110011010111101100;
          8'd181  :  val <= 57'b000110001010010010_000100101100100110_011110011111011000001;
          8'd182  :  val <= 57'b001000100101110010_000101011101001001_011110100100011101110;
          8'd183  :  val <= 57'b001100110100001000_000110100000010101_011110101010011101111;
          8'd184  :  val <= 57'b000100100101011011_000100000100111101_011110110001110001111;
          8'd185  :  val <= 57'b000110000110000010_000100101001001111_011110110110001001011;
          8'd186  :  val <= 57'b001000011111111001_000101011001010001_011110111011001011011;
          8'd187  :  val <= 57'b001100101011011001_000110011011101110_011111000001000111001;
          8'd188  :  val <= 57'b000100100010010100_000100000010000110_011111001000010110000;
          8'd189  :  val <= 57'b000110000001111010_000100100101111111_011111001100101010100;
          8'd190  :  val <= 57'b001000011010001011_000101010101100000_011111010001101000111;
          8'd191  :  val <= 57'b001100100010111010_000110010111010001_011111010111100000101;
          8'd192  :  val <= 57'b000100011111010011_000011111111010100_011111011110101010100;
          8'd193  :  val <= 57'b000101111101111011_000100100010110110_011111100010111100000;
          8'd194  :  val <= 57'b001000010100101000_000101010001110111_011111100111110111000;
          8'd195  :  val <= 57'b001100011010101100_000110010010111101_011111101101101010110;
          8'd196  :  val <= 57'b000100011100010111_000011111100101000_011111110100101111110;
          8'd197  :  val <= 57'b000101111010000011_000100011111110011_011111111000111110011;
          8'd198  :  val <= 57'b001000001111010000_000101001110010110_011111111101110110001;
          8'd199  :  val <= 57'b001100010010101110_000110001110110001_100000000011100110000;
          8'd200  :  val <= 57'b000100011001100010_000011111010000001_100000001010100110011;
          8'd201  :  val <= 57'b000101110110010010_000100011100110110_100000001110110010001;
          8'd202  :  val <= 57'b001000001010000010_000101001010111011_100000010011100110110;
          8'd203  :  val <= 57'b001100001010111110_000110001010101101_100000011001010010111;
          8'd204  :  val <= 57'b000100010110110001_000011110111100000_100000100000001110101;
          8'd205  :  val <= 57'b000101110010101001_000100011001111110_100000100100010111110;
          8'd206  :  val <= 57'b001000000100111110_000101000111100111_100000101001001001010;
          8'd207  :  val <= 57'b001100000011011101_000110000110110001_100000101110110001101;
          8'd208  :  val <= 57'b000100010100000110_000011110101000011_100000110101101001001;
          8'd209  :  val <= 57'b000101101111000110_000100010111001100_100000111001101111101;
          8'd210  :  val <= 57'b001000000000000011_000101000100011001_100000111110011110000;
          8'd211  :  val <= 57'b001011111100001010_000110000010111101_100001000100000011000;
          8'd212  :  val <= 57'b000100010001011111_000011110010101010_100001001010110110001;
          8'd213  :  val <= 57'b000101101011101001_000100010100011111_100001001110111010001;
          8'd214  :  val <= 57'b000111111011010001_000101000001010000_100001010011100101101;
          8'd215  :  val <= 57'b001011110101000011_000101111111001111_100001011001000111001;
          8'd216  :  val <= 57'b000100001110111110_000011110000010110_100001011111110110000;
          8'd217  :  val <= 57'b000101101000010010_000100010001110111_100001100011110111100;
          8'd218  :  val <= 57'b000111110110100111_000100111110001110_100001101000100000010;
          8'd219  :  val <= 57'b001011101110001000_000101111011101000_100001101101111110011;
          8'd220  :  val <= 57'b000100001100100000_000011101110000110_100001110100101001010;
          8'd221  :  val <= 57'b000101100101000010_000100001111010011_100001111000101000011;
          8'd222  :  val <= 57'b000111110010000101_000100111011010001_100001111101001110010;
          8'd223  :  val <= 57'b001011100111011010_000101111000001000_100010000010101001010;
          8'd224  :  val <= 57'b000100001010000110_000011101011111010_100010001001010000010;
          8'd225  :  val <= 57'b000101100001110110_000100001100110100_100010001101001101000;
          8'd226  :  val <= 57'b000111101101101010_000100111000011001_100010010001110000001;
          8'd227  :  val <= 57'b001011100000110111_000101110100101101_100010010111001000000;
          8'd228  :  val <= 57'b000100000111110001_000011101001110010_100010011101101011001;
          8'd229  :  val <= 57'b000101011110110000_000100001010011010_100010100001100101101;
          8'd230  :  val <= 57'b000111101001010111_000100110101100110_100010100110000110010;
          8'd231  :  val <= 57'b001011011010011110_000101110001011000_100010101011011010111;
          8'd232  :  val <= 57'b000100000101011111_000011100111101110_100010110001111010011;
          8'd233  :  val <= 57'b000101011011110000_000100001000000011_100010110101110010101;
          8'd234  :  val <= 57'b000111100101001011_000100110010110111_100010111010010000101;
          8'd235  :  val <= 57'b001011010100010000_000101101110001001_100010111111100010011;
          8'd236  :  val <= 57'b000100000011010010_000011100101101100_100011000101111110001;
          8'd237  :  val <= 57'b000101011000110011_000100000101110000_100011001001110100010;
          8'd238  :  val <= 57'b000111100001000110_000100110000001101_100011001110001111111;
          8'd239  :  val <= 57'b001011001110001100_000101101010111111_100011010011011110101;
          8'd240  :  val <= 57'b000100000001000111_000011100011101110_100011011001110110111;
          8'd241  :  val <= 57'b000101010101111100_000100000011100001_100011011101101010111;
          8'd242  :  val <= 57'b000111011101000111_000100101101101000_100011100010000100000;
          8'd243  :  val <= 57'b001011001000010001_000101100111111010_100011100111010000000;
          8'd244  :  val <= 57'b000011111111000000_000011100001110100_100011101101100100111;
          8'd245  :  val <= 57'b000101010011001001_000100000001010110_100011110001010110110;
          8'd246  :  val <= 57'b000111011001001110_000100101011000110_100011110101101101101;
          8'd247  :  val <= 57'b001011000010011111_000101100100111010_100011111010110110110;
          default: val <= 57'd0;
    
        endcase
    end
endmodule