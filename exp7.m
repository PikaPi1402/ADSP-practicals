clc;
clear;
close all;

fs = 1000;
t = 0:1/fs:1-1/fs;
N = length(t);

s = sin(2*pi*50*t);

x = randn(1,N);

v = filter([1 0.5],1,x);
v = 0.5 * v / std(v);

d = s + v;

M = 16;
Mu = 0.01;
w = zeros(M,1);

y = zeros(1,N);
e = zeros(1,N);

for n = M:N
    xn = x(n:-1:n-M+1).';
    y(n) = w.' * xn;
    e(n) = d(n) - y(n);
    w = w + Mu * e(n) * xn;
end

MSE = mean(e(M:N).^2);

fprintf('LMS filter order = %d\n', M);
fprintf('Step size = %.3f\n', Mu);
fprintf('Mean Square Error MSE = %.6f\n', MSE);

figure;

subplot(3,1,1)
plot(t,s,'LineWidth',1.2)
grid on
title('Original Signal')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,2)
plot(t,d,'LineWidth',1.2)
grid on
title('Noisy Signal')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,3)
plot(t,e,'LineWidth',1.2)
grid on
title('Noise free Signal')
xlabel('Time (s)')
ylabel('Amplitude')
