function [ lz_position ] = lzd( urng_output )
%Detect position of most significant zero in 64-bit input number

found = false;
i = 0;

while(~found)
    i = i+1;
    if urng_output(i) == int2str(0)
        % Found the MS 0
        found = true;
    elseif i == 62
        % No 0 found in valid region of word so need to exit
        found = true;
    end
end

lz_position = uint8(i); % should be 6-bit but use base type to avoid additional toolboxes

end

