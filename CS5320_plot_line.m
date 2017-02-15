function CS5320_plot_line(p,x1,x2,y1,y2)
% CS5320_plot_line - plots line given parameters
% On input:
%       p (1x3 vector): line parameters (p(1)x + p(2)y + p(3) = 0)
%       x1 (float): first x value
%       x2 (float): second x value
%       if x1 ˜= x2, then plot line from x1 to x2 (calculate y1 and
%       y2)
%       y1 (float): first y value
%       y2 (float): second y value
%       if x1==x2, then plot line from y1 to y2 (calculate x1 and x2)
% On output:
%       plot line
% Call:
%       Cs5320_plot_line(p,0,7,0,0);
% Author:
%       Rajiv Mantena     u1007484
%       UU
%       Spring 2016
%
best_y = [0;0];
if x1 ~= x2             % Condition 1 
    if x2-x1 > 0        % Find starting and stopping x
    	starth = round(x1); stoph = round(x2);
    else
        starth = round(x2); stoph = round(x1);
    end
                        % Compute y based on x values
    y1 = double((p(3) + p(1)*x1)/p(2));
    y2 = double((p(3) + p(1)*x2)/p(2));
    if y2-y1 > 0        % Find starting and stopping y
    	startv = round(y1); stopv = round(y2);
    else
        startv = round(y2); stopv = round(y1);
    end                 % Form an empty image
    image = zeros(stoph-starth,stopv-startv);
    for a = 1:size(starth:stoph,2)
        for b = 1:size(startv:stopv,2)
            if (abs(p*[a b 1]')) < 1
                        % Append values
                image(a,b) = 1;
            end    
        end    
    end 
else                    % Condition 2
    if y2-y1 > 0        % Find starting and stopping y
    	startv = round(y1); stopv = round(y2);
    else
        startv = round(y2); stopv = round(y1);
    end
                        % Compute x based on y values
    x1 = double((p(3) + p(2)*y1)/p(1));
    x2 = double((p(3) + p(2)*y2)/p(1));
    if x2-x1 > 0        % Find starting and stopping x
    	starth = round(x1); stoph = round(x2);
    else
        starth = round(x2); stoph = round(x1);
    end
                        % Form an empty image
    image = zeros(stoph-starth,stopv-startv);
    for a = 1:size(starth:stoph,2)
        for b = 1:size(startv:stopv,2)
            if (abs(p*[a b 1]')) < 1
                           % Append values
                image(a,b) = 1;
            end    
        end    
    end
end
imshow(image);
k = 1;
