%% HW 2 Question 1c from '13 Midterm)

clear; syms L1 L2 L3 L4 x y u
eqn1= L1*x + L2*y == u;
eqn2= L3*x + L4*y == u;

sol=solve(eqn1,eqn2,x,y); G = sol.y/u

syms s
G = subs(sol.y/u, {L1,L2,L3,L4},{-1+s^2+11, 19, -19, 8*s^2-41});
[numG,denG] = numden(G);
numG = coeffs(numG,s);
denG = coeffs(denG,s);
numG = simplify(numG/denG(end));
denG = simplify(denG/denG(end));

numG = numG(end:-1:1)
denG = denG(end:-1:1)
