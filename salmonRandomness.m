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
A = zeros(N, 1);
B = zeros(N, 1);

x(1) = x_0;

for n=1: N
    % Generate random A and B values from permissible ranges
    % a) 1 < A < 10 
    % b) 3 < B < 20
    
    a_lower = 1;    % lower bound of A
    a_upper = 10;   % upper bound of A
    A(n) = a_lower + (a_upper - a_lower) * rand();

    b_lower = 3;    % lower bound of B
    b_upper = 20;   % upper bound of B
    B(n) = b_lower + (b_upper - b_lower) * rand();

    x(n+1) = B(n) * x(n) * exp(x(n) * -A(n));
end

% Plot all x_n for range 1:N
figure;
plot(0: N, x, 'bo-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles", N));

figure;
plot(0: N-1, A, 'bo-');
hold on;
plot(0: N-1, B, 'ro-');
hold off;

xlabel("Cycle (n)");
ylabel("A & B Values");
grid("on");
title(sprintf("Values of A & B over N=%d cycles", N))
legend({'Alpha', 'Beta'});







