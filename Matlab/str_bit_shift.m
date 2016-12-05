function [ out_bin_str ] = str_bit_shift( bin_str, n_shift )
%Performs a bit shift on a binary string
n_bits = length(bin_str);
out_bin_str = dec2bin(0,n_bits);

if n_shift > 0
    % Left shift
    n_shift = n_shift + 1;
    for i = (n_shift+1):n_bits
        out_bin_str(n_bits-i+1) = bin_str(n_bits-i+n_shift);
    end
elseif n_shift < 0
    % Right shift
    n_shift = n_shift * -1;
    for i = n_bits:-1:(n_shift+1)
        out_bin_str(i) = bin_str(i-n_shift);
    end
else
    % Why did this get called??
    out_bin_str = bin_str;
end

end

