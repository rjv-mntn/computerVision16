function [H,pts] = CS5320_Hough(imo)
% CS5320_Hough - Hough transform of image
% On input:
%     imo (mxn array): gray-level image
% On output:
%     H (rxt array): Hough accumulator array (r rho values; t theta
%     values)
%        r = [indexes to cover from [-ceil(image diagonal to
%             ceil(image diagonal)]
%        t = [1:180]
%     pts (rxt struct): contains points which contributed to line
%       pts(i,j).pts (kx2 array): k pixels (rows and cols)
% Call:
%     [H4,H4pts] = CS5320_Hough(double(hall4g));
%Author:
%     Rajiv Mantena     u1007484
%     UU
%     Spring 2016
%
edge_param = 0;        points = [];    r_0D = [];
[x y] = size(imo);
diag = sqrt(x^2 + y^2);         % Find diagonal leanght

H = zeros(size((-ceil(diag):ceil(diag)),2),size((1:180),2));
                                % Initialize H array
if(edge_param == 1)
    imo = edge(imo,'canny');    % Apply canny edge filter if necessary
end

for a = 1:x
    for b = 1:y
        if(imo(a,b)==1)
            points = [points;a b];
        end              % Find the prominent point in the edge image
    end
end

pts(size((-ceil(diag):ceil(diag)),2),size((1:180),2)).pts = [];
                        % Initialize pts
wb = waitbar(0,'Hough points');
max_n = size(points,1);
for n = 1:max_n
    waitbar(n/max_n);
    x_0 = points(n,1);  y_0 = points(n,2);
    for theta = 1:180
        r_0 = -(x_0)*cosd(theta) + (y_0)*sind(theta);
                            % Computing r for a gien range of theta
        if r_0 < ceil(diag) && r_0 > -ceil(diag)
            r_0 = r_0 + ceil(diag);
            if round(r_0) ~= 0
               H(round(r_0),theta) = H(round(r_0),theta) + 1;
                            % Increment H if worthy
               my_n = size(pts(round(r_0),theta).pts,1);
               pts(round(r_0),theta).pts(my_n+1,1) = x_0;
               pts(round(r_0),theta).pts(my_n+1,2) = y_0;
                            % Append the row,col value to pts.pts Struct
            end
        end
    end
end
close(wb);