% step 1: load data (check lab 6)
fmat = open('signaldata1.mat');
f = fmat.f
% step 2: define filter
% (b) average
r = 15;
G = @(x) 1/(2*r).*(x>=-r).*(x<=r);
% step 3: initialize solution u
T = length(f);
u = zeros(1, T);
s = 1:T;

% step 4: compute the integral
for t=1:T
    g = G(t-s);
    u(t) = sum(f(1:T).*g(1:T));
end
% step 5: plot u
plot(u)