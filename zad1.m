close all
clear all
[b,Fs]=audioread('noi_b.wav');
f=audioread('noi_f.wav');
w=audioread('noi_w.wav');
fft_b=fft(b);
fft_f=fft(f);
fft_w=fft(w);
% figure
% plot(abs(fft_b(1:(Fs/2))))
% figure
% plot(abs(fft_f(1:(Fs/2))))
% figure
% plot(abs(fft_w(1:(Fs/2))))

f1_k=100;
for i=1:(length(b)-f1_k)
    b1(i)=1/f1_k*(sum(b(i:(i+f1_k))));
    f1(i)=1/f1_k*(sum(f(i:(i+f1_k))));
    w1(i)=1/f1_k*(sum(w(i:(i+f1_k))));
end
fft_b1=fft(b1);
fft_f1=fft(f1);
fft_w1=fft(w1);
audiowrite('b1.wav',b1,Fs)
audiowrite('f1.wav',f1,Fs)
audiowrite('w1.wav',w1,Fs)
% figure
% plot(abs(fft_b1(1:(Fs/2))))
% figure
% plot(abs(fft_f1(1:(Fs/2))))
% figure
% plot(abs(fft_w(1:(Fs/2))))
% hold on
% plot(abs(fft_w1(1:(Fs/2))))

f2_fc=0.2;
f2_M=1000;
for i=0:f2_M
    if i==f2_M/2
        f2_h(i+1)=2*pi*f2_fc;
    else
        f2_h(i+1)=sin(2*pi*f2_fc*(i-f2_M/2))*(0.42-0.5*cos(2*pi*i/f2_M)+0.08*cos(4*pi*i/f2_M))/(i-f2_M/2);
    end
end
f2_K=1/sum(f2_h);
f2_h=f2_h*f2_K;
w2=conv(f2_h,w);
fft_w2=fft(w2);
figure
plot(abs(fft_w(1:(Fs/2))))
hold on
plot(abs(fft_w2(1:(Fs/2))))
audiowrite('w2.wav',w2,Fs)

f3_fc=0.2;
f3_k=exp(-2*pi*f3_fc);
f3_b1=f3_k;
f3_a0=1-f3_k;
w3(1)=f3_a0*w(1);
for i=2:length(w)
    w3(i)=f3_a0*w(i)+f3_b1*w3(i-1);
end
fft_w3=fft(w3);
% figure
% plot(abs(fft_w(1:(Fs/2))))
% hold on
% plot(abs(fft_w3(1:(Fs/2))))
% audiowrite('w3.wav',w3,Fs)