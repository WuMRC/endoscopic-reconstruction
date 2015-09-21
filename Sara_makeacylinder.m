%{
Rotate a cylinder by angle a
RotX=[1 0 0;0 cos(a) -sin(a);0 sin(a) cos(a)]
RotY=[cos(a) 0 sin(a);0 1 0;-sin(a) 0 cos(a)]
RotZ=[cos(a) -sin(a) 0;sin(a) cos(a) 0;0 0 1]
%}

%{
Waved cylinder 
t = 0:pi/10:2*pi;
figure
[X,Y,Z] = cylinder(2+cos(t));
surf(X,Y,Z)
%}

%{
%make a cylinder height 5 radius 1
[x,y,z]=cylinder(1,100);
z(2,:)=5;
%in z direction
%surf(x,y,z)
%in x direction
surf(z,x,y)
%}

r_1 = 1;
r_2 = 1.2;
segments = 100;
[x1,y1,z1]=cylinder(r_1, segments);
[x2,y2,z2]=cylinder(r_2, segments);
z1(2,:)=5;
z2(2,:)=3;
set(surf(z1,x1,y1,'FaceColor', [0.5,0,0]),'FaceAlpha',0.75,'edgealpha', 0)
%to plot outter surface of vessel
%hold on
%set(surf(z2,x2,y2,'FaceColor', [0.5,0,0]),'FaceAlpha',0.35,'edgealpha', 0)


