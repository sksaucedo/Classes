%% HW 3

%% Question 4:
clear;

% Setup parameters using equation from problem 1.
syms K
M = 1000;
omega_n = 2 * pi;

K_value = solve(omega_n^2 == K / M, K);
K_value = double(K_value);
disp(['The value of K for a 1-second period: ', num2str(K_value)]);

% Create transfer function for the building
G_building = tf([K_value], [M, 0, 0]);

% Plot Bode plot
figure;
bode(G_building);
title('Bode Plot of the Building');

m = 100;
k =  K_value;
c =  0;

% Create transfer function for the combined system
G_combined = tf([k, c], [m, c, k, K_value, 0]);

% Plot Bode plot
figure;
bode(G_combined);
title('Bode Plot of the Combined System');

% Plot step response
figure;
step(G_combined);
title('Step Response of the Combined System');
