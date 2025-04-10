clear; clc; close all;

% 1 < alpha * (t_e - t_0) < 10

% Ranges to test
% alpha * (t_e - t_0) = 1.5
% alpha * (t_e - t_0) = 3
% alpha * (t_e - t_0) = 5
% alpha * (t_e - t_0) = 7
% alpha * (t_e - t_0) = 9

% Proportionality constant
% - larvae decay due to cannabilism
% alpha = 1.5;
alpha = 7;
t_0 = 0.0;
t_e = 1.0;


% 3 < beta * gamma < 20

% Ranges to test
% beta * gamma = 4
% beta * gamma = 6
% beta * gamma = 8
% beta * gamma = 10
% beta * gamma = 12
% beta * gamma = 14
% beta * gamma = 16
% beta * gamma = 18

% Proportionality constant for y(n)
% - reproduction rate
beta = 2.0;
% beta = 18.0;

% Proportionality constant 
% - survival ratio of mature larvae
gamma = 1;
gamma1 = 1.5;
gamma2 = 0.5;

% Fixed point calculation
% x_star = log(B) /  A * (t_e - t_0)

% Simulation over N cycles

% Initial salmon population of 1 hundred million
x_0 = 0.01;


% N - number of cycles
N = 30;

% Result array - initially all 0
% Low A, Low B
x = zeros(N, 1);
% High A, Low B
x1 = zeros(N, 1);
% Low A, High B
x2 = zeros(N, 1);
% High A, High B
x3 = zeros(N, 1);

% Init initial result for 1st cycle
x(1) = x_0;
x1(1) = x_0;
x2(1) = x_0;
x3(1) = x_0;

A_low = 8;
B_low = 1;
A_mid = 5;
B_mid = 2;
A_high = 10;
B_high = 15;

% Fixed point function
fixed_point = @(B, A) [0, log(B)/A];
% model = @(n) B * n * exp(n * -A);
% fixed_point_equation = @(n) n - model(n);
% fixed_point = fzero(fixed_point_equation, 0);
% disp(['Fixed Point: ', num2str(fixed_point)]);

x_fixed1 = fixed_point(B_low, A_low);   % [0, ln(B_low)/A_low]
x_fixed2 = fixed_point(B_low, A_high);
x_fixed3 = fixed_point(B_high, A_low);
x_fixed4 = fixed_point(B_high, A_high);

disp(['Fixed points for B_low, A_low: ', num2str(x_fixed1)]);
disp(['Fixed points for B_low, A_high: ', num2str(x_fixed2)]);
disp(['Fixed points for B_high, A_low: ', num2str(x_fixed3)]);
disp(['Fixed points for B_high, A_high: ', num2str(x_fixed4)]);

for n=1: N
    x(n+1) = B_low * x(n) * exp(x(n) * -A_low);
    x1(n+1) = B_low * x(n) * exp(x1(n) * -A_high);
    x2(n+1) = B_high * x(n) * exp(x2(n) * -A_low);
    x3(n+1) = B_high * x(n) * exp(x3(n) * -A_high);
end


% Plot all x_n for range 1:N
figure;
plot(0: N, x, 'ro-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles (A = %.2f, B = %.2f)",N ,A_low, B_low));

% Plot all x_n for range 1:N
figure;
plot(0: N, x1, 'mo-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles (A = %.2f, B = %.2f)",N ,A_high, B_low));

% % Plot all x_n for range 1:N
figure;
plot(0: N, x2, 'ro-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles (A = %.2f, B = %.2f)",N ,A_low, B_high));

figure;
plot(0: N, x3, 'go-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles (A = %.2f, B = %.2f)",N ,A_high, B_high));