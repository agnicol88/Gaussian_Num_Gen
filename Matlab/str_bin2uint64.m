function [ out ] = str_bin2uint64( bin_str )
%Convert a binary string to a uint64 number

out = uint64(0);

for i = 1:64
   if strcmp(int2str(1),bin_str(i))
      out = out + uint64(2^(64-i)); 
   end
end

end

