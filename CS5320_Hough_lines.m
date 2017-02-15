function lines = CS5320_Hough_lines(im,H,thresh)
% CS5320_Hough_lines - produce mask with lines
% On input:
%     im (mxn array): gray level image
%     H (rxt array): Hough accumulator (from CS5320_Hough)
%     thresh (int): minumum number of votes for line
% On output:
%     lines (mxn array): lines mask (gray is line number)
% Call:
%     lines = CS5320_Hough_lines(hall4g,H4,70);
% Author:
%     T. Henderson
%     UU
%     Spring 2016
%

% thresh = 0.2;        
lines = zeros(size(im)); 
max_H = max(max(H));
pre_sort = [];
% sort_array = zeros(n,3);

[r theta] = size(H);
for a = 1:r
    for b = 1:theta
        if H(a,b) > thresh %*max_H
        %     lines = [lines;a b];
        pre_sort = [pre_sort;H(a,b) a b];
        end
    end
end
% post_sort = sortrows(pre_sort,-1);
for n = 1:size(pre_sort,1)
    theta = pre_sort(n,3); rho = pre_sort(n,2);
    params(n,1) = cosd(theta);
    params(n,2) = sind(theta);
    params(n,3) = rho;
end
wb = waitbar(0,'lines');
[x y] = size(im);
for a = 1:x
    waitbar(a/x);
    for b = 1:y
        for n = 1:size(params,1)
            temp = a*params(n,1) + b*params(n,2) + params(n,3);
            if (round(temp) < 2 && round(temp) > -2 )
                lines(a) = 1;
            end
        end
    end
end
close(wb);