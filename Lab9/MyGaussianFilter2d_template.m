% Step 1: (done for you) Read an image.
f = imread('moon.png');
f = im2double(f);
[n, m] = size(f);

% Step 2: Define the Gaussian filter.
sigma = 1; r = 2; % Do not tune the parameters.
G = @(x,y) 1/(2*pi*sigma^2) .* exp(-(x.^2 + y.^2) / (2*sigma^2)) .* (x>=-r) .* (x<=r) .* (y>=-r) .* (y<=r);

% Step 3: Pad the image with additional pixels such that
%   f satisfies the replicate boundary condition
%   i.e.    size(F) = [n+2r, m+2r]
%           F(r+1:r+n, r+1:r+m) = f
% Hint: https://www.mathworks.com/help/images/ref/padarray.html
F = padarray(f, [r r], 'replicate');

% Step 4: Initialize the solution.
u = zeros(n, m)% some array of the same size as f 

% Step 5: (done for you) Create meshgrid.
% Hint: https://www.mathworks.com/help/matlab/ref/meshgrid.html
% Interchange the roles of x and y for images.
[s2,s1] = meshgrid(1:m+2*r,1:n+2*r);

% Step 6: Smooth the data using the composite trapezoidal rule.
for i=1:n
    for j=1:m
    
        % Step 6.1: Compute F(s1, s2) * G(i-s1+r, j-s2+r).
        W = F .* G(i-s1+r, j-s2+r);
        
        % Step 6.2: Compute the components of the integrand.
        % - vertices (4 terms)
        J1 = W(1, 1) + W(end, 1) + W(1, end) + W(end, end);
        % - boundaries (4 sums)
        J2 = sum(W(2:end-1, 1)) + sum(W(2:end-1, end)) + sum(W(1, 2:end-1)) + sum(W(end, 2:end-1));
        % - interior points (1 sum)
        % Hint: https://www.mathworks.com/help/matlab/ref/sum.html
        J3 = sum(sum(W(2:end-1, 2:end-1)));
        
        % Step 6.3: Compute the integral.
        u(i,j) = 1/4 * J1 + 1/2 * J2 + J3;
    end
end

% Step 7: Detect the edges and plot the solution.
% decrease thres from 0.1 to 0.01 and see what happens :P
thres = 0.1
E = MyEdgeDetector2(u, thres); % using the helper funtion

% Step 8: (done for you) Plot the edges.
imagesc(E); colormap(gray);
axis off; axis image;