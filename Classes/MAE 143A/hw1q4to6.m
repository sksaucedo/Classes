%% Renaissance Robotics codebase, Chapter 6, https://github.com/tbewley/RR
%% Copyright 2024 by Thomas Bewley, distributed under BSD 3-Clause License.
%% Questions 4-6

clear all; close all; clc; format short;
syms sig xbar zbar ybar b t

% Define the coefficients of the denominator polynomial
p = [1, (b + sig + 1), (xbar^2 + b + sig + b*sig + sig*zbar), sig*(xbar^2 + ybar*xbar + b + b*zbar)];

% Use the RR_roots function to find the roots
denominator_roots = RR_roots(p);

% Display the roots
disp('Denominator roots:');
disp(denominator_roots);
p1 = denominator_roots(1);
p2 = denominator_roots(2);
p3 = denominator_roots(3);

sig = 4;
b = 1;
u = 48;

x{1} = [sqrt(b*(u-1)), sqrt(b*(u-1)), -1];
x{2} = [-sqrt(b*(u-1)) -sqrt(b*(u-1)) -1];
x{3} = [0 0 -u];

for n = 1:3
    xbar = x{n}(1);
    ybar = x{n}(2);
    zbar = x{n}(3);
    root{n}(1) = ((9*(b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/2 - (b + sig + 1)^3 + (3*3^(1/2)*(27*((2*(b + sig + 1)^3)/27 - ((b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/3 + sig*(xbar^2 + ybar*xbar + b + b*zbar))^2 + 4*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2)^3)^(1/2))/2 - (27*sig*(xbar^2 + ybar*xbar + b + b*zbar))/2)^(1/3)/3 - sig/3 - (b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2)/((9*(b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/2 - (b + sig + 1)^3 + (3*3^(1/2)*(27*((2*(b + sig + 1)^3)/27 - ((b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/3 + sig*(xbar^2 + ybar*xbar + b + b*zbar))^2 + 4*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2)^3)^(1/2))/2 - (27*sig*(xbar^2 + ybar*xbar + b + b*zbar))/2)^(1/3) - b/3 - 1/3; 
    root{n}(2) = - b/3 - sig/3 - (((3^(1/2)*1i)/2 + 1/2)*((9*(b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/2 - (b + sig + 1)^3 + (3*3^(1/2)*(27*((2*(b + sig + 1)^3)/27 - ((b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/3 + sig*(xbar^2 + ybar*xbar + b + b*zbar))^2 + 4*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2)^3)^(1/2))/2 - (27*sig*(xbar^2 + ybar*xbar + b + b*zbar))/2)^(1/3))/3 - (((3^(1/2)*1i)/2 - 1/2)*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2))/((9*(b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/2 - (b + sig + 1)^3 + (3*3^(1/2)*(27*((2*(b + sig + 1)^3)/27 - ((b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/3 + sig*(xbar^2 + ybar*xbar + b + b*zbar))^2 + 4*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2)^3)^(1/2))/2 - (27*sig*(xbar^2 + ybar*xbar + b + b*zbar))/2)^(1/3) - 1/3; 
    root{n}(3) = - b/3 - sig/3 + (((3^(1/2)*1i)/2 - 1/2)*((9*(b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/2 - (b + sig + 1)^3 + (3*3^(1/2)*(27*((2*(b + sig + 1)^3)/27 - ((b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/3 + sig*(xbar^2 + ybar*xbar + b + b*zbar))^2 + 4*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2)^3)^(1/2))/2 - (27*sig*(xbar^2 + ybar*xbar + b + b*zbar))/2)^(1/3))/3 + (((3^(1/2)*1i)/2 + 1/2)*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2))/((9*(b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/2 - (b + sig + 1)^3 + (3*3^(1/2)*(27*((2*(b + sig + 1)^3)/27 - ((b + sig + 1)*(xbar^2 + b + sig + b*sig + sig*zbar))/3 + sig*(xbar^2 + ybar*xbar + b + b*zbar))^2 + 4*(b + sig + b*sig + sig*zbar - (b + sig + 1)^2/3 + xbar^2)^3)^(1/2))/2 - (27*sig*(xbar^2 + ybar*xbar + b + b*zbar))/2)^(1/3) - 1/3;
end


%% 6B)
for n = 1:2
    xbar = x{n}(1);
    ybar = x{n}(2);
    zbar = x{n}(3);
    c1(n) = root{n}(1);
    c2(n) = root{n}(2);
    c3(n) = root{n}(3);
    bo(n) = b*sig*xbar/(-c1(n)*c2(n)*c3(n));
    b1(n) = b*xbar/((c1(n)-c2(n))*(c1(n)-c3(n))) + b*sig*xbar/...
        ((c1(n))*(c1(n)-c2(n))*(c1(n)-c3(n)));
    b2(n) = b*xbar/((c2(n)-c1(n))*(c2(n)-c3(n))) + b*sig*xbar/...
        ((c2(n))*(c2(n)-c1(n))*(c2(n)-c3(n)));
    b3(n) = b*xbar/((c3(n)-c1(n))*(c3(n)-c2(n))) + b*sig*xbar/...
        ((c3(n))*(c3(n)-c1(n))*(c3(n)-c2(n)));
end
t = 1:0.1:10;
for T = 1:length(t)
    y1(T) = bo(1) + b1(1)*exp(c1(1)*t(T)) + b2(1)*exp(c2(1)*t(T)) + b3(1)*exp(c3(1)*t(T));
end
figure(1)
hold on;
plot(t,y1)

for T = 1:length(t)
    y2(T) = bo(2) + b1(2)*exp(c1(2)*t(T)) + b2(2)*exp(c2(2)*t(T)) + b3(2)*exp(c3(2)*t(T));
end
figure(21)
hold on;
plot(t,y2)


