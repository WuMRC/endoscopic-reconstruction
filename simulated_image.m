%% Viewing a cylinder across a 2D plane projection
% Imagine have a set of circles that run along a cylinder

% MAKE A CIRCLE ? this can be turned into a function
radius = 1;
step = 0.01;
angle = 0:step:2*pi;

xc = 0; yc = 0;         % center point
xp = radius*cos(angle); % perimeter
yp = radius*sin(angle);
circle(:,1) = xc + xp;    % the circle
circle(:,2) = yc + yp;

% Now make many circles in the z-plane
zLevels = 0:20;
for ind = 1:length(zLevels)
    cylX(:,ind) = circle(:,1);
    cylY(:,ind) = circle(:,2);
    cylZ(:,ind) = zLevels(ind)*ones(size(circle,1),1);
end

% To view
subplot(1,2,1), plot3(cylX,cylY,cylZ);
title('A bunch of circles making a cylinder')

% To project, note that the size of the circle will be a function of its
% distance from the imaging plane. In this case we will treat the distance
% to the first point in the Z axis as the "distance" variable and the
% zLevels will represent additional distance.

distance = 10;
for ind = 1:length(zLevels)
    cylX_mod(:,ind) = circle(:,1)./(10+zLevels(ind));
    cylY_mod(:,ind) = circle(:,2)./(10+zLevels(ind));
    cylPlane(:,ind) = zeros(size(circle,1),1);
end

subplot(1,2,2), plot3(cylX_mod,cylY_mod,cylPlane), view(0,90) 
title('Those circles projected onto a plane')

% This code is incomplete. It does not include movement of the center or
% varying sizes of the circles or anything. But it should help you all.
