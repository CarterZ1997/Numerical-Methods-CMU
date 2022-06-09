function E = MyEdgeDetector2(f, thres)

% (c) Linan Zhang
% Oct 25, 2018

% Inputs: 
%   f = image
%   thres = threshold value for edge detection
% Output:
%   E = edge of the image

% ========================================
% Step 1: Compute derivatives using central differences.
% ========================================
[n,m] = size(f);
Dx = zeros(n,m); % initialize df/dx
Dy = zeros(n,m); % initialize df/dy
% Assume that df/dx = df/dy = 0 on the boundaries.
Dx(2:end-1,:) = (f(3:end,:)-f(1:end-2,:))/2;
Dy(:,2:end-1) = (f(:,3:end)-f(:,1:end-2))/2;
D = sqrt( Dx.^2 + Dy.^2 );

% ========================================
% Step 2: Obtain the edges.
% ========================================
% Rescale the norm of the gradient to be between 0 and 1
D = (D - min(D(:)))/(max(D(:)) - min(D(:)));
% Threshold the norm of gradient to find large jumps in image.
D = (D > thres);
E = double(D); 
% % Thin the binary image D.
% E = bwmorph(E, 'Skel', inf);
end