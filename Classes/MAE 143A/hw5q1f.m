clear;
clc;

%% Homework 5:
% Question 1 Part F
num = [1];
den = [1, 2, 2, 1];
F_1f = RR_tf(num,den);
RR_C2D_tustin(F_1f,8)