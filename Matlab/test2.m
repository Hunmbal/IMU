clc;
% Data points
x = [1, 2, 3, 6, 9, 11, 13, 16, 19, 21, 23, 26, 29, 31, 33, 36, 39, 41, 44];
y = [0, 30, 60, 120, 180, 240, 300, 360, 420, 480, 540, 600, 660, 720, 780, 840, 900, 960, 1020];

% Calculate the differences
dy = diff(y);
dx = diff(x);

% Calculate the derivative
derivative = dy ./ dx;

% Midpoints for x values for derivative plot
x_derivative = (x(1:end-1) + x(2:end)) / 2;

% Plotting
figure;
plot(x_derivative, derivative, '-o');
title('Derivative Graph');
xlabel('x');
ylabel('dy/dx');
grid on;
x_derivative
derivative
