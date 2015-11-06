%% Viewing a cylinder across a 2D plane projection
% Imagine have a set of circles that run along a cylinder

% MAKE A CIRCLE ? this can be turned into a function
radius=zeros(1,21);
step = 0.01;
angle = 0:step:2*pi;
v=10;
d=5;

xc = 0; yc = 0;         % center point

% Now make many circles in the z-plane
zLevels = 0:20;
for ind = 1:length(zLevels)
    xp = radius(:,ind)*cos(angle); % perimeter
    yp = radius(:,ind)*sin(angle);
    circle(:,1) = xc + xp;    % the circle
    circle(:,2) = yc + yp;
    radius=1*sin(pi/6*zLevels);
    rm = zLevels*v/(d+radius(:,ind));
    rm1=rm;
    cylX(:,ind) = circle(:,1);
    cylY(:,ind) = circle(:,2);
    cylZ(:,ind) = zLevels(ind)*ones(size(circle,1),1);
    
   
end

% To view
subplot(1,4,1), plot3(cylX,cylY,cylZ);
title('A bunch of circles making a cylinder')

% To project, note that the size of the circle will be a function of its
% distance from the imaging plane. In this case we will treat the distance
% to the first point in the Z axis as the "distance" variable and the
% zLevels will represent additional distance.


for ind = 1:length(zLevels)
    xm = rm(:,ind)*cos(angle); % perimeter
    ym = rm(:,ind)*sin(angle);
    circle1(:,1) = xm + xp;    % the circle
    circle1(:,2) = ym + yp;
    cylX_mod(:,ind) = circle1(:,1);
    cylY_mod(:,ind) = circle1(:,2);
    cylPlane(:,ind) = zeros(size(circle1,1),1);
    p=sqrt((cylX_mod-xc).^2+(cylY_mod-yc).^2);
    theta=180/pi*atan((cylY_mod-yc)./(cylX_mod-xc));
end

subplot(1,4,2), plot3(cylX_mod,cylY_mod,cylPlane), view(0,90) 
subplot(1,4,3), plot3(theta,p,cylPlane), view(0,90)
title('Those circles projected onto a plane')
hold on

L=1;
zLevels = 0:20;
for ind = 1:length(zLevels)
    xp = radius(:,ind)*cos(angle); % perimeter
    yp = radius(:,ind)*sin(angle);
    circle(:,1) = xc + xp;    % the circle
    circle(:,2) = yc + yp;
    radius=1*sin(pi/6*zLevels);
    rm1 = (zLevels+L)*v/(d+radius(ind));
    cylX(:,ind) = circle(:,1);
    cylY(:,ind) = circle(:,2);
    cylZ(:,ind) = zLevels(ind)*ones(size(circle,1),1)+L;
    
   
end

L=1
for ind = 1:length(zLevels)
    xm = rm1(:,ind)*cos(angle); % perimeter
    ym = rm1(:,ind)*sin(angle);
    circle1(:,1) = xm + xp;    % the circle
    circle1(:,2) = ym + yp;
    cylX_mod(:,ind) = circle1(:,1);
    cylY_mod(:,ind) = circle1(:,2);
    cylPlane(:,ind) = zeros(size(circle1,1),1);
    p=sqrt((cylX_mod-xc).^2+(cylY_mod-yc).^2);
    theta=180/pi*atan((cylY_mod-yc)./(cylX_mod-xc));
end


subplot(1,4,4), plot3(theta,p,cylPlane), view(0,90)
title('Those circles projected onto a plane')




