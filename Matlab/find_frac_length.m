function [ frac_length ] = find_frac_length( input, n_bits )
%Determine the optimal fixed-point fraction length


if min(input) < 0
    signed = 1;
else
    signed = 0;
end

max_val = max(abs(input));

frac_length = n_bits - signed - ceil(log2(max_val));



end

