clear all

[buzz2, fs] = audioread('buzz2.wav');
buzz2filt = windowed_sinc_blackman(buzz2, 0.2, 0.25, 100);

% Thresholding
buzz2filt = thresholding(buzz2filt, 0.0012);
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