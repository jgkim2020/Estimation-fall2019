close all; clear all; clc;

%% (a)
% alpha=0.5
[xbar11, M11, xhat11, P11] = Kalman(0, 0, 100, 0.5, 0.04, 0.04, 100);
[xbar12, M12, xhat12, P12] = Kalman(0, 0, 1, 0.5, 0.04, 0.04, 100);
[xbar13, M13, xhat13, P13] = Kalman(0, 0, 0.01, 0.5, 0.04, 0.04, 100);
% alpha=1.5
[xbar21, M21, xhat21, P21] = Kalman(0, 0, 100, 1.5, 0.04, 0.04, 100);
[xbar22, M22, xhat22, P22] = Kalman(0, 0, 1, 1.5, 0.04, 0.04, 100);
[xbar23, M23, xhat23, P23] = Kalman(0, 0, 0.01, 1.5, 0.04, 0.04, 100);

%% (b)
[xbar31, M31, xhat31, P31] = Kalman(0, 0, 1, 0.5, 0, 0.04, 100);
P31(end)
[xbar32, M32, xhat32, P32] = Kalman(0, 0, 1, 1.5, 0, 0.04, 100);
P32(end)

%% functions
function [xbar, M, xhat, P] = Kalman(x0, xhat0, P0, alpha, W, V, timesteps)
    % x0 = sqrt(P0)*randn(1);
    x = zeros(timesteps,1);
    xbar = zeros(timesteps,1);
    M = zeros(timesteps,1);
    xhat = zeros(timesteps,1);
    P = zeros(timesteps,1);
    % at timestep 1
    x(1) = alpha*x0 + randn(1)*sqrt(W);
    M(1) = alpha^2*P0 + W;
    xbar(1) = alpha*xhat0;
    P(1) = 1/(1/M(1) + 1/V);
    xhat(1) = xbar(1) + P(1)/V*(x(1) + randn(1)*sqrt(V) - xbar(1));
    for i = 2:timesteps
        % system update
        x(i) = alpha*x(i-1) + randn(1)*sqrt(W);
        % time update
        M(i) = alpha^2*P(i-1) + W;
        xbar(i) = alpha*xhat(i-1);
        % measurement update
        P(i) = 1/(1/M(i) + 1/V);
        xhat(i) = xbar(i) + P(i)/V*(x(i) + randn(1)*sqrt(V) - xbar(i));
    end

    figure();
    subplot(211);
    plot(1:timesteps, xhat, 'b', 1:timesteps, xhat+sqrt(P), '-.k', 1:timesteps, xhat-sqrt(P), '-.k');
    grid on;
    title(sprintf('$alpha = %f, X_0 = %f$', alpha, P0), 'interpreter', 'latex');
    h = legend('$\hat x$');
    set(h, 'Interpreter', 'latex', 'fontSize', 12);
    subplot(212);
    plot(1:timesteps, xhat-x, 'b', 1:timesteps, sqrt(P), '-.k', 1:timesteps, -sqrt(P), '-.k');
    grid on;
    h = legend('$\hat x - x$');
    set(h, 'Interpreter', 'latex', 'fontSize', 12);
end