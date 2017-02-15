function lines = CS5320_Hough_draw_pts(im,H,pts,n,dr)
% CS5320_Hough_draw_pts - draws points which contributed to line
% On input:
%     im (mxn array): original image (or edge image)
%     H (rxt array): Hough accumulator array (see CS5320_Hough)
%     pts (rxt struct): record of points in Hough accumulator
%     n (int): number of lines to show (sorted by most points)
%     dr (Boolean): 1 means draw, 0 don’t
% On output:
%     lines (mxn array): mask of n lines
% Call:
%     linesp = CS5320_Hough_draw_pts(hall4g,H4,H4pts,10,1);
% Author:
%     Rajiv Mantena     u1007484
%     UU
%     Spring 2016
%
% Initialize
Thesh = 0.2;        
lines = zeros(size(im)); 
max_H = max(max(H));
pre_sort = [];
sort_array = zeros(n,3);

[r theta] = size(H);
for a = 1:r
    for b = 1:theta
        if H(a,b) > Thesh*max_H
                    % Forming an array for sorting based on H(a,b)
        pre_sort = [pre_sort;H(a,b) a b];
        end
    end
end
                    % Sort based on H(a,b)
post_sort = sortrows(pre_sort,-1);
                    % change variable name
for num = 1:n
    sort_array(num,:) = post_sort(num,:);
end    
                    % find the r and theta for top n
for num = 1:n
    my_r = sort_array(num,2);
    my_theta = sort_array(num,3);
    for p = 1:size(pts(my_r,my_theta).pts,1)
        curr_x = pts(my_r,my_theta).pts(p,1);
        curr_y = pts(my_r,my_theta).pts(p,2);
        lines(curr_x,curr_y) = 1;
                    % Prepare mask
    end
end
                    % If drawing lines is request ? 
if dr == 1
   imshow(lines);
end