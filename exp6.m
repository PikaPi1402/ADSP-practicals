fs = 1000;
t = 0 : 1/fs : 1-1/fs;

x = sin(2*pi*100*t);
P = 10;

[a,PE] = lpc(x,P);

x_predicted = filter([0 -a(2:end)],1,x);

e = x - x_predicted;
MSE = mean(e.^2);

fprintf("Prediction order = %d \n", P);
fprintf("Prediction error = %.6f \n", PE);
fprintf("Mean square error = %.6f \n", MSE);

figure;

subplot(3,1,1);
plot(t,x);
xlabel("Time");
ylabel("Amplitude");
title("Original signal")

subplot(3,1,2);
plot(t,x_predicted);
xlabel("Time");
ylabel("Amplitude");
title("Predicted signal")

subplot(3,1,3);
plot(t,e);
xlim([0, 0.01])
ylim([0, 0.7])
xlabel("Time");
ylabel("Error Signal");
title("Prediction Error");
