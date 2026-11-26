close; clc; clear all;

fs=1000;
N=1000;
t=(0:N-1)/fs;
f1=50;
f2=120;

d=sin(2*pi*f1*t)+0.5*sin(2*pi*f2*t);

rng(1);
noise=0.5*randn(1,N);
x=d+noise;

figure;
subplot(3,1,1);
plot(t,d);
title("Original Signal");
xlabel("time");
ylabel("amplitude");

subplot(3,1,2);
plot(t,x);
title("Noisy added Discrete Time Signal");
xlabel("time");
ylabel("amplitude");

M=20;
L=M+1;

rxx_full=xcorr(x,M,'biased');
rxx=rxx_full(M+1:end);
rxx=rxx(:);

rxd_full=xcorr(x,d,M,'biased');
rxd=rxd_full(M+1:end);
rxd=rxd(:);

R=toeplitz(rxx);

h=R\rxd;
disp('FIR Wiener filter coefficient');
disp(h);

y=filter(h,1,x);

MSE_before=mean((d-x).^2);
MSE_after=mean((d-y).^2);

fprintf('MSE before Wiener filter = %.4f \n',MSE_before);
fprintf('MSE after Wiener filter = %.4f \n',MSE_after);

subplot(3,1,3);
plot(t,y);
title('After Wiener filter');
xlabel("time");
ylabel("amplitude");

figure;
plot(t,d,'LineWidth',1.5);
hold on;
grid on;
plot(t,y,'LineWidth',1.5);
title('Comparison');
xlabel("time");
ylabel("amplitude");
legend('Original','Wiener filter');
