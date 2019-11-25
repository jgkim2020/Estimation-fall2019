close all; clear all; clc;

%% (a)
epsilon = 1e-6;
res = Inf;
x_bar = [0; 0]; M = [0.2^2, 0; 0, 0.3^2];
z = 54.8; V = 0.4^2;
x_hat = x_bar;
P = zeros(2); GR = [0; 0];
while res > epsilon
    x_hat = x_hat - P*GR;
    P = inv(inv(M) + H(x_hat).'*(V\H(x_hat)));
    GR = M\(x_hat - x_bar) - H(x_hat).'*(V\(z - h(x_hat)));
    res = norm(GR);
end
x_hat
P
[eigvec, eigval] = eig(P)

%% (b)
y1_1sig = sqrt(eigval(1,1))*cos(0:0.01:2*pi);
y2_1sig = sqrt(eigval(2,2))*sin(0:0.01:2*pi);
x_1sig = eigvec*[y1_1sig; y2_1sig] + x_hat;
y1_3sig = 3*y1_1sig;
y2_3sig = 3*y2_1sig;
x_3sig = eigvec*[y1_3sig; y2_3sig] + x_hat;
figure(1)
plot(x_hat(1), x_hat(2), '+k'); hold on; grid on;
plot(x_1sig(1,:), x_1sig(2,:), '-'); hold on; grid on;
plot(x_3sig(1,:), x_3sig(2,:), '--'); hold on; grid on;
xlabel('x1 [km]'); ylabel('x2 [km]');

%% functions
function z = h(x)
    z = 180/pi*(atan2(x(2)+4, 3-x(1)) - atan2(x(2), 3-x(1)));
end

function dhdx = H(x)
    dhdx1 = 180/pi*((x(2)+4)/((3-x(1))^2+(x(2)+4)^2) - (x(2))/((3-x(1))^2+x(2)^2));
    dhdx2 = 180/pi*((3-x(1))/((3-x(1))^2+(x(2)+4)^2) - (3-x(1))/((3-x(1))^2+x(2)^2));
    dhdx = [dhdx1, dhdx2];
end