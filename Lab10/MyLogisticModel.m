h = 0.01;
t0 = 0; t1 = 10;
t = t0:h:t1;
y = zeros(size(t));
y(1) = 0.1; 
f = @(y) y - y^2;
size(y)
for i = 2:length(y)
    y(i) = y(i-1) + h * f(y(i-1));
end
plot(t, y);