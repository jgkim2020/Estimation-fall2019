close all; clear all; clc;

% (a)
% 1)
help randn;
% 2)
x = 2*randn([10000, 1]) + 5;
figure(1);
plot(x);
% 3), 4)
fprintf('mean: %f, stddev: %f \r\n', mean(x), std(x));
figure(2);
histfit(x, 25);
% (b)
v1 = 2*randn([1000,1]);
v2 = 3*randn([1000,1]);
% (c)
z1 = 4 + v1;  
z2 = 4 + v2;
figure(3);
plot(1:1:1000, z1);
hold on;
plot(1:1:1000, z2);
% (d) batch & sequential (constant x)
batch_sig = sqrt(1/(1/3^2*length(z2)));
batch_x = batch_sig^2/3^2*ones(size(z2)).'*z2;
fprintf('batch - mu: %f, stddev: %f \r\n', batch_x, batch_sig);
seq_xs = zeros([1,length(z2)]);
seq_sigs = zeros([1,length(z2)]);
seq_sig_sq = 3^2; 
seq_x = z2(1);
seq_sigs(1) = sqrt(seq_sig_sq);
seq_xs(1) = seq_x;
for t=2:1:length(z2)
    seq_sig_sq_ = 1/(1/seq_sig_sq + 1/3^2);
    seq_x_ = seq_sig_sq_/seq_sig_sq*seq_x + seq_sig_sq_/3^2*z2(t);
    seq_sig_sq = seq_sig_sq_;
    seq_x = seq_x_;
    seq_sigs(t) = sqrt(seq_sig_sq);
    seq_xs(t) = seq_x;
end
figure(4);
plot(1:length(z2),seq_xs);
figure(5);
plot(1:length(z2),seq_sigs);
fprintf('sequential - mu: %f, stddev: %f \r\n', seq_x, sqrt(seq_sig_sq));
% (e)
x = sin(2*pi/500*(1:1:1000)).';
z1 = x + v1;  
z2 = x + v2;
figure(6);
plot(1:1:1000, z1);
hold on;
plot(1:1:1000, z2);
% (f) batch & sequential (sinusoidal x)
batch_sig = sqrt(1/(1/3^2*length(z2)));
batch_x = batch_sig^2/3^2*ones(size(z2)).'*z2;
fprintf('batch - mu: %f, stddev: %f \r\n', batch_x, batch_sig);
seq_xs = zeros([1,length(z2)]);
seq_sigs = zeros([1,length(z2)]);
seq_sig_sq = 3^2; 
seq_x = z2(1);
seq_sigs(1) = sqrt(seq_sig_sq);
seq_xs(1) = seq_x;
for t=2:1:length(z2)
    seq_sig_sq_ = 1/(1/seq_sig_sq + 1/3^2);
    seq_x_ = seq_sig_sq_/seq_sig_sq*seq_x + seq_sig_sq_/3^2*z2(t);
    seq_sig_sq = seq_sig_sq_;
    seq_x = seq_x_;
    seq_sigs(t) = sqrt(seq_sig_sq);
    seq_xs(t) = seq_x;
end
figure(7);
plot(1:length(z2),seq_xs);
figure(8);
plot(1:length(z2),seq_sigs);
fprintf('sequential - mu: %f, stddev: %f \r\n', seq_x, sqrt(seq_sig_sq));
fprintf('sequential - mu: %f, stddev: %f \r\n', seq_x, sqrt(seq_sig_sq));
% (g) moving average (sinusoidal x)
mov_sig = 3/sqrt(length(z2));
Ns = [4, 9, 25, 100, 400];
mov_x = zeros(length(z2), length(Ns));
for n=1:length(Ns)
    mov_x(1,n) = z2(1);
    for t=2:length(z2)
        mov_x(t,n) = (Ns(n)-1)/Ns(n)*mov_x(t,n) + z2(t)/Ns(n);
    end
end
figure(9);
for n=1:length(Ns)
    plot(1:1:1000, mov_x(:,n));
    hold on;
end
