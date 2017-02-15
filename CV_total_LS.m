function [p,s] = CV_total_LS(x,y)
%
%CV_total_LS - total least squares method to fit best line to points
%    (Forsyth and Ponce page 335
%On input:
%     x (nx1 vector): x coordinates of points
%     y (nx1 vector): y coordinates of points
%On output:
%     p (1x3 vector): coefficients of best fit line  ax + by + c = 0
%     s (float): error measure (sum of squares of distances
%                of points to line)
%Call:
%     [p1,s1] =  CV_total_LS([1,2,3],[1,2,3]);
%Author:
%     Rajiv Mantena     u1007484
%     UU
%     Spring 2016
%
% find Means
x_bar = mean(x);
y_bar = mean(y);
x2_bar = mean(x.*x);
y2_bar = mean(y.*y);
xy_bar = mean(x.*y);

% Find the u matrix
myMatrix = [(x2_bar-x_bar*x_bar) (xy_bar-x_bar*y_bar);...
            (xy_bar-x_bar*y_bar) (y2_bar-y_bar*y_bar)];

% Solve for the Eigen Values & Vectors
[vectors, values] = eigs(myMatrix);
min_value = 100;     min_count = 0;
for n = 1:size(values,1)
    if values(n,n) < min_value
        min_value = values(n,n);
        min_count = n;
    end
end

if min_count == 0           % Condition not usually possible 
    display('Error!! : Cannot find the least squares :(');
else
                            % Get the Eigen Vector with least Eigen Value
    myVector = vectors(:,min_count);
    a = myVector(1); b = myVector(2);
    c = -a*x_bar -b*y_bar;  % Find C 
end
p = [a b c];                % Form P array
error = [];
for n = 1:size(x,2)         % Find the error mmeasure
    error = [error;(a*x(n)+b*y(n)+c)^2];
end
s = sum(error);             