function [ signal_out ] = moving_average_filter( signal_in, window_size )
%MOVING_AVERAGE_FILTER Summary of this function goes here
%   Detailed explanation goes here
   signal_length = length(signal_in) - window_size;
   signal_out = zeros(signal_length, 1);
   for i = 1:signal_length
      signal_out(i) = sum(signal_in(i:i+window_size))/window_size;
   end

end

