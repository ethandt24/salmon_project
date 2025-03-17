clear; clc; close all;

alpha = 0.5;

beta = 5;9i
gamma = 4;
% What should the length of a cycle be? Is this variable
t_0 = 0;
t_e = 1;

% Equilibrium calculation
x_star = log(gamma * beta) / alpha * (t_e - t_0)

% Simulation over N cycles

% Initial salmon population of 1 hundred million
x_0 = 0.01;

% N - number of cycles
N = 100;

% Result array - initially all 0
% Set result of cycle n at x(n)
x = zeros(N, 1);

% Init initial result for 1st cycle
x(1) = x_0;

for n=1: N
    x(n+1) = gamma * beta * exp(-alpha * x(n) * (t_e - t_0));
end


% Plot all x_n for range 1:N
figure;
plot(0: N, x, 'bo-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
title("Salmon population over N=100 cycles " + ...
    "(alpha = %.2f, beta = %.2f, gamma = %.2f", alpha, beta, gamma);
