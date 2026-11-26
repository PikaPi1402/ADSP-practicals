clc;

fs=1000;
N=1024;
t=(0:N-1)/fs;

f1=100;
f2=250;

x=sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t) + 0.5*(randn(size(t)));

figure;
plot(t,x);
grid on
xlabel("Time(s)")
ylabel("Amplitude")
title("Time Domain Signal")

[PSD_Periodogram,f_periodogram]=periodogram(x,[],N,fs);

overlap = 128;
segment_length = 256;

[PSD_welch,f_welch]=pwelch(x,hamming(segment_length),overlap,N,fs);

AR_order = 20;

[a,noise_variance] = aryule(x,AR_order);

[Pxx_AR,f_AR] = freqz(sqrt(noise_variance),a,N,fs);

Pxx_AR = abs(Pxx_AR).^2;

figure;
plot(f_periodogram,10*log10(PSD_Periodogram),'LineWidth',1.2)
hold on;
plot(f_welch,10*log10(PSD_welch),'LineWidth',1.2)
hold on;
plot(f_AR,10*log10(Pxx_AR),'LineWidth',1.2)
grid on;
xlabel('Frequency')
ylabel('Amplitude')
title('Comparison of PSD Estimates')
legend('Periodogram','Welch','AR-Model Yule-Walker')

xlim([0,fs/2])

[~,idx1] = max(PSD_Periodogram);
[~,idx2] = max(PSD_welch);
[~,idx3] = max(Pxx_AR);

fprintf('\n Peak Frequency Results: \n')

fprintf('\n Peak frequency using periodogram = %.2fHz\n',f_periodogram(idx1))
fprintf('\n Peak frequency using welch = %.2fHz\n',f_welch(idx2))
fprintf('\n Peak frequency using AR Yule-Walker = %.2fHz\n',f_AR(idx3))

fprintf('\n AR Model Order: %d \n',AR_order);
fprintf('\n Estimated Noise Variance: %0.4f \n',noise_variance);
fprintf('\n AR Model coefficients: \n');
disp(a);
