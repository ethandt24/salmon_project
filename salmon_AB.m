clear; clc; close all;


% 1 < alpha * (t_e - t_0) < 10

% Proportionality constant
% - larvae decay due to cannabilism
% alpha = 1.5;
A = 4;
A_low = 4;
A_high = 10;
t_0 = 0.0;
t_e = 1.0;


% 3 < beta * gamma < 20

% Proportionality constant for y(n)
% - reproduction rate
B = 18;
B_low = 5;
B_high = 7;

% Fixed point calculation
function fixed_point_sol = fixed_point(Astar, Bstar)
    model = @(n) Bstar * n * exp(n * -Astar);
    fixed_point_equation = @(n) n - model(n);
    fixed_point_sol = fzero(fixed_point_equation, log(Bstar)/Astar);
end

x_fixed = fixed_point(A, B);
x_fixed1 = fixed_point(B_low, A_low);   % [0, ln(B_low)/A_low]
x_fixed2 = fixed_point(B_low, A_high);
x_fixed3 = fixed_point(B_high, A_low);
x_fixed4 = fixed_point(B_high, A_high);

disp(['Fixed points for B, A: ', num2str(x_fixed)]);
disp(['Fixed points for B_low, A_low: ', num2str(x_fixed1)]);
disp(['Fixed points for B_low, A_high: ', num2str(x_fixed2)]);
disp(['Fixed points for B_high, A_low: ', num2str(x_fixed3)]);
disp(['Fixed points for B_high, A_high: ', num2str(x_fixed4)]);


% Simulation over N cycles

% Initial salmon population of 1 hundred million
x_0 = 0.01;


% N - number of cycles
N = 30;

% Result array - initially all 0
% Set result of cycle n at x(n)
x = zeros(N, 1);

x_A_low_B_low = zeros(N, 1);

% Results with higher beta (beta = 18)
x_A_high_B_high = zeros(N, 1);

% Results with higher alpha (alpha = 10, beta = 2)
x_A_high_B_low = zeros(N, 1);
% Results with lower alpha (alpha = 2, beta = 10)
x_A_low_B_high = zeros(N, 1);

% Init initial result for 1st cycle
x(1) = x_0;
x_A_high_B_high(1) = x_0;
x_A_high_B_low(1) = x_0;
x_A_low_B_high(1) = x_0;
x_A_low_B_low(1) = x_0;

for n=1: N
    x(n+1) = B * x(n) * exp(x(n) * -A);
    x_A_low_B_low(n+1) = B_low * x_A_low_B_low(n) * exp(x_A_low_B_low(n) * -A_low);
    x_A_high_B_low(n+1) = B_low * x_A_high_B_low(n) * exp(x_A_high_B_low(n) * -A_high);
    x_A_low_B_high(n+1) = B_high * x_A_low_B_high(n) * exp(x_A_low_B_high(n) * -A_low);
    x_A_high_B_high(n+1) = B_high * x_A_high_B_high(n) * exp(x_A_high_B_high(n) * -A_high);
end


% Plot all x_n for range 1:N
figure;
plot(0: N, x, 'bo-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles (A = %.2f, B = %.2f)", N, A, B));

figure;
plot(0: N, x_A_low_B_low, 'bo-');
hold on
plot(0: N, x_A_high_B_low, 'ro-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles", N));
legend(sprintf("A: %.2f, B: %.2f", A_low, B_low), sprintf("A: %.2f, B: %.2f", A_high, B_low));

figure;
plot(0: N, x_A_low_B_high, 'bo-');
hold on
plot(0: N, x_A_high_B_high, 'ro-');
xlabel("Cycle (n)");
ylabel("Salmon population (hundreds of million)");
grid("on");
title(sprintf("Salmon population over N=%d cycles", N));
legend(sprintf("A: %.2f, B: %.2f", A_low, B_high), sprintf("A: %.2f, B: %.2f", A_high, B_high));





% figure;
% plot(0: N, x_A_low_B_high, 'bo-');
% xlabel("Cycle (n)");
% ylabel("Salmon population (hundreds of million)");
% grid("on");
% title(sprintf("Salmon population over N=%d cycles (A = %.2f, B = %.2f)", N, A_low, B_high));

% figure;
% plot(0: N, x_A_low_B_low, 'bo-');
% xlabel("Cycle (n)");
% ylabel("Salmon population (hundreds of million)");
% grid("on");
% title(sprintf("Salmon population over N=%d cycles (A = %.2f, B = %.2f)", N, A_low, B_low));


% % Plot all x_n for range 1:N
% figure;
% plot(0: N, x_g1, 'bo-');
% hold on

% % Plot all x_n for range 1:N
% plot(0: N, x_A_low_B_low, 'ro-');
% xlabel("Cycle (n)");
% ylabel("Salmon population (hundreds of million)");
% title(sprintf("Salmon population over N=%d cycles", N))
% hold off

% legend(sprintf("A: %.2f, B: %.2f", A_high, B_high), sprintf("A: %.2f, B: %.2f", ));

% Plot all x_n for range 1:N
% figure;
% plot(0: N, x_A_low_B_high, 'bo-');
% hold on

% plot(0: N, x_A_high_B_low, 'ro-');

% plot(0: N, x_A_high_B_high, 'go-');

% xlabel("Cycle (n)");
% ylabel("Salmon population (hundreds of million)");
% title(sprintf("Salmon population over N=%d cycles (gamma = %.2f)", N, gamma))
% hold off

% legend(sprintf("alpha: %.2f, beta: %.2f", alphA_low, betA_high), sprintf("alpha: %.2f, beta: %.2f", alphA_high, betA_low), sprintf("alpha: %.2f, beta: %.2f", alphA_low, betA_low));


