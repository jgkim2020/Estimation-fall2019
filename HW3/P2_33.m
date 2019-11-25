close all; clear all; clc;

%% (a)
rng(0);
x = zeros(1,1024);
x(1) = randn(1);
for i = 2:1024
    x(i) = exp(-0.05)*x(i-1) + sqrt(1 - exp(-2*0.05))*randn(1);
end
figure(1);
plot(0:0.05:51.15, x);

%% (b)
lags = 0:0.05:3.0;
V_x = zeros(size(lags));
R_x = zeros(size(lags));
for i = 1:length(lags)
    V_x(i) = V(x, lags(i), 0.05);
    R_x(i) = exp(-abs(lags(i)));
end
figure(2);
plot(lags, R_x);
hold on;
plot(lags, V_x);

%% (c)
xs = zeros(8,1024);
for i = 1:8
    rng(i);
    xs(i,1) = randn(1);
    for t = 2:1024
        xs(i,t) = exp(-0.05)*xs(i,t-1) + sqrt(1 - exp(-2*0.05))*randn(1);
    end
end
V_xs = zeros(8,length(lags));
for i = 1:8
    for t = 1:length(lags)
        V_xs(i,t) = V(xs(i,:), lags(t), 0.05);
    end
end
figure(3);
plot(lags, R_x);
hold on;
plot(lags, V_xs(1,:));
plot(lags, mean(V_xs(1:2,:)));
plot(lags, mean(V_xs(1:4,:)));
plot(lags, mean(V_xs));

%% functions
function v = V(seq, tau, dt)
    v = 0;
    T = 0;
    for i = 1:length(seq)-floor(tau/dt)
        v = v + seq(i)*seq(i + floor(tau/dt))*dt;
        T = T + dt;
    end
    v = v/T;
end