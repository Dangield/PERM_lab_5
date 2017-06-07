function [ signal_out ] = windowed_sinc_blackman( signal_in, fc2, fc1, M )
%WINDOWED_SINC_BLACKMAN Summary of this function goes here
%   Detailed explanation goes herebuzz2edit
   signal_length = length(signal_in);
   h1 = zeros(M, 1);
   for i=0:M
      if i==M/2
         h1(i+1)=2*pi*fc1;
      else
         h1(i+1)=sin(2*pi*fc1*(i-M/2))*(0.42-0.5*cos(2*pi*i/M) ...
            +0.08*cos(4*pi*i/M))/(i-M/2);
      end
   end
   K = sum(h1);
   h1 = h1 ./ K;
   
   fc2 = 0.5 - fc2;
   h2 = zeros(M, 1);
   for i=0:M
      if i==M/2
         h2(i+1)=2*pi*fc2;
      else
         h2(i+1)=sin(2*pi*fc2*(i-M/2))*(0.42-0.5*cos(2*pi*i/M) ...
            +0.08*cos(4*pi*i/M))/(i-M/2);
      end
   end
   K = sum(h2);
   h2 = h2 ./ K;
   h2(2:2:end) = -h2(2:2:end);
   
   h = conv(h1, h2);
   signal_out = conv(h, signal_in);
%    figure
%    in = abs(fft(signal_in));
%    out = abs(fft(signal_out));
%    plot(in(1:signal_length/2));
%    hold on
%    plot(out(1:signal_length/2),'r');
end

