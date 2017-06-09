clear all
close all

[buzz2, fs] = audioread('buzz2.wav');
fft_buzz2=fft(buzz2);
% figure
% plot(abs(fft_buzz2))
% hold on

buzz2extracted=buzz2;
for i=1:length(buzz2)
    if i/fs<3 || (1/fs>4 && 1/fs<7) || i/fs>8
        buzz2extracted(i)=0;
    else
        buzz2extracted(i)=buzz2(i);
    end
end
fft_buzz2e=fft(buzz2extracted);
comparison=abs(fft_buzz2(1:length(buzz2)/2))-abs(fft_buzz2e(1:length(buzz2)/2));
% figure
% plot(comparison)

buzz2filt = windowed_sinc_blackman(buzz2, 0.25, 0.5, 100);
figure
plot(abs(buzz2filt))
% plot(abs(fft(buzz2filt)))

% Thresholding
buzz2filt = thresholding(buzz2filt, 0.0023);
figure
plot(buzz2filt);


buzz2edit = medfilt2(buzz2filt, [7, 1]);
buzz2edit = maximum_filter(buzz2edit, 4600);
buzz2edit = buzz2edit ./ max(buzz2edit);
buzz2cut = buzz2edit .* buzz2(1:length(buzz2edit));
% sound(buzz2cut, fs);

[~, pks] = findpeaks(gradient(buzz2edit));
for i = 1:length(pks)
   fprintf('Buzzer number %d starts at %f[s]\n', i, pks(i)/fs);
end