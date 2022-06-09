
% step 1: load data (check lab 6)
fmat = open('signaldata1.mat');
f = fmat.f;
% step 2: define filter
% (a) Gaussian
sigma = 15;
G = @(x) 1/sqrt(2*pi*sigma^2) * exp(-x.^2 / (2*sigma^2));
% step 3: initialize solution u
T = length(f);
u = zeros(1, T);

s = 1:T;
% step 4: compute the integral
for t=1:T
    % compute G(t-s)
    g = G(t-s);
    % compute the sum
    % use .* to compute f*g
    % ues sum() to compute sum_(j-1)^T or sum_(j-2)^(T-1)
    u(t) = 1/2 * f(1) * g(1) + sum(f(2:T-1).*g(2:T-1)) + 1/2 * f(T) * g(T)
end
% step 5: plot u
plot(u)