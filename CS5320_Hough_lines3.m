function lines = CS5320_Hough_lines3(im,H,thresh)
% CS5320_Hough_lines2 - produce mask with lines
% On input:
%     im (mxn array): gray level image
%     H (rxt array): Hough accumulator (from CS5320_Hough)
%     thresh (int): minumum number of votes for line
% On output:
%     lines (mxn array): lines mask (gray is line number)
% Call:
%     lines = CS5320_Hough_lines3(hall4g,H4,70);
% Author:
%     Rajiv Mantena     u1007484
%     UU
%     Spring 2016
%

my_matrix = []; temp = [];
max_H = max(max(H));

[r theta] = size(H);
for a = 1:r
    for b = 1:theta
        if H(a,b) > thresh % *max_H
            my_matrix = [my_matrix;a b];
        end
    end
end
my_im = zeros(size(im));
[a b] = size(my_im);
for u = 1:size(my_matrix,1)
    my_r = my_matrix(1,1)-r/2; my_theta = my_matrix(1,2);
    % for n = 1:size(pts,1)
    % my_x = pts(1,1); my_y = pts(1,2);
    %    my_im(my_x,my_y) = 
    for x = 1:a
        for y = 1:b
            % temp = [temp; x*cosd(my_theta)+ y*sind(my_theta) + my_r];
            temp = x*cosd(my_theta) + -y*sind(my_theta) + my_r;
            if (round(temp) < 2 && round(temp) > -2 )
                my_im(x,y) = 1;
            end
        end
    end
end

lines = my_im;


