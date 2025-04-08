
clear; clc; close all;

% We introduce some randomness into our parameters alpha, beta, and gamma to model the variability of external factors such as 

% Our permissable range is defined as follows
% a) 1 < alpha * (t_e - t_0) < 10 - Represent proportion of salmon larvae which reach adulthood in a given cycle 
% b) 3 < beta * gamma < 20        - Represent product of reproduction and youth survival rate of surviving larvae


% We will randomly generate a value in each given range for A and B.
% The randomness of the parameters will mimic the natural randomness in the quality of conditions of the given environment
% We use a normal distribution to generate our random numbers between cycles
% TODO: Should we use a uniform distribution?

% We will 

% A
% - low A value may represent an environmental factor which negatively affects the survival rate of smolts (young adults)  
%   prior to reaching full maturity. 
%   Examples may increased more pollution (man made infrastructure related), or the underrepresentation of a predatory 
%   species in the environment.

% - high A value may represent an environmental factor which positively affects the reproduction rate of adult salmon + survival 
%   rate of larvae between cycles. Examples may include less pollution, or the overfishing of a predatory species.

% B
% - low B value may represent an environmental factor which negatively affects the reproduction rate of adult salmon + survival 
%   rate of larvae between cycles. Examples may increased less pollution, or the overrepresentation of a predatory species in 
%   the environment.
% - high B value may represent an environmental factor which positively affects the reproduction rate of adult salmon + survival 
%   rate of larvae between cycles. Examples may include less pollution, or the overfishing of a predatory species.

% -----------------------------------------------------------------------------------------------------------------------

% Model:
% x(n+1) = gamma * beta * x(n) * exp(-alpha * x(n) * (t_e - t_0));
% x(n+1) = B * x(n) * exp( x(n) * A);

% Simulation over N cycles with randomly selected parameters

% Initial salmon population of 1 hundred million
x_0 = 0.01;

% N - number of cycles
N = 30;

% Result array - initially all 0
% Set result of cycle n at x(n)
x = zeros(N, 1);

A_low = 2;
B_low = 2;
% A_mid = 5;
% B_mid = 2;
% A_high = 8;
% B_high = 18;


A = zeros(N, 1);
A(1) = A_low;

B = zeros(N, 1);
B(1) = B_low;

x(1) = x_0;

for n=1: N
    % Generate random A and B values from permissible ranges
    % a) 1 < A < 10 
    % b) 3 < B < 20
    
    % Calculate model output
    x(n+1) = B(n) * x(n) * exp(x(n) * -A(n));

    % Perturb + update A and B

    % Range: 0-1
    rand_val_A = rand();
    
    if rand_val_A > 0.5
        % Perturb prev A val by +5%
        A(n+1) = 1.05 * A(n);
    else
        % Perturb prev A val by -5%
        A(n+1) = 0.95 * A(n);
    end

    rand_val_B = rand()
    if rand_val_B > 0.5
        % Perturb prev B val by +5%
        B(n+1) = 1.05 * B(n);
    else
        % Perturb prev B val by +5%
        B(n+1) = 0.95 * B(n);
    end
end

% Plot all x_n for range 1:N
figure;
plot(0: N, x, 'bo-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles (A_0 = %.2f, B_0 = %.2f)", N, A(1), B(1)));

figure;
plot(0: N, A, 'bo-');
hold on;
plot(0: N, B, 'ro-');
hold off;

xlabel("Cycle (n)");
ylabel("A & B Values");
grid("on");
title(sprintf("Values of A & B over N=%d cycles", N))
legend({'A', 'B'});







