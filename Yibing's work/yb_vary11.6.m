%% Viewing a cylinder across a 2D plane projection
% Imagine have a set of circles that run along a cylinder

% MAKE A CIRCLE ? this can be turned into a function
radius=zeros(1,21);
step = 0.01;
angle = 0:step:2*pi;

xc = 0; yc = 0;         % center point

% Now make many circles in the z-plane
zLevels = 0:20;
distance = 10;
for ind = 1:length(zLevels)
    xp = radius(:,ind)*cos(angle); % perimeter
    yp = radius(:,ind)*sin(angle);
    circle(:,1) = xc + xp;    % the circle
    circle(:,2) = yc + yp;
    radius=1*sin(pi/6*zLevels);
    cylX(:,ind) = circle(:,1);
    cylY(:,ind) = circle(:,2);
    cylZ(:,ind) = zLevels(ind)*ones(size(circle,1),1);
   cylX_mod(:,ind) = circle(:,1)./(10+zLevels(ind));
    cylY_mod(:,ind) = circle(:,2)./(10+zLevels(ind));
    cylPlane(:,ind) = zeros(size(circle,1),1);
    p=sqrt((cylX_mod-xc).^2+(cylY_mod-yc).^2);
    %x0(ind)=p*(10+zLevels(ind));
    circle1(:,1) = cylX_mod(:,ind).*(10+zLevels(ind));
    circle1(:,2) = cylY_mod(:,ind).*(10+zLevels(ind));
    ro(:,ind)=sqrt((circle1(:,1)-xc).^2+(circle1(:,2)-yc).^2);
    
end

% To view

subplot(1,4,1), plot3(cylX,cylY,cylZ);
title('A bunch of circles making a cylinder')
subplot(1,4,2), plot3(cylX_mod,cylY_mod,cylPlane), view(0,90) 
subplot(1,4,3), plot3(10+zLevels,p,cylPlane), view(0,90)
subplot(1,4,4), plot(10+zLevels,ro), view(0,90)

title('Those circles projected onto a plane')

% To project, note that the size of the circle will be a function of its
% distance from the imaging plane. In this case we will treat the distance
% to the first point in the Z axis as the "distance" variable and the
% zLevels will represent additional distance.


%for ind = 1:length(zLevels)
    
    %theta=180/pi*atan((cylY_mod-yc)./(cylX_mod-xc));
%end





