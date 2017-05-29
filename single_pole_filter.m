function [ signal_out ] = single_pole_filter( signal_in, fc )
%SINGLE_POLE_FILTER Summary of this function goes here
%   Detailed explanation goes here
   signal_length = length(signal_in);
   signal_out = zeros(size(signal_in));
   k = exp(-2*pi*fc);
   a0 = 1 - k;
   b1 = k;
   signal_out(1) = a0 * signal_in(1);
   for i = 2:signal_length
      signal_out(i) = a0 * signal_in(i) + b1 * signal_out(i - 1);
   end
   
%    in = abs(fft(signal_in));
%    out = abs(fft(signal_out));
%    plot(in(1:signal_length/2));
%    hold on
%    plot(out(1:signal_length/2));
end

