close all; clear all; clc;

%% (c)
A = [0.5, 0.5*sqrt(3); -0.5*sqrt(3), 0.5];
W = [0.25*(2/3*pi-0.5*sqrt(3)), 3/8; 3/8, 0.25*(2/3*pi+0.5*sqrt(3))];
[K, M_norm, P_norm, E] = dlqe(A, eye(2), [1, 0], W, 0.5);
K
M_norm
P_norm