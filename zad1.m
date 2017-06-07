close all
clear all
[b,Fs]=audioread('noi_b.wav');
f=audioread('noi_f.wav');
w=audioread('noi_w.wav');
ori=audioread('ori.wav');
fft_b=fft(b);
fft_f=fft(f);
fft_w=fft(w);
% figure
% plot(abs(fft_b(1:(length(fft_b)/2))))
% figure
% plot(abs(fft_f(1:(length(fft_f)/2))))
% figure
% plot(abs(fft_w(1:(length(fft_w)/2))))

f1_k=10;
for i=1:(length(b)-f1_k)
    b1(i)=1/f1_k*(sum(b(i:(i+f1_k))));
    f1(i)=1/f1_k*(sum(f(i:(i+f1_k))));
    w1(i)=1/f1_k*(sum(w(i:(i+f1_k))));
end
fft_b1=fft(b1);
fft_f1=fft(f1);
fft_w1=fft(w1);
% figure
% plot(abs(fft_b(1:(length(fft_b)/2))),'b')
% hold on
% plot(abs(fft_b1(1:(length(fft_b1)/2))),'r')
% figure
% plot(abs(fft_f(1:(length(fft_f)/2))),'b')
% hold on
% plot(abs(fft_f1(1:(length(fft_f1)/2))),'r')
% figure
% plot(abs(fft_w(1:(length(fft_w)/2))),'b')
% hold on
% plot(abs(fft_w1(1:(length(fft_w1)/2))),'r')
audiowrite('b1.wav',b1,Fs)
audiowrite('f1.wav',f1,Fs)
audiowrite('w1.wav',w1,Fs)

f2_fc=0.1;
f2_M=100;
for i=0:f2_M
    if i==f2_M/2
        f2_h(i+1)=2*pi*f2_fc;
    else
        f2_h(i+1)=sin(2*pi*f2_fc*(i-f2_M/2))*(0.42-0.5*cos(2*pi*i/f2_M)+0.08*cos(4*pi*i/f2_M))/(i-f2_M/2);
    end
end
f2_K=1/sum(f2_h);
f2_h=f2_h*f2_K;
b2=conv(f2_h,b);
f2=conv(f2_h,f);
w2=conv(f2_h,w);
fft_b2=fft(b2);
fft_f2=fft(f2);
fft_w2=fft(w2);
% figure
% plot(abs(fft_b(1:(length(fft_b)/2))),'b')
% hold on
% plot(abs(fft_b2(1:(length(fft_b2)/2))),'r')
% figure
% plot(abs(fft_f(1:(length(fft_f)/2))),'b')
% hold on
% plot(abs(fft_f2(1:(length(fft_f2)/2))),'r')
% figure
% plot(abs(fft_w(1:(length(fft_w)/2))),'b')
% hold on
% plot(abs(fft_w2(1:(length(fft_w2)/2))),'r')
audiowrite('b2.wav',b2,Fs)
audiowrite('f2.wav',f2,Fs)
audiowrite('w2.wav',w2,Fs)

f3_fc=0.1;
f3_k=exp(-2*pi*f3_fc);
f3_b1=f3_k;
f3_a0=1-f3_k;
b3(1)=f3_a0*b(1);
f3(1)=f3_a0*f(1);
w3(1)=f3_a0*w(1);
for i=2:length(w)
    b3(i)=f3_a0*w(i)+f3_b1*b3(i-1);
    f3(i)=f3_a0*w(i)+f3_b1*f3(i-1);
    w3(i)=f3_a0*w(i)+f3_b1*w3(i-1);
end
fft_b3=fft(b3);
fft_f3=fft(f3);
fft_w3=fft(w3);
% figure
% plot(abs(fft_b(1:(length(fft_b)/2))),'b')
% hold on
% plot(abs(fft_b3(1:(length(fft_b3)/2))),'r')
% figure
% plot(abs(fft_f(1:(length(fft_f)/2))),'b')
% hold on
% plot(abs(fft_f3(1:(length(fft_f3)/2))),'r')
% figure
% plot(abs(fft_w(1:(length(fft_w)/2))),'b')
% hold on
% plot(abs(fft_w3(1:(length(fft_w3)/2))),'r')
audiowrite('b3.wav',b3,Fs)
audiowrite('f3.wav',f3,Fs)
audiowrite('w3.wav',w3,Fs)


peaksnr(1,1)=psnr(b(1:length(ori)),ori);
peaksnr(1,2)=psnr(b1(1:length(ori))',ori);
peaksnr(1,3)=psnr(b2(1:length(ori)),ori);
peaksnr(1,4)=psnr(b3(1:length(ori))',ori);
peaksnr(2,1)=psnr(f(1:length(ori)),ori);
peaksnr(2,2)=psnr(f1(1:length(ori))',ori);
peaksnr(2,3)=psnr(f2(1:length(ori)),ori);
peaksnr(2,4)=psnr(f3(1:length(ori))',ori);
peaksnr(3,1)=psnr(w(1:length(ori)),ori);
peaksnr(3,2)=psnr(w1(1:length(ori))',ori);
peaksnr(3,3)=psnr(w2(1:length(ori)),ori);
peaksnr(3,4)=psnr(w3(1:length(ori))',ori);
peaksnr
[x1,x2,D]=alignsignals(b,ori);