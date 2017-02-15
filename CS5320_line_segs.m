function segments = CS5320_line_segs(ime,Hpts,min_len)
% CS5320_line_segs - extract line segments from Hough info
% On input:
%       ime (mxn array): edge image (e.g., output of edge)
%       Hpts (txr array): Hough points array (see Cs5320_Hough)
%           This code is written considering Hpts is the points Struct
%       min_len (int): minimum number of points in segment
% On output:
%       segments (struct vector): segment info
%       (s).pts (kx2 array): row,col points in segment
%       (s).rho (int): rho parameter of line
%       (s).theta (float): theta parameter of line
%       (s).endpt1 (1x2 vector): one endpt of segment
%       (s).endpt2 (1x2 vector): other endpt of segment
% Call:
%       As = CS5320_line_segs(A,HApts,20);
% Author:
%       Rajiv Mantena     u1007484
%       UU
%       Spring 2016
%
segments.pts = [];
segments.rho = 0.0;
segments.theta = 0.0;
segments.endpt1 = [];
segments.endpt2 = [];

[r theta] = size(Hpts);
for a = 1:r             % For all state in (r,theta) space
    for b = 1:theta
        if size(Hpts(a,b).pts,1) > min_len  
                        % If the configuration has required no. of points.
            min_d = 0;
            points = Hpts(a,b).pts;
                        % Assign pts, rho and thetha values
            segments(size(segments,2)+1).pts = Hpts(a,b).pts;
            segments(size(segments,2)).rho = a;
            segments(size(segments,2)).theta = b;
            end_pt1 = [];   end_pt2 = [];
                        % For each point in pts(r,theta)
            for n = 1:size(points,1)
                        % for every other point in pts(r,theta)
                for m = 1:size(points,1)
                        % If the ecludien is higher than previous.
                    if sqrt((points(n,1)-points(m,1))^2+(points(n,2)-points(m,2))^2) > min_d
                        end_pt1 = [points(n,1) points(n,2)];
                        end_pt2 = [points(m,1) points(m,2)];
                        min_d = sqrt((points(n,1)-points(m,1))^2+(points(n,2)-points(m,2))^2);
                    end
                end
            end
                        % Assign end points
            if (size(end_pt1,1)~=0 && size(end_pt2,1)~=0)
                segments(size(segments,2)).endpt1 = end_pt1;
                segments(size(segments,2)).endpt2 = end_pt2;
            end
        end    
    end
end
segments(1) = [];