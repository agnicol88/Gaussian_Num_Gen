function gen_coeff_verilog( fix_coeffs )
%Generate Verilog code for the coefficient table
file = 'coeff_table.txt';
fid = fopen(file,'wt');

fprintf(fid,'case (addr)\n');
for i = 1:length(fix_coeffs)
    fprintf(fid,'  8''d%i',(i-1));
    fprintf(fid,'  :  val <= 57''b');
    fprintf(fid,dec2bin(fix_coeffs(i,1),18));
    fprintf(fid,'_');
    fprintf(fid,dec2bin(fix_coeffs(i,2),18));
    fprintf(fid,'_');
    fprintf(fid,dec2bin(fix_coeffs(i,3),21));
    fprintf(fid,';\n');
end
fprintf(fid,'  default: val <= 57''d0;\n');
fprintf(fid,'endcase\n');
fclose(fid);
end
