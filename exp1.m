clear; clc; close all;

Fs = 1000;
N = 1024;
t = (0:N-1)/Fs;

f1 = 100;
f2 = 250;

x = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t) + 0.5*randn(size(t));

[PSD_periodogram, f_periodogram] = periodogram(x, [], N, Fs);

segment_length = 256;

[PSD_barlett, f_barlett] = pwelch(x, rectwin(segment_length), 0, N, Fs);

overlap = 128;

[PSD_welch, f_welch] = pwelch(x, hamming(segment_length), overlap, N, Fs);

figure;

plot(f_periodogram, 10*log10(PSD_periodogram), 'LineWidth', 1.2);
hold on;
plot(f_barlett, 10*log10(PSD_barlett), 'LineWidth', 1.2);
plot(f_welch, 10*log10(PSD_welch), 'LineWidth', 1.2);
grid on;
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Comparison of PSD Estimation Methods');
legend('Periodogram', 'Bartlett', 'Welch');
xlim([0 Fs/2]);

figure;

subplot(3,1,1);
plot(f_periodogram, 10*log10(PSD_periodogram), 'LineWidth', 1.2);
grid on;
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Periodogram');
xlim([0 Fs/2]);

subplot(3,1,2);
plot(f_barlett, 10*log10(PSD_barlett), 'LineWidth', 1.2);
grid on;
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Bartlett');
xlim([0 Fs/2]);

subplot(3,1,3);
plot(f_welch, 10*log10(PSD_welch), 'LineWidth', 1.2);
grid on;
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Welch');
xlim([0 Fs/2]);

sgtitle('Comparison of PSD Estimation Methods');

[~, idx1] = max(PSD_periodogram);
[~, idx2] = max(PSD_barlett);
[~, idx3] = max(PSD_welch);

fprintf('Peak frequency using Periodogram = %2f Hz\n', f_periodogram(idx1));
fprintf('Peak frequency using Bartlett = %2f Hz\n', f_barlett(idx2));
fprintf('Peak frequency using Welch = %2f Hz\n', f_welch(idx3));
