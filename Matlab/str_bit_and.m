function [ out_bin_str ] = str_bit_and( bin_str1, bin_str2 )
%Performs a bit-wise AND on binary strings
n_bits = max(length(bin_str1),length(bin_str2));
out_bin_str = dec2bin(0,n_bits);

for i = 1:n_bits
    b1 = strcmp(int2str(1),bin_str1(i));
    b2 = strcmp(int2str(1),bin_str2(i));
    out_bin_str(i) = int2str(and(b1,b2));
end

end

