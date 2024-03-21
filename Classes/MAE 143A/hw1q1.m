%% Problem 1)

% script RR_Sim_Lorenz
% A simple RK4 simulation of the Lorenz attractor.
%% Renaissance Robotics codebase, Chapter 7, https://github.com/tbewley/RR
%% Copyright 2024 by Thomas Bewley, distributed under BSD 3-Clause License.

clear, close all, T=100; h=0.01; x=2*randn(3,1);             % Set up simulation
plot3(x(1),x(2),x(3),'kx'); view([-65 23]); hold on          % Set up plot
xlabel('x'), ylabel('y'), zlabel('z')
for t=0:h:T
   k1=RHS(x); k2=RHS(x+h*k1/2); k3=RHS(x+h*k2/2); k4=RHS(x+h*k3);
   xnew=x+h*(k1/6+k2/3+k3/3+k4/6);
   plot3([xnew(1) x(1)],[xnew(2) x(2)],[xnew(3) x(3)]);
   x=xnew; pause(0.001);
end

function k=RHS(x)
sig=4; b=1; rbar=3*sig*(sig+b+3)/(sig-b-1);  % Define constants for Lorenz
k=[sig*(x(2)-x(1)); -x(2)-x(1)*x(3); -b*x(3)+x(1)*x(2)-b*rbar];

% For question q1b.
% Plot a * at the each of the three equilibrium points from q.1a.
% xbar.
plot3(sqrt(b*(rbar-1)),sqrt(b*(rbar-1)),-1, '*','Color','r');
% ybar.
plot3(-1*sqrt(b*(rbar-1)),-1*sqrt(b*(rbar-1)),-1, '*','Color','r');
% zbar.
plot3(0,0,-rbar, '*','Color','r');

end