function [ mult_input ] = mask_to_zero( urng_output, lz_pos )
%Masks the multiplier input to zero when lz_pos input is > 46 and bit
%reverses the multiplier section of the urng_output

mult_input_r = urng_output(47:61);

if lz_pos > 46
    % Mask unwanted bits
    mult_input_r(1:(lz_pos-46)) = int2str(0);
end

mult_input_b = mult_input_r; %preassign to speed operation
for i = 1:15
    % Perform bit reversal
   mult_input_b(i) = mult_input_r(16-i);
end

mult_input = int32(bin2dec(mult_input_b)); % Should be unsigned 15-bit but using built in type

end

