close all; clear all; clc;

%% (c)
[K, M_norm, P_norm, E] = dlqe([1, 1; 0, 1], eye(2), [1, 0], [1/3, 1/2; 1/2, 1], 2);
K
M_norm
P_norm