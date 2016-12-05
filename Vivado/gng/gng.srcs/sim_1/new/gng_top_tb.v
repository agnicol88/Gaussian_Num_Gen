`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: gng_top_tb
// Description: Top level testbench. Compares output and intermediate values to
//              expected results stored in text files.
//////////////////////////////////////////////////////////////////////////////////


module gng_top_tb;
    reg clk, rst, test_clk;
    wire [15:0] data_out;
    integer lzd_file, urn_file, mult_in_file, mult1_file, sum1_file, mult2_file, sum2_file, output_file, scan_line;
    reg [5:0] ref_lzd;
    reg [63:0] ref_urn;
    reg [14:0] ref_mult_in;
    reg [34:0] ref_mult1;
    reg [38:0] ref_sum1;
    reg [35:0] ref_mult2;
    reg [40:0] ref_sum2;
    reg [15:0] ref_output;
    reg [15:0] test_en_reg;
    reg test_fail;
        
    initial
    begin            
        lzd_file = $fopen("lzd_ref_results.txt","r");  
        urn_file = $fopen("urn_ref_results.txt","r");   
        mult_in_file = $fopen("mult_input_ref_results.txt","r");
        mult1_file = $fopen("mult1_output_ref_results.txt","r");
        sum1_file = $fopen("sum1_output_ref_results.txt","r");
        mult2_file = $fopen("mult2_output_ref_results.txt","r");
        sum2_file = $fopen("sum2_output_ref_results.txt","r");
        output_file = $fopen("output_ref_results.txt","r");
                  
        rst   = 1'b1;
        clk   = 1'b0;
        test_clk = 1'b0;
        test_en_reg = 13'd0;
        test_fail = 1'b0;
        
        #20 rst   = 1'b0;
        
    end
    
    always
       #10 clk <= ~clk;
    
    always begin
       #1 test_clk <= ~test_clk;
       #9 ;
    end
    
    gng_top i_gng_top (.clk(clk), .rst(rst), .awgn_out(data_out));
    
    always @ (posedge test_clk) begin
        test_en_reg <= {test_en_reg[14:0],1'b1};
    end
        
    always @(posedge test_clk) begin
        if (test_en_reg[3]) begin
            // Check Tausworthe generator output
            scan_line = $fscanf(urn_file, "%b\n", ref_urn);             
            if (!$feof(urn_file)) begin
                if (ref_urn !== i_gng_top.urn_data) begin
                    test_fail <= 1'b1;
                    $warning("***Mismatch in Uniform Random Number Generator data***");
                end
            end
        end
        
        if (test_en_reg[5]) begin
            // Test Leading Zero Detector
            scan_line = $fscanf(lzd_file, "%x\n", ref_lzd);             
            if (!$feof(lzd_file)) begin
                if (ref_lzd !== (i_gng_top.i_gng_interpolator.lz_pos + 6'd1)) begin
                    // Add one to account for 0 vs 1 indexing
                    test_fail <= 1'b1;
                    $warning("***Mismatch in LZD data***");
                end
            end
            
            // Test Mask To Zero
            scan_line = $fscanf(mult_in_file, "%x\n", ref_mult_in);             
            if (!$feof(mult_in_file)) begin
                if (ref_mult_in !== i_gng_top.i_gng_interpolator.mult_in) begin
                    test_fail <= 1'b1;
                    $warning("***Mismatch in Mask To Zero output data***");
                end
            end
        end
                
        if (test_en_reg[9]) begin
            // Test first multiply
            scan_line = $fscanf(mult1_file, "%x\n", ref_mult1);             
            if (!$feof(mult1_file)) begin
                if (ref_mult1 !== i_gng_top.i_gng_interpolator.i_mult_add1.prod) begin
                    test_fail <= 1'b1;
                    $warning("***Mismatch in first multiply***");
                end
            end
        end  
        
        if (test_en_reg[10]) begin
            // Test first add
            scan_line = $fscanf(sum1_file, "%x\n", ref_sum1);             
            if (!$feof(sum1_file)) begin
                if (ref_sum1 !== i_gng_top.i_gng_interpolator.i_mult_add1.result) begin
                    test_fail <= 1'b1;
                    $warning("***Mismatch in first add***");
                end
            end
        end  
        
        if (test_en_reg[12]) begin
            // Test second multiply
            scan_line = $fscanf(mult2_file, "%x\n", ref_mult2);             
            if (!$feof(mult2_file)) begin
                if (ref_mult2 !== i_gng_top.i_gng_interpolator.i_mult_add2.prod) begin
                    test_fail <= 1'b1;
                    $warning("***Mismatch in second multiply***");
                end
            end
        end  
        
        if (test_en_reg[13]) begin
            // Test second add
            scan_line = $fscanf(sum2_file, "%x\n", ref_sum2);             
            if (!$feof(sum2_file)) begin
                if (ref_sum2 !== i_gng_top.i_gng_interpolator.i_mult_add2.result) begin
                    test_fail <= 1'b1;
                    $warning("***Mismatch in second add***");
                end
            end
        end   
        
        if (test_en_reg[14]) begin
            // Test second add
            scan_line = $fscanf(output_file, "%d\n", ref_output);             
            if (!$feof(output_file)) begin
                if (ref_output !== data_out) begin
                    test_fail <= 1'b1;
                    $warning("***Mismatch in output data***");
                end
            end
            else begin
                if (test_fail) begin
                    $display("TEST FAILED : Errors occured during simulation - check transcript");
                    $finish;
                end
                else begin
                    $display("Test Passed! All test-points are bit-accurate to the reference.");
                    $finish;
                end
            end
        end      
    end   
        
endmodule
