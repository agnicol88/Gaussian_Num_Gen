function [ y, new_s1, new_s2, new_s3 ] = urng( s1,s2,s3 )
% Update and return intermediate registers and Tausworthe output.
% Note that this implementation works with 64-character strings instead of
% uint64 numbers due to numerical inaccuracies in the LS bits.

b = str_bit_shift( str_bit_xor( str_bit_shift( s1,13) , s1), -19);
new_s1 = str_bit_xor( str_bit_shift( str_bit_and( s1 , '1111111111111111111111111111111111111111111111111111111111111110') , 12) , b);
b = str_bit_shift( str_bit_xor (str_bit_shift( s2 , 2) , s2) , -25);
new_s2 = str_bit_xor( str_bit_shift( str_bit_and(s2 , '1111111111111111111111111111111111111111111111111111111111111000') , 4) , b);
b = str_bit_shift( str_bit_xor( str_bit_shift( s3 , 3) , s3) , -11);
new_s3 = str_bit_xor( str_bit_shift( str_bit_and( s3 , '1111111111111111111111111111111111111111111111111111111111110000') , 17) , b);

y = (str_bit_xor( str_bit_xor(new_s1 , new_s2) , new_s3)) ;
        
end

