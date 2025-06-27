clc;

% Data from the table (first column is y-values, second column is x-values)
x = [0, 30, 60, 120, 180, 240, 300, 360, 420, 480, 540, 600, 660, 720, 780, 840, 900, 960, 1020];
y = [0.55, 4.75, 6.95, 6.825, 5.6, 12.675, 23.05, 43.775, 84.425, 132.25, 218.3, 347.425, 494.975, 665.75, 849, 1040.075, 1270.5, 1493.075, 1740.825];


% Fit an exponential model
f = fit(x', y',fittype('A*x^3+B*x^2+C*x+D'));

% Display the equation
disp(f);














































