clear; clc; close all;

alpha = 0.5;
t_0 = 0;
t_e = 1;
beta = 5;
gamma = 4;

% Equilibrium calculation
x_star = ln(gamma * beta) / alpha * (t_e - t_0)

% Simulation over N cycles
