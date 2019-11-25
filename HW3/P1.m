close all; clear all; clc;

% (c)
% k = 1 (mu=0, sig=sqrt(1/12))
figure(1);
x1 = -0.5:0.01:0.5;
fx1 = ones(size(x1));
plot(x1, fx1);
hold on;
x1 = -2:0.01:2;
g1 = normpdf(x1,0,sqrt(1/12));
plot(x1, g1);
figure(2);
x2_1 = -1:0.01:0;
x2_2 = 0.01:0.01:1;
fx2_1 = 1 + x2_1;
fx2_2 = 1 - x2_2; 
plot([x2_1, x2_2], [fx2_1, fx2_2]);
hold on;
x2 = -2:0.01:2;
g2 = normpdf(x2,0,sqrt(2/12));
plot(x2, g2);
figure(3);
x3_1 = -1.5:0.01:-0.5;
x3_2 = -0.49:0.01:0.5;
x3_3 = 0.51:0.01:1.5;
fx3_1 = (2*x3_1 + 3).^2/8;
fx3_2 = -x3_2.^2 + 3/4;
fx3_3 = (2*x3_3 - 3).^2/8;
plot([x3_1, x3_2, x3_3], [fx3_1, fx3_2, fx3_3]);
hold on;
x3 = -2:0.01:2;
g3 = normpdf(x3,0,sqrt(3/12));
plot(x3, g3);
