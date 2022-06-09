h = 0.01;
t0 = 0; t1 = 100;
t = t0:h:t1;
sigma = 10; rho=28; beta=8/3;
x = zeros(3, length(t));
x(:, 1) = [-8; 7; 27];
f = @(x) [sigma * (x(2)-x(1)); x(1) * (rho - x(3)) - x(2); x(1) * x(2) - beta * x(3)]
for j = 2:length(t)
    x(:, j) = x(:, j-1) + h .* f(x(:, j-1));
end
plot3(x(1, :), x(2, :), x(3, :));
view([5, -5]);