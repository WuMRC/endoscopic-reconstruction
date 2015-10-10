function [ circle ] = saramakeacircle( radius_cylinder, xc,yc )
%making a 2D circle

step = 0.01;
angle = 0:step:2*pi;

%xc = 0; yc = 0;         % center point
%xc = linspace(-1,1,21); 
%yc = linspace(-1,1,21);         % center point
xp = radius_cylinder*cos(angle); % perimeter
yp = radius_cylinder*sin(angle);
circle(:,1) = xc + xp;    % the circle
circle(:,2) = yc + yp;

end

