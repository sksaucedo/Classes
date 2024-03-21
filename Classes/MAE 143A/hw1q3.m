%% Question 3)

clear; syms L1 L2 L3 L4 L5 L6 L7 L8 L9 x y z u
eqn1= L1*x + L2*y == 0;
eqn2= L3*x + L4*y + L5*z == 0;
eqn3= L6*x + L7*y + L8*z == L9*u;
sol=solve(eqn1,eqn2,eqn3,x,y,z); G = sol.y/u

syms sig xbar zbar ybar b s
G = subs(sol.y/u, {L1,L2,L3,L4,L5,L6,L7,L8,L9},{s+sig, -sig, zbar, s+1, xbar, -ybar, -xbar, s+b, -b});
[numG,denG] = numden(G);
numG = coeffs(numG,s);
denG = coeffs(denG,s);
numG = simplify(numG/denG(end));
denG = simplify(denG/denG(end));

numG = numG(end:-1:1);
denG = denG(end:-1:1);
