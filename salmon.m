clear; clc; close all;

% 1 < alpha * (t_e - t_0) < 10

% Ranges to test
% B
% alpha * (t_e - t_0) = 1.5
% alpha * (t_e - t_0) = 3
% alpha * (t_e - t_0) = 5
% alpha * (t_e - t_0) = 7
% alpha * (t_e - t_0) = 9

% Proportionality constant
% - larvae decay due to cannabilism
% alpha = 1.5;
alpha = 7;
t_0 = 0.0
t_e = 1.0;


% 3 < beta * gamma < 20

% Ranges to test
% A
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
beta = 18.0;

% Proportionality constant 
% - survival ratio of mature larvae
gamma = 1.0;

% Fixed point calculation
x_star = log(gamma * beta) / alpha * (t_e - t_0)

% Simulation over N cycles

% Initial salmon population of 1 hundred million
x_0 = 0.01;

% N - number of cycles
N = 50;

% Result array - initially all 0
% Set result of cycle n at x(n)
x = zeros(N, 1);

% Init initial result for 1st cycle
x(1) = x_0;

for n=1: N
    x(n+1) = gamma * beta * x(n) * exp(-alpha * x(n) * (t_e - t_0));
end


% Plot all x_n for range 1:N
figure;
plot(0: N, x, 'bo-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
title(sprintf("Salmon population over N=%d cycles (alpha = %.2f, beta = %.2f, gamma = %.2f)", N, alpha, beta, gamma));
