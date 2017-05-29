function [ signal_out ] = maximum_filter( signal_in, size )
%MAXFILT Summary of this function goes here
%   Detailed explanation goes here
   signal_length = length(signal_in);
   signal_out = zeros(signal_length - size, 1);
   for i = 1:signal_length - size
      signal_out(i) = max(signal_in(i:i+size));
   end

end

