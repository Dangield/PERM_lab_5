function [ signal_out ] = thresholding( signal_in, threshold )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   signal_length = length(signal_in);
   signal_out = zeros(size(signal_in));
   for i = 1:signal_length
      if abs(signal_in(i)) >= threshold
         signal_out(i) = threshold;
      else
         signal_out(i) = 0;
      end
   end

end

