%% sara's edits to barry's original code

%% Making 2D representation of cylinder from known cylinder

% VIEWING A CYLINDER ACROSS A 2D PLANE PROJECTION

% Imagine have a set of circles that run along a cylinder
radius_cylinder = 1; 
xc = 0; 
yc = 0;     
circle=saramakeacircle(radius_cylinder,xc,yc);

% Now make many circles in the z-plane
zLevels = 0:20;
[cylX, cylY, cylZ]=saramakeacylinder(circle, zLevels);

% To view
viewAZ=45; viewEL=250;
subplot(1,2,1), plot3(cylX,cylY,cylZ), view(viewAZ, viewEL);
%title('A bunch of circles making a cylinder')

% PROJECTION OF CYLINDER ONTO 2D PLANE

% Distance "distance" away from the closest end of the tube
distance = 1.5;
%distance=input('Distance from closest circle: ')
[cylX_mod, cylY_mod, cylZ_mod]=saraplaneprojections(circle, zLevels, distance);

% To view
hold on
subplot(1,2,2), plot3(cylX_mod,cylY_mod,cylZ_mod), view(0,90) 
axis([-1 1 -1 1])
%title('Those circles projected onto a plane')


%% Making cylinder representation from 2D picture

% Making the input 2D picture
radius_closestcircle = 1; 
xc = 0; 
yc = 0;     

[circlesX circlesY] = saramakecircleS(radius_closestcircle)

% Finding the circles
% radius_start = 1.5; %set to a reasonable value considering tube size
% radius_find=[-radius_start:0.001:0]
% if radius

 

