%% HW 4

%% Question 1a:
clear;
num = [1, -1];
den = [1, 1];
sys = tf(num, den);

% Plot the Bode plot
bode(sys);

grid on;
title('Bode Plot of FAP1(s) = (s-1)/(s+1)');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB) / Phase (degrees)');

%% Question 1d:
num_Y = [1, 0];
den_Y = [1, 0];
sys_Y = tf(num_Y, den_Y);
sys_f = sys / sys_Y;

% Plot the step response
figure;
step(sys_f);
grid on;
title('Step Response of Z(s)/Y(s)');
xlabel('Time');
ylabel('Amplitude');


%% Question 2b:
syms wc zeta1 zeta2 s;

% F2a(s):
zeta1 = 0.77/2;
denominator1 = s^2 + 2*zeta1*wc*s + wc^2;
poles1 = solve(denominator1, s);

% F2b(s):
zeta2 = 1.85/2;
denominator2 = s^2 + 2*zeta2*wc*s + wc^2;
poles2 = solve(denominator2, s);

%% Question 2c:
% Plot bode plots.
% Assume wc = 1.
wc = 1;
denominatorv1 = [1, 2*zeta1*wc, wc^2];
denominatorv2 = [1, 2*zeta2*wc, wc^2];
figure;
bode(tf(wc^2, denominatorv1));
hold on;
bode(tf(wc^2, denominatorv2));
legend('F2a(s)','F2b(s)');
numeratorf4 = conv(wc^2, wc^2);
denominatorf4 = conv(denominatorv1, denominatorv2);
figure;
bode(tf(numeratorf4,denominatorf4));
title('Bode Plot of F4(s)');

grid on;

%% Question 2e:
syms t zeta1 zeta2 wc;
sys_f4 = tf(numeratorf4,denominatorf4);
numerator_Y = 1;
denominator_Y = [1, 0];
sys_Y = tf(numerator_Y,denominator_Y);
sys_Z = sys_f4 * sys_Y;
figure;
step(sys_Z);
title('Step Response of F4(s)');
grid on;

%% Question 3a:
syms v g l a nu

% Define the equation
eq = -g/l * sin(v) - (a^2 * nu^2)/(2*l^2) * sin(v) * cos(v) == 0;

% Solve the equation for v
equilibrium_points_v = solve(eq, v);

%% Question 3b:
syms psi w g l a nu psi_prime w_prime s

% Define the nonlinear equation
nonlinear_eq = -g/l * sin(psi) - (a^2 * nu^2)/(2*l^2) * sin(psi) * cos(psi) + w;

% Equilibrium points determined in 3a
equilibrium_points_psi = [0, pi + acos((2*g*l)/(a^2*nu^2)), pi - acos((2*g*l)/(a^2*nu^2))];
equilibrium_points_w = [0, 0, 0];

% Linearize the equation about each equilibrium point
linearized_eqs = [];

for i = 1:length(equilibrium_points_psi)
    linearized_eq = subs(nonlinear_eq, {psi, w}, {equilibrium_points_psi(i) + psi_prime, equilibrium_points_w(i) + w_prime});
    linearized_eq = simplify(taylor(linearized_eq, [psi_prime, w_prime], 'Order', 2));
    linearized_eqs = [linearized_eqs; linearized_eq];
end

% Display the linearized equations
disp('Linearized Equations:');
disp(linearized_eqs);

% Laplace transform of the linearized equations to find the transfer function
transfer_functions = [];

for i = 1:length(equilibrium_points_psi)
    % Take the Laplace transform
    transfer_function = laplace(linearized_eqs(i), t, s);
    % Simplify the transfer function
    transfer_function = simplify(transfer_function);  
    % Store the transfer function
    transfer_functions = [transfer_functions; transfer_function];
end

% Display the transfer functions
disp('Transfer Functions:');
disp(transfer_functions);

%% Question 3c:
syms psi_prime s

% Linearized equations from 3b for each equilibrium point
linearized_eqs = [ w_prime - psi_prime*(g/l + (a^2*nu^2)/(2*l^2)), (psi_prime*a^4*nu^4 + 2*w_prime*a^2*l^2*nu^2 - 4*psi_prime*g^2*l^2)/(2*a^2*l^2*nu^2), (psi_prime*a^4*nu^4 + 2*w_prime*a^2*l^2*nu^2 - 4*psi_prime*g^2*l^2)/(2*a^2*l^2*nu^2)];

% Eigenvalues for each equilibrium point
eigenvalues = [];

for i = 1:length(linearized_eqs)
    % Coefficients matrix
    coefficients_matrix = coeffs(linearized_eqs(i), psi_prime);
    
    % Extract coefficients
    a = coefficients_matrix(1);
    b = coefficients_matrix(2);
    
    % Characteristic polynomial
    characteristic_poly = det([1, -a; 0, 1]);
    
    % Eigenvalues
    eig_vals = solve(characteristic_poly == 0, s);
    
    % Store the eigenvalues
    eigenvalues = [eigenvalues; eig_vals];
end

% Display the eigenvalues
disp('Eigenvalues for Stability Analysis:');
disp(eigenvalues);
